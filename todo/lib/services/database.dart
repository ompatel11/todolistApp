import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference taskCollection = Firestore.instance.collection('user');
  
  Future addUserData(String title,String time) async{
    Map<String, String> data = <String, String>{
      'title': title,
      'time': time,
  };
    return await Firestore.instance.collection("users").document(uid).collection('task').add(data);
  }
  Future addTask(String title, String time) async{
    Map<String, String> data = <String, String>{
      'title': title,
      'time': time,
  };
    return await Firestore.instance.collection("users").document(uid).collection("tasks").document(title).setData(data);
  }
  Future deleteTask(String title) async{
    Map<String,String> data = <String,String>{
      'title': title,
    };
    return await Firestore.instance.collection("users").document(uid).collection("tasks").document(title).delete();
  }
}