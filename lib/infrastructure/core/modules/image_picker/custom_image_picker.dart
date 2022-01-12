import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CustomImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource source}) async {
    return _picker.pickImage(source: source);
  }
}
