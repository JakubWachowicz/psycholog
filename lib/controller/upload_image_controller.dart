import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum StorageCollections {
  profileImage,
  backgroundImage
}

class UploadImageController extends GetxController {

  var firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();

  uploadImage(StorageCollections collection, String id) async {

    PermissionStatus status = await Permission.accessMediaLocation.status;
    if (!status.isGranted) {
// The permission is not granted, request it.
      status = await Permission.accessMediaLocation.request();
    }
    var image;
    image = await _imagePicker.pickImage(source: ImageSource.gallery);
    var file = File(image.path);
    if (image != null) {
      await firebaseStorage.ref().child(collection.toString()).child(id).putFile(file);
    } else {
      print('No Image Path Received');
    }
  }
}
