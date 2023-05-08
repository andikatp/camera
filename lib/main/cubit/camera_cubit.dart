import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  Future<void> selectImage(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    final imageSource = await _getImageSource(context);
    if (imageSource == null) {
      return;
    }
    final pickedFile = await imagePicker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    }
    final image = XFile(pickedFile.path);
    emit(CameraLoaded(image));
  }

  Future<ImageSource?> _getImageSource(BuildContext context) async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
