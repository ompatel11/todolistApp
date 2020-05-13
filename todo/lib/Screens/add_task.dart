import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Add_task extends StatefulWidget {
  @override
  _Add_taskState createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  final _formKey = GlobalKey<FormState>();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height * 0.1),
              child: Row(
                children: [
                   IconButton(
                      icon: FaIcon(FontAwesomeIcons.chevronCircleLeft,
                      size: 54,
                      color: Colors.black54,
                   ),
                   onPressed: (){
                     Navigator.popAndPushNamed(context, '/home');
                   },
              color: Colors.black,
              ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Form(  
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  
          TextFormField(  
              decoration: const InputDecoration(  
                icon: const Icon(Icons.person),  
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
          Center(
            child: Container(  
                  child:  GestureDetector(
                              onTap: () {                     
                              },
                              child: Container(
                                width: 250.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Set Task',
                                    style: GoogleFonts.roboto(
                                        fontSize: 27.0, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),),
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