// ignore_for_file: prefer_const_constructors

import 'package:cloudstoragepractice/storageService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cloud Storage'),
        ),
        body: Column(children: [
          ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                );
                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    // backgroundColor: Colors.white70,
                    content: Text(
                      'No File Selected',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                  ));

                  return null;
                }
                final pathname = results.files.single.path;
                // File Name
                final filename = results.files.single.name;
                storage
                    .uploadFile(pathname, filename)
                    .then((value) => print("Done"));
              },
              child: const Text("Upload File")),

              Expanded(child: FutureBuilder(
                future: storage.listFiles(),
                builder: (BuildContext context, AsyncSnapshot<firebase_storage.ListResult>
                 snap){
                   if(snap.connectionState==ConnectionState.done&&snap.hasData){
                     return Container(
                       child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snap.data!.items.length,itemBuilder: (BuildContext context, index){

                         return ElevatedButton(onPressed: (){}, child: Text(snap.data!.items[index].name)
                         );
                       }),
                     );
                   }
                   if(snap.connectionState==ConnectionState.waiting){
                     return Center(child: CircularProgressIndicator());
                   }
                   return Container();
                   

                },

              ),)
        ]));
  }
}
