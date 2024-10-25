import 'dart:convert';
import 'package:final_project/components/drop_downs.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:final_project/models/fields.dart';
import 'package:final_project/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:final_project/controllers/field_controller.dart';


class DataManager extends StatefulWidget {
  @override
  _DataManagerState createState() => _DataManagerState();
}

Future<Map<String, dynamic>> loadJsonFile() async {
  final jsonString = await rootBundle.loadString('crop.json');
  Map<String, dynamic> data = json.decode(jsonString);
  return data;
}

class _DataManagerState extends State<DataManager> {
  late SingleValueDropDownController oneYearAgo;
  late SingleValueDropDownController twoYearAgo;
  late SingleValueDropDownController threeYearAgo;

  late SingleValueDropDownController oneCont;
  late SingleValueDropDownController twoCont;
  late SingleValueDropDownController threeCont;

  @override
  void initState() {
    // TODO: implement initState
    oneYearAgo = SingleValueDropDownController();
    twoYearAgo = SingleValueDropDownController();
    threeYearAgo = SingleValueDropDownController();
    oneCont = SingleValueDropDownController();
    twoCont = SingleValueDropDownController();
    threeCont = SingleValueDropDownController();
    cropName = [];
    cropFamily = [];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    oneCont.dispose();
    twoCont.dispose();
    threeCont.dispose();
    oneYearAgo.dispose();
    twoYearAgo.dispose();
    threeYearAgo.dispose();
    super.dispose();
  }

  late List<String> cropName;
  late List<String> cropFamily;

  late Field field;
  final FieldController fieldController = Get.find<FieldController>();

  Map<String, bool> dict = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
          color: Colors.white,),
          onPressed: (){
            Get.to(() => HomeScreen());
          },
        ),
        centerTitle: true,
        title: Text(
          'Data Manager',
          style: GoogleFonts.bebasNeue(
            fontSize: 25,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        'Select Crops To Add To Rotation',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        'Enter Crop History',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child:Row(
              children: [
                Expanded(
                  child: Container(
                    child: FutureBuilder(
                      future: loadJsonFile(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          Map<String, dynamic>? data = snap.data;
                          var items = data?.keys.toList();
                          if (dict.isEmpty) {
                            dict = Map.fromIterable(
                              items!,
                              key: (key) => key,
                              value: (key) => true,
                            );
                          }
                          return ListView.builder(
                            itemCount: items?.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = items![index];
                              final key = dict.keys.elementAt(index);
                              return CheckboxListTile(
                                activeColor: Colors.greenAccent.withOpacity(0.3),
                                checkColor: Colors.black54,
                                //selectedTileColor: Colors.yellow,
                                title: Text(
                                  key,
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                                value: dict[key],
                                onChanged: (value){
                                  setState(() {
                                    dict[key] = value!;
                                  });
                                },
                              );
                            },
                          );
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                    ,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CircleAvatar(
                            radius: 85,
                            backgroundColor: Colors.greenAccent,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage: AssetImage('images/bulls.jpg'),
                            ),
                          ),
                        ),
                        Text('Please enter the last three crops cultivated field',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 15,
                            letterSpacing: 2,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: oneYearAgo,
                                  textFieldDecoration: InputDecoration(
                                    labelText: 'Last Crop',
                                    hintText: 'Enter the last crop grown',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      cropName.add(oneYearAgo.dropDownValue?.value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },

                                  dropDownList: cropNames,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: oneCont,
                                  clearOption: true,
                                  textFieldDecoration: InputDecoration(
                                      hintText: 'Pick the family name of crop',
                                      label: Text('Family Name')
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cropFamily.add(oneCont.dropDownValue?.value);
                                    });
                                  },
                                  dropDownList: family,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: twoYearAgo,
                                  textFieldDecoration: InputDecoration(
                                    labelText: 'Last Crop',
                                    hintText: 'Enter the last crop grown',
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cropName.add(twoYearAgo.dropDownValue?.value);
                                    });
                                  },
                                  dropDownList: cropNames,
                                ),
                              ),
                            ),
                            Expanded(
                              child:  Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: twoCont,
                                  clearOption: true,
                                  textFieldDecoration: InputDecoration(
                                      hintText: 'Pick the family name of crop',
                                      label: Text('Family Name')
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cropFamily.add(twoCont.dropDownValue?.value);
                                    });
                                  },
                                  dropDownList: family,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: threeYearAgo,
                                  textFieldDecoration: InputDecoration(
                                    labelText: 'Last Crop',
                                    hintText: 'Enter the last crop grown',
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cropName.add(threeYearAgo.dropDownValue?.value);
                                    });
                                  },
                                  dropDownList: cropNames,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: DropDownTextField(
                                  controller: threeCont,
                                  clearOption: true,
                                  textFieldDecoration: InputDecoration(
                                      hintText: 'Text family name of crop',
                                      label: Text('Family Name')
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Required field";
                                    }else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      cropFamily.add(threeCont.dropDownValue?.value);
                                    });
                                  },
                                  dropDownList: family,
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: ElevatedButton(
                            child: Text('Save Field'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            onPressed: () async {
                              await fieldController.fetchField();
                              field = fieldController.myField;
                              field.history = cropName;
                              fieldController.updateField(field);
                              Get.to(() => HomeScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
