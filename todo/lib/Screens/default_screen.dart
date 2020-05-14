import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:todo/entities/notes.dart';
class DefaultScreen extends StatefulWidget {
  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  List<Note> _notes = List<Note>();
  Future<List<Note>> fetchNotes() async{
    var _notes = List<Note>();
  }
  @override @override
  void initState() {
    // TODO: implement initState
    fetchNotes().then((value){
      setState(() {
        _notes.addAll(value);
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("ToDo List",
          style: GoogleFonts.roboto(
            color: Colors.cyanAccent[100],
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(
            icon: Icon(Icons.add,size: 40,color: Colors.cyanAccent[100],),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/new_task');
            },
          ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyanAccent[100],
          child: Icon(Icons.clear_all,size: 30,color: Colors.black87,),
          onPressed: null),
        body: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index){
            return Card(
            child: Column(
              children: [
                Text(_notes[index].title),
                Text(_notes[index].task_time.toString())
              ],
            ),
          );
          }
        ),
      );
   
  }
}