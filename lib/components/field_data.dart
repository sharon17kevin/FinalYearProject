import 'package:dotted_border/dotted_border.dart';
import 'package:final_project/controllers/field_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldData extends StatefulWidget {
  @override
  _FieldDataState createState() => _FieldDataState();
}

class _FieldDataState extends State<FieldData> {
  FieldController fieldController = Get.put(FieldController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Last Field Data',
              style: GoogleFonts.bebasNeue(
                  color: Colors.greenAccent,
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          DottedBorder(
            strokeWidth: 2,
            dashPattern: [10,6],
            color: Colors.greenAccent,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Obx(
                      () => Column(
                        children: [
                          Text("Nitrogen : ${fieldController.myField.n}  "),
                          Text("Phosphorous : ${fieldController.myField.p}  "),
                          Text("Potassium : ${fieldController.myField.k}  "),
                          Text("Temperature : ${fieldController.myField.temp}  ")
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Obx(
                      () => Column(
                        children: [
                          Text("Humidity = ${fieldController.myField.hum}  "),
                          Text("Rainfall = ${fieldController.myField.rain}  "),
                          Text("pH = ${fieldController.myField.ph}  "),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
