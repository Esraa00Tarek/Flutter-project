class ToDo {
  ToDo({
      this.id, 
      this.title, 
      this.isDone, 
      this.createdDate,});

  ToDo.fromJson(dynamic json) {
    id = json['ID'];
    title = json['Title'];
    isDone = json['IsDone'];
    createdDate = json['CreatedDate'];
  }
  num? id;
  String? title;
  bool? isDone;
  String? createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['IsDone'] = isDone;
    map['CreatedDate'] = createdDate;
    return map;
  }

}