// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage'),
      ),
      body: Column(
        children:[
          ElevatedButton(onPressed: ()async{
            final results = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['pdf','png', 'jpg', 'jpeg'],
            );
            if(results==null){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                // backgroundColor: Colors.white70,
                                content: Text('No File Selected', style: TextStyle(color: Colors.white),),
                                duration: Duration(seconds: 2),
                              ));
              
              return null;
            }
              final path = results.files.single.path;
              // File Name
              final finalname = results.files.single.name;
              
          },
           child:const Text("Upload File"))

        ]
      )

      
    );
  }
}