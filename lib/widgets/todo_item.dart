import '../constants/colors.dart';
import '../modal/todo.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {

  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  const TodoItem({super.key, required this.todo, required this.onDeleteItem, required this.onToDoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      
      child: ListTile(
        onTap: (){
// print('Tapped'), 
          // todo.isDone = !todo.isDone;
          onToDoChanged(todo);} ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank, color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: tdBlack,
            decoration: todo.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 5),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: 
            Icon(Icons.delete),
            onPressed: () {
//  print('Delete Todo'),
              onDeleteItem(todo.id);
            },
        ),
      ),
      ),

    );
  }
}