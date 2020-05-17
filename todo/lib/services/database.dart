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
  Future addTask(String title, String time, String descp, String taskcolor) async{
    Map<String, String> data = <String, String>{
      'title': title,
      'time': time,
      'descp': descp,
      'taskcolor': taskcolor
  };
    return await Firestore.instance.collection("users").document(uid).collection("tasks").document(title).setData(data);
  }
  Future deleteTask(String title) async{
    
    return await Firestore.instance.collection("users").document(uid).collection("tasks").document(title).delete();
  }
  Future deleteAllTasks() async{
    await Firestore.instance.collection("users").document(uid).collection("tasks").getDocuments().then((snapshot) {
  for (DocumentSnapshot doc in snapshot.documents) {
    doc.reference.delete();
  };
});
  }

  Future updateTask(String title, String descp, String taskcolor) async{
    Map<String, String> data = <String, String>{
      'title': title,
      'descp': descp,
      'taskcolor': taskcolor
  };
    return await Firestore.instance.collection("users").document(uid).collection("tasks").document(title).updateData(data);
  }

}