import 'dart:io';

import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SchermiProva extends StatefulWidget {
  const SchermiProva({super.key});

  @override
  State<SchermiProva> createState() => _SchermiProvaState();
}

// https://www.youtube.com/watch?v=u52TWx41oU4
//for multiple images: https://stackoverflow.com/questions/63513002/how-can-i-upload-multiple-images-to-firebase-in-flutter-and-get-all-their-downlo
class _SchermiProvaState extends State<SchermiProva> {
  String imageUrl = '';
  /*final metadata = SettableMetadata(customMetadata: {
    'uploaded_by': 'gnegno',
    'description': 'Some description...'
  });*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('schermata di prova')),
      body: Column(children: [
        IconButton(
            onPressed: () async {
              uploadFile();
            },
            icon: Icon(Icons.add_a_photo))
      ]),
    );
  }

  Future uploadFile() async {
    //1: pick image
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    //print('${file?.path}');
    if (file == null) {
      return;
    }
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
//2: upload the image to firebase storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    //print('37');

    try {
      //final File xFile = await File(file!.path).create();
      final fileBytes = await file.readAsBytes();
      //final uploadTask = await referenceImageToUpload.putFile(xFile, metadata);
      final uploadTask = await referenceImageToUpload.putData(fileBytes);
      //print('50');
      //final snapshot = await uploadTask.whenComplete(() {});

      //referenceImageToUpload.putData(data);
      //print('task iniziato');

      //print('4532');

      //USARE QUESTA STRINGA IMAGEURL PER SCARICARE LE IMMAGINI POI --
      // Salvare imageUrl in profili : i profili avranno un attributo "fotoProfilo" di tipo stringa
      //String fotoProfilo = imageUrl (tipo così)
      //quando poi mi serve stampare la foto faccio il widget di tipo Image.network(imageUrl)
      imageUrl = await referenceImageToUpload.getDownloadURL();

      //print('45 schermi');
      //print(imageUrl);
    } catch (e) {
      print('exception');
      print(e);
    }
    //4: store the image url inside the corresponding document of the db
    //creare campo/attributo sui personal profile di tipo stringa che contenga imageUrl (o lista di imageURLs)

    //5: display the image
    // widget di tipo image usango il comando : Image.network(url)
  }
}
