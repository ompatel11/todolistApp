import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Screens/contants/loading.dart';
import 'package:todo/services/database.dart';

class DefaultScreen extends StatefulWidget {
  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getUserTasks(BuildContext context) async*{
    final uid = (await FirebaseAuth.instance.currentUser()).uid;
    yield* Firestore.instance.collection("users").document(uid).collection("tasks").snapshots();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("ToDo List",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w400,
          ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(icon:Icon(Icons.power_settings_new,size:30,color: Colors.white), 
            tooltip: "Sign Out",
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).popAndPushNamed('/login');
            }),
            IconButton(
            icon: Icon(Icons.add,size: 40,color: Colors.white,),
            tooltip: "Add Task",
            onPressed: () {
              Navigator.popAndPushNamed(context, '/new_task');
            },
          ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Clear All",
          backgroundColor: Color(0xff101010),
          child: Icon(Icons.clear_all,size: 35,color: Colors.white,),
          onPressed: () async {
            final uid = (await _auth.currentUser()).uid;
            await DatabaseService(uid: uid).deleteAllTasks();
          }),
        body: Container(
          child: StreamBuilder(
            stream: getUserTasks(context),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: Loading());
              }
              else if(!snapshot.hasData){
                return Center(child: Text("No tasks here"));
              }
              else{
                return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context,index) =>
                   buildTaskCard(context, snapshot.data.documents[index])
              );
              }
            },
            
          )
        )
      );
   
  }
}


 Widget buildTaskCard(BuildContext context, DocumentSnapshot task) {
    return  Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: task['taskcolor']==null?Colors.blueAccent: Color(int.parse(task['taskcolor'])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(children: <Widget>[
                  Text(task['title']==null? "N/A":task['title'], style: new TextStyle(fontSize: 28.0),),
                ]),
              ),
             Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(child: Text(task['descp'], style: new TextStyle(fontSize: 20.0),softWrap: true,)),
                    ],
                  ),
                ),
               
              ),
             Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Padding(
                    padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.05),
                    child: IconButton(icon:FaIcon(FontAwesomeIcons.edit),
                        onPressed: () {
                          final _formKey = GlobalKey<FormState>();
                          final _title = TextEditingController.fromValue(TextEditingValue(
                            text: task['title'],));
                          final _descp = TextEditingController.fromValue(TextEditingValue(
                            text: task['descp'],));
                          showDialog(context: context,builder: (BuildContext context) => 
                           Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              height: 300.0,
                              width: 300.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(children: [
                                    TextFormField(
                                      controller: _title,
                                        decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:BorderRadius.all(Radius.circular(20.0))),
                                                  fillColor: Colors.black45,
                                                  filled: true,
                                                  hintStyle: GoogleFonts.comfortaa(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                letterSpacing: 4.0
                                                ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                        onChanged: (val) {
                                          print(_title);
                                        },
                                      ),
                                      TextFormField(
                                      controller: _descp,
                                        decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:BorderRadius.all(Radius.circular(20.0))),
                                                  fillColor: Colors.black45,
                                                  filled: true,
                                                  hintStyle: GoogleFonts.comfortaa(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                letterSpacing: 4.0
                                                ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                        onChanged: (val) {
                                          print(_descp);
                                        },
                                      ),
                                ],)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Colors.blue,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Okay',
                                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        RaisedButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel!',
                                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                          
                        }
                        ), 
                  ),
                  Padding(
                    padding:EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.01) ,
                    child: IconButton(icon:FaIcon(FontAwesomeIcons.trash),
                        onPressed: () async{
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final uid = (await _auth.currentUser()).uid;
                         print('In progress');
                         await DatabaseService(uid: uid).deleteTask(task['title']);
                         print("Done");
                        },),
                  )
                   ],
                 )
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
