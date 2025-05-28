class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Sample ToDo 1'),
      ToDo(id: '2', todoText: 'Sample ToDo 2', isDone: true),
      ToDo(id: '3', todoText: 'Sample ToDo 3'),
     
    ];
  }
}