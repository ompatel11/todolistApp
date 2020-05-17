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
  String taskcolor="0xff505050";
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
                      icon: FaIcon(FontAwesomeIcons.chevronLeft,
                      size: 35,
                      color: Colors.white
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
              color: Colors.white
            ),),
        actions: [
          IconButton(icon: FaIcon(FontAwesomeIcons.palette),color: Color(int.parse(taskcolor)), 
           onPressed: () async {  
                final BackColor colorName = await _asyncSimpleDialog(context);  
                print("Selected BackColor is $colorName");
                if (colorName== BackColor.D3D3D3){
                  taskcolor = "0xffD3D3D3";
                }
                else if (colorName== BackColor.E97451){
                  taskcolor = "0xffE97451";
                }
                else if (colorName == BackColor.ED76FF){
                  taskcolor = "0xffED76FF";
                }
                else{
                  taskcolor = "0xffFFF176";
                }



              }, ),
          IconButton(
            icon: FaIcon(timer?  FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash),
            color: Colors.white,
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
                      color: Colors.white
                   ),
                   onPressed: () async{
                     final uid = (await _auth.currentUser()).uid;
                     print('In progress');
                     if(title!=null){
                       await DatabaseService(uid: uid).addTask(title, picked.toString(), descp, taskcolor);
                       Navigator.of(context).popAndPushNamed('/home');
                       print("Done");
                     }
                     else{
                        _scaffoldKey.currentState.showSnackBar(snackBar);
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
                cursorColor: Colors.white, 
                maxLength: 16,
                onChanged: (val) {
                      setState(() => title = val);
                    },
                validator: (val) => val.isEmpty ? 'Cannot leave this empty' : null,
                  decoration: const InputDecoration(  
                    fillColor: Colors.white,
                    hintText: 'Task',  
                    labelText: 'Title',  
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    )
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
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                      )
                    ) 
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

enum BackColor { D3D3D3 , ED76FF, FFF176, E97451 }  
  
Future<BackColor> _asyncSimpleDialog(BuildContext context) async {  
  return await showDialog<BackColor>(  
      context: context,  
      barrierDismissible: true,  
      builder: (BuildContext context) {  
        return SimpleDialog(  
          title: const Text('Select Color '),  
          children: <Widget>[  
            SimpleDialogOption(  
              onPressed: () {  
                Navigator.pop(context, BackColor.D3D3D3);  
              },  
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('D3D3D3'),
                  Container(
                    width: 35,
                    height: 15,
                    color: Colors.grey[350],
                  )
                ],
              ),  
            ), 
            SimpleDialogOption(  
              onPressed: () {  
                Navigator.pop(context, BackColor.FFF176);  
              },  
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Yellow'),
                  Container(
                    width: 35,
                    height: 15,
                    color: Colors.yellow[400],
                  )
                ],
              ),  
            ), 
             
            SimpleDialogOption(  
              onPressed: () {  
                Navigator.pop(context, BackColor.ED76FF);  
              },  
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Purple'),
                  Container(
                    width: 35,
                    height: 15,
                    color: Color(0xffED76FF),
                  )
                ],
              ),  
            ), 
            SimpleDialogOption(  
              onPressed: () {  
                Navigator.pop(context, BackColor.E97451);  
              },  
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Red'),
                  Container(
                    height: 15,
                    width: 35,
                    color: Color(0xffE97451),
                  )
                ],
              ),  
            ), 
          ],  
        );  
      });  
}  


