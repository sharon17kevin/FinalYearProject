import 'dart:convert';
import 'dart:html';
import 'package:final_project/models/fields.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/functions/functions.dart';
import 'package:final_project/models/analysisModel.dart';

class AnalysisController extends GetxController {
  var _cropProb = [].obs;

  List<dynamic> get myProb => _cropProb.value;

  void updateAnalysis(List<dynamic> cropProb) {
    _cropProb.value = cropProb;
  }

  @override
  void onInit() {
    final box = GetStorage();
    if (box.hasData('myProb')) {
      _cropProb.value = box.read('myProb');
    }
    ever(_cropProb, (value) => box.write('myProb', value));
    super.onInit();
  }

  fetchInitialAnalysis(index) async{
    try{
      List response = Field.rotationPlan[index].step;
      updateAnalysis(response);
    }catch(error) {
      throw Exception(error);
    }
  }
}