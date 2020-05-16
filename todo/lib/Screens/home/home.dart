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
            color: Colors.cyanAccent[100],
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            IconButton(icon:Icon(Icons.power_settings_new,size:30,color: Colors.cyanAccent[100]), 
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).popAndPushNamed('/login');
            }),
            IconButton(
            icon: Icon(Icons.add,size: 40,color: Colors.cyanAccent[100],),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/new_task');
            },
          ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Clear All",
          backgroundColor: Colors.cyanAccent[100],
          child: Icon(Icons.clear_all,size: 30,color: Colors.black87,),
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
    return new Container(
      child: Card(
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
                      IconButton(icon:FaIcon(FontAwesomeIcons.trash),
                      onPressed: () async{
                        final FirebaseAuth _auth = FirebaseAuth.instance;
                        final uid = (await _auth.currentUser()).uid;
                       print('In progress');
                       await DatabaseService(uid: uid).deleteTask(task['title']);
                       print("Done");
                      },),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
