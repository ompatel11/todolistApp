import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/services/database.dart';
class Add_task extends StatefulWidget {
  @override
  _Add_taskState createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
      context: context,
      initialTime: _time
      );
      setState(() {
        _time = picked;
        print(_time);
      });
  }
  Future<Null>add_newtask() async {
    final FirebaseUser user = await _auth.currentUser();
    try{
    DatabaseService(uid: user.uid).addTask('Title of Task 2','Time of task 2 ');
    print('Done');
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                      icon: FaIcon(FontAwesomeIcons.chevronLeft,
                      size: 35,
                      color: Colors.cyanAccent[100]
                   ),
                   onPressed: (){
                     Navigator.popAndPushNamed(context, '/home');
                   },
              color: Colors.black,
              ),
            title: Text("New Task",
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.cyanAccent[100]
            ),),
        actions: [
          IconButton(
                icon: FaIcon(FontAwesomeIcons.check,
                      size: 30,
                      color: Colors.cyanAccent[100]
                   ),
                   onPressed: () async{
                     final uid = (await _auth.currentUser()).uid;
                     await DatabaseService(uid: uid).addTask("title", "time");
                   },
              )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:8.0,vertical: MediaQuery.of(context).size.height * 0.05),
              child: Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          TextFormField(  
              decoration: const InputDecoration(  
                icon: const Icon(Icons.text_fields),  
                hintText: 'Task',  
                labelText: 'Title',  
              ),  
          ),  
          SizedBox(
              height: 20.0,
          ),
          Row(
              children: [
                Text("Select Time:",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                ),),
                
              ],
          ), 
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
            child: Row(
              children: [
                Text( picked.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 23,
                  ),),
                  FlatButton(
                  child: Icon(Icons.timer,size: 40,),
                  onPressed: (){
                        selectTime(context);
                      },                
                    ),
              ],
            ),
          ),  
          SizedBox(
            height: 100.0,
          ), 
          
        ],  
      ),  
      ),
            )
          ],
        ),
      )
    );
  }
}

