// ignore_for_file: file_names

import 'dart:io';

import 'package:cloudstoragepractice/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
class Storage{
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(filepath, String filename)async{
    File file = File(filepath);
    try{
      await storage.ref('test/${textcontroller.text}').putFile(file);

    }on firebase_core.FirebaseException catch(e){
      print(e.code);
      print(e.message);
    }
    
  }

  Future<firebase_storage.ListResult> listFiles()async{
    firebase_storage.ListResult results = await storage.ref('test').listAll();
    results.items.forEach((firebase_storage.Reference ref){
      print('Found File, $ref');
    });
    return results;

  }

  Future<String> downloadedUrl(String imageName)async{
    String downloadedUrl = await storage.ref('test/$imageName').getDownloadURL();
return downloadedUrl;
  }


}