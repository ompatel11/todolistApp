import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultScreen extends StatefulWidget {
  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("ToDo List",
          style: GoogleFonts.roboto(
            color: Colors.cyanAccent,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(
            icon: Icon(Icons.add,size: 40,color: Colors.cyanAccent,),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/new_task');
            },
          ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyanAccent,
          child: Icon(Icons.clear_all,size: 30,color: Colors.black87,),
          onPressed: null),
        // body: Container(
        //   child: ,
        // ),
      );
   
  }
}