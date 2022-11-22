import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerController extends GetxController{
  Rx<PlatformFile> file = PlatformFile(name: 'nothing', size: 0).obs;
}