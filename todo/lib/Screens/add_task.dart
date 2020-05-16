import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/services/database.dart';
class Add_task extends StatefulWidget {
  @override
  _Add_taskState createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool timer = false;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  String title;
  String descp;
  final snackBar =  SnackBar(content: Text("Cannot leave title empty."));
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
      );
      setState(() {
        _time = picked;
        print(_time);
        if (_time == null){
          timer=false;
          
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
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
            icon: FaIcon(timer?  FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash),
            color: timer?Colors.cyanAccent[100]: Colors.white,
            onPressed: () {
              setState(() {
                if (timer== false){
                  selectTime(context);
                  return timer=true;
                }
                else{
                  return timer= false;
                }
              });
            }
          ), 
                    
                              
          IconButton(
                icon: FaIcon(FontAwesomeIcons.check,
                      size: 30,
                      color: Colors.cyanAccent[100]
                   ),
                   onPressed: () async{
                     final uid = (await _auth.currentUser()).uid;
                     print('In progress');
                     if(title!=null){
                       await DatabaseService(uid: uid).addTask(title, picked.toString(), descp);
                       Navigator.of(context).popAndPushNamed('/home');
                       print("Done");
                     }
                     else{
                       return _scaffoldKey.currentState.showSnackBar(snackBar);
                      //  return Scaffold.of(context).showSnackBar(snackBar);
                       
                     }
                   },
              )
            ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:8.0),
              child: Form(  
            key: _formKey,  
            child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: <Widget>[  
              TextFormField(  
                maxLength: 16,
                onChanged: (val) {
                      setState(() => title = val);
                    },
                validator: (val) => val.isEmpty ? 'Cannot leave this empty' : null,
                  decoration: const InputDecoration(  
                    hintText: 'Task',  
                    labelText: 'Title',  
                  ),  
              ),  
              SizedBox(
                  height: 20.0,
              ),
              TextFormField(  
                keyboardType: TextInputType.multiline,
                maxLength: 200,
                minLines: 1,
                maxLines: 8,
                onChanged: (val) {
                      setState(() => descp = val);
                    },
                validator: (val) => val.isEmpty ? 'Cannot leave this empty' : null,
                  decoration: const InputDecoration(  
                    hintText: 'Task',  
                    labelText: 'Description',  
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

