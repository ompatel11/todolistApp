
class Note{
  String title;
  DateTime task_time;

  Note(this.title,this.task_time);

  Note.fromJson(Map<String, dynamic>json){
    title = json['title'];
    task_time = json['task_time'];
  }
}