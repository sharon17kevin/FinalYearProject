import 'package:final_project/models/fields.dart';

class RotationStep {
  Field field;
  Map step;
  int index;
  static int _numInstances = 0;

  RotationStep({required this.field, required this.step, required this.index}) {
    _numInstances++;
    if (_numInstances > 5) {
      throw Exception("Maximum number of instances reached.");
    }
  }
}