import 'package:final_project/components/drawer.dart';
import 'package:final_project/components/field_data.dart';
import 'package:final_project/components/slide.dart';
import 'package:final_project/controllers/field_controller.dart';
import 'package:final_project/models/fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:final_project/controllers/crop_plan_controller.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FieldController fieldController = Get.put(FieldController());
  final CropPlanController cropPlanController = Get.put(CropPlanController());
  final CarouselController carouselController = Get.put(CarouselController());
  late Field field;

  var activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Crop Rotation',
          style: GoogleFonts.bebasNeue(
            fontSize: 25,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.greenAccent,
      ),
      drawer: WhiteDrawer(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FieldData(),
                  Center(
                    child: Obx(
                        ()=> ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                            'Generate Crop Rotation'
                        ),
                        onPressed:fieldController.myFlag? (){} : () async {
                          field = fieldController.myField;
                          await fieldController.generateInitialRotation(field);
                          field = fieldController.myField;
                          cropPlanController.updatePlan(field.crops.last);
                          fieldController.updateFlag(true);
                          carouselController.jumpToPage(activeIndex);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Obx(
                    () => CarouselSlider.builder(
                            itemCount: cropPlanController.myCrop.length,
                            carouselController: carouselController,
                            itemBuilder: (context, index, realIndex) {
                              Field field = fieldController.myField;
                              activeIndex = cropPlanController.myCrop.length - 1;
                              return Obx(
                                () => Slide(
                                  crop: cropPlanController.myCrop.isEmpty? "Null" : cropPlanController.myCrop[index],
                                  number: index,
                                  field: field,
                                  firstColor: index == activeIndex? Colors.greenAccent : Colors.white.withOpacity(0.9),
                                  secondColor: index == activeIndex? Colors.blueGrey : Colors.greenAccent,
                                  thirdColor: index == activeIndex? Colors.white : Colors.black54,
                                ),
                              );
                            },
                            options: CarouselOptions(
                              initialPage: cropPlanController.myCrop.length -1 ,
                              pageSnapping: true,
                              viewportFraction: 0.35,
                                height: 205,
                                autoPlay: false,
                                enlargeCenterPage: false,
                                enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }
                            )
                      )
                ),
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: Text(
            'Field History',
            textAlign: TextAlign.center,
          )
        ),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
        onPressed: () {

        },
      ),
    );
  }
}
