// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filepath, String filename)async{
    File file = File(filepath);
    
  }

}