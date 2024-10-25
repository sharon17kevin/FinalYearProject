import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CropPlanController extends GetxController {
  final _crop = [].obs;

  List get myCrop => _crop.value;

  void updatePlan(String crop) {
    _crop.add(crop);
  }

  @override
  void onInit() {
    final box = GetStorage();
    if (box.hasData('myCrop')) {
      _crop.value = box.read('myCrop');
    }
    ever(_crop, (value) => box.write('myCrop', value));
    super.onInit();
  }
}
