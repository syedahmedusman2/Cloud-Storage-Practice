// ignore_for_file: prefer_const_constructors

import 'package:cloudstoragepractice/storageService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

  TextEditingController textcontroller = TextEditingController();
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
          TextField(controller: textcontroller,),
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
                // final filename = textcontroller.text.trim();
                final filename = results.files.single.name;
                storage
                    .uploadFile(pathname, filename)
                    .then((value) => print("Done"));
              },
              child: const Text("Upload File")),
          FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snap) {
              if (snap.connectionState == ConnectionState.done &&
                  snap.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snap.data!.items.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(snap.data!.items[index].name)),
                        );
                      }),
                );
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: storage.downloadedUrl('helloworld'),
            builder: (BuildContext context,
                AsyncSnapshot<String> snap) {
              if (snap.connectionState == ConnectionState.done &&
                  snap.hasData) {
                return Expanded(
                  child: ListView.builder(itemCount: snap.data!.length,itemBuilder: (BuildContext context, index){
                    return Container(width: 300,height: 450,
                  child: Image.network(snap.data!,
                  fit: BoxFit.cover,));
                  
                  }),
                );
                //Container(width: 300,height: 450,
                // child: Image.network(snap.data!,
                // fit: BoxFit.cover,),

                
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          )
        ]));
  }
}
