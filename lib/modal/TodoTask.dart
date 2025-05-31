import 'todo.dart';

class TodoTask {
  TodoTask({
      this.data, 
      this.message, 
      this.success, 
      this.isAuthorized,});

  TodoTask.fromJson(dynamic json) {
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(ToDo.fromJson(v));
      });
    }
    message = json['Message'];
    success = json['Success'];
    isAuthorized = json['IsAuthorized'];
  }
  List<ToDo>? data;
  String? message;
  bool? success;
  bool? isAuthorized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    map['Message'] = message;
    map['Success'] = success;
    map['IsAuthorized'] = isAuthorized;
    return map;
  }

}