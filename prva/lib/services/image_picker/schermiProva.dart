import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SchermiProva 
{
  String imageUrl = '';

  Future<String> uploadFile() async {
    //1: pick image
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return '';
    }
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      final fileBytes = await file.readAsBytes();
      final uploadTask = await referenceImageToUpload.putData(fileBytes);

      //USARE QUESTA STRINGA IMAGEURL PER SCARICARE LE IMMAGINI POI --
      // Salvare imageUrl in profili : i profili avranno un attributo "fotoProfilo" di tipo stringa
      //String fotoProfilo = imageUrl (tipo così)
      //quando poi mi serve stampare la foto faccio il widget di tipo Image.network(imageUrl)
      imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('exception');
      print(e);
    }
    //4: store the image url inside the corresponding document of the db
    //creare campo/attributo sui personal profile di tipo stringa che contenga imageUrl (o lista di imageURLs)
    return '';
    //5: display the image
    // widget di tipo image usango il comando : Image.network(url)
  }
}
