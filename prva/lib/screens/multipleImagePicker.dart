import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class MultipleImagePicker extends StatefulWidget {
  const MultipleImagePicker ({super.key});

  @override
  State<MultipleImagePicker > createState() => _MultipleImagePickerState();
}

class _MultipleImagePickerState extends State<MultipleImagePicker> {
  final ImagePicker imagePicker = ImagePicker();
  List <XFile> imageFileList = [];
  void selectedImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if(selectedImages!.isNotEmpty){
      imageFileList.addAll(selectedImages);
    }

    setState(() {
      
    });
  }



   Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(
          title: Text('Multiple image picker'),
          ),
        body: Center(
          child: Column(
            ),
        ),
      );
   }

}

