import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    try{
    if(selectedImages.isNotEmpty){
      imageFileList.addAll(selectedImages);
    }
    }on PlatformException catch (e){
      print('Failed to pick the image: $e');
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
            child: Column(children: <Widget> [
               Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0) ,
                  child: GridView.builder(
                    itemCount: imageFileList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3 ), 
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(imageFileList[index].path), fit: BoxFit.cover,);}
                      ),
                      ),
                      ),
                      SizedBox(height:  20.0,),
                      ElevatedButton(
                        onPressed: () async {
                         selectedImage();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          'Upload Image',
                          style: TextStyle(color: Colors.white),
                        ),
            ),
            ],) 
        ),
      );
   }

}

