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
    return await Firestore.instance.collection("users").document(uid).collection('task').document(title).setData(data);
  }
  Future addTask(String title, String time) async{
    Map<String, String> data = <String, String>{
      'title': title,
      'time': time,
  };
    return await Firestore.instance.collection("users").document(uid).collection(title).document(title).setData(data);

  }
}