import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference taskCollection = Firestore.instance.collection('user');
    
  Future updateUserData(String title,String time) async{
    return await taskCollection.document(uid).setData({
      'title': title,
      'time': time
    });
  }
}