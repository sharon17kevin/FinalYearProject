import 'package:final_project/components/probability_tile.dart';
import 'package:final_project/controllers/analysis_controller.dart';
import 'package:final_project/controllers/field_controller.dart';
import 'package:final_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import 'data_manager.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final AnalysisController analysisController = Get.find<AnalysisController>();

  Map<String, bool> dict = {};

  @override
  Widget build(BuildContext context) {
    final Map data = Get.arguments;
    final String name = data['crop'];
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
        title: Text('Full Analysis',
          style: GoogleFonts.bebasNeue(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 20
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
                  child: Container(
                    child: Center(
                      child: Text(
                        'Crops and their suitability score',
                        style: GoogleFonts.bebasNeue(
                          letterSpacing: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Companion Crops',
                        style: GoogleFonts.bebasNeue(
                          letterSpacing: 2,
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
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: analysisController.myProb.length,
                      itemBuilder: (context, index){
                        return GetBuilder<AnalysisController>(
                          builder: (_) => ProbabilityTile(
                                crop: analysisController.myProb[index][0],
                                score:analysisController.myProb[index][1],
                              ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FutureBuilder(
                      future: loadJsonFile(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          Map<String, dynamic>? data = snap.data;
                          List<dynamic> crops = data?[name]['companion'];
                          return ListView.builder(
                            itemCount: crops.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text( crops[index],
                                      style: GoogleFonts.bebasNeue(
                                        fontSize: 15,
                                        color: Colors.black54,
                                    ),
                                )
                              );
                            },
                          );
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      ,
    );
  }
}
