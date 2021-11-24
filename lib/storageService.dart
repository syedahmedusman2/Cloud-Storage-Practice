// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
class Storage{
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(filepath, String filename)async{
    File file = File(filepath);
    try{
      await storage.ref('test/$filename').putFile(file);

    }on firebase_core.FirebaseException catch(e){
      print(e.code);
      print(e.message);
    }
    
  }

}