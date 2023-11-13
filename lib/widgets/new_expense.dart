import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key});

  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  var _enteredTitle = "";

  // catches changes made in the textfield below, and stores in a variable
  final _titleController = TextEditingController();

  // TODO : FINISH DOING THIS

  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  print(_enteredTitle); // verify that the value is stored
                }, 
                child: Text("Save Expense")),
            ],
          )
        ],
      ),
    );
  }
}