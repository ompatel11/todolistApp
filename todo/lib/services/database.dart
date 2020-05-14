import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection = Firestore.instance.collection('user');
  Future addUserData(String title,String time) async{
    return await Firestore.instance.collection('user').add({
      'title': title,
      'time': time,
    });
  }
}