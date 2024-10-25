import 'package:carousel_slider/carousel_controller.dart';
import 'package:final_project/controllers/analysis_controller.dart';
import 'package:final_project/controllers/crop_plan_controller.dart';
import 'package:final_project/controllers/field_controller.dart';
import 'package:final_project/screens/analysis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/fields.dart';

class Slide extends StatefulWidget {
  final String crop;
  final int number;
  final Field field;
  Color firstColor = Colors.white.withOpacity(0.9);
  Color secondColor = Colors.greenAccent;
  Color thirdColor = Colors.black54;
  Slide({
    Key? key,
    required this.crop,
    required this.number,
    required this.field,
    required this.firstColor,
    required this.secondColor,
    required this.thirdColor
  }) : super(key: key);
  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {

  final FieldController fieldController = Get.find<FieldController>();
  final CropPlanController cropPlanController = Get.find<CropPlanController>();
  final CarouselController carouselController = Get.find<CarouselController>();
  //late Field field;
  final AnalysisController analysisController = Get.put(AnalysisController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.secondColor,
        borderRadius: BorderRadius.circular(20)
      ),
      width: 305,
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: widget.firstColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.5,
                      color: widget.secondColor,
                    )
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        'STEP ${widget.number + 1}',
                      style: GoogleFonts.bebasNeue(
                        color: widget.thirdColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text('Main Crop : ',
                            style: GoogleFonts.bebasNeue(
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              letterSpacing: 2,
                              color: widget.thirdColor,
                            ),
                          ),
                          Text(widget.crop,
                            style: GoogleFonts.brawler(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: widget.thirdColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      child: Text('Proceed to Next Step',
                        style: TextStyle(
                          color: widget.thirdColor,
                        ),
                      ),
                      onPressed: (){
                        Get.dialog(
                          SimpleDialog(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Do you want to progress to the next step?',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 15,
                                          letterSpacing: 2
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          child: Text("No"),
                                          onPressed: (){
                                            Get.back();
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Yes"),
                                          onPressed: () async {
                                            try{
                                              Field field = fieldController.myField;
                                              await fieldController.fetchUpdateField(field);
                                              field = fieldController.myField;
                                              await fieldController.generateInitialRotation(field);
                                              field = fieldController.myField;
                                              cropPlanController.updatePlan(field.crops.last);
                                              carouselController.jumpToPage(widget.number);
                                            } catch (ex) {
                                              Get.back();
                                              Get.snackbar(
                                                'Limit Reached',
                                                'Cannot Make Any More Steps',
                                                duration: Duration(seconds: 3),
                                                snackPosition: SnackPosition.BOTTOM,
                                              );
                                            }
                                            Get.back();
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        );
                      },
                    )

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  child: Row(
                    children: [
                      Text('See Full Analysis',
                        style: TextStyle(
                          color: widget.thirdColor
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                        size: 15,
                        color: widget.thirdColor,
                      )
                    ],
                  ),
                  onPressed: () async{
                    await analysisController.fetchInitialAnalysis(widget.number);
                    Get.to(AnalysisScreen(),
                      arguments: {'crop': widget.crop}
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
