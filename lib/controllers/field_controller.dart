import 'dart:convert';
import 'package:final_project/models/fields.dart';
import 'package:final_project/screens/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:final_project/functions/functions.dart';

class FieldController extends GetxController {
  var _field = Field(n: 0, p: 0, k: 0, temp: 0.0, hum: 0.0, rain: 0.0, ph: 0.0, crops: [], history: []).obs;
  var _flag = false.obs;

  bool get myFlag => _flag.value;

  Field get myField => _field.value;

  void updateField(Field field) {
    _field.value = field;
  }

  void updateFlag(bool flag) {
    _flag.value = flag;
  }

  @override
  void onInit() {
    final box = GetStorage();
    if (box.hasData('myField')) {
      _field.value = box.read('myField');
    }
    ever(_field, (value) => box.write('myField', value));
    super.onInit();
  }

  fetchField() async {
    try{
      var response = await fetchFieldData('http://localhost:5000/field');
      var newField = jsonDecode(response);
      var field = Field.fromJson(newField);
      updateField(field);
    }catch(error) {
      throw Exception(error);
    }
  }

  fetchUpdateField(land) async {
    try{
      var map = land.toJson();
      var response = await updateFieldData('http://localhost:5000/field/update', map);
      var newField = jsonDecode(response);
      var field = Field.fromJson(newField);
      updateField(field);
    }catch(error) {
      throw Exception(error);
    }
  }

  Future<void> generateInitialRotation(land) async {
    try{
      var map = land.toJson();
      var response = await fetchInitialPlan('http://localhost:5000/plan', map);
      Rotation rotation = rotationFromJson(response);
      var field = rotation.field;
      Field.rotationPlan.add(rotation);
      print(field.history);
      updateField(field);
    }catch(error) {
      throw Exception(error);
    }
  }

  Future<void> generateSingleRotation(index) async {
    try{
      var land = _field.value;
      var map = land.toJson();
      var response = await fetchSinglePlan('http://localhost:5000/step', map, index);
      var newField = jsonDecode(response);
      var field = Field.fromJson(newField);
      updateField(field);
    }catch(error) {
      throw Exception(error);
    }
  }
}