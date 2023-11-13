import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

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
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;


  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose(){
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, 1);
     final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
      );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(context){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  prefixText: "\$",
                  label: Text("Amount")
                  ),
                keyboardType: TextInputType.number,
              ),
            ),
          const SizedBox(width: 16,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_selectedDate == null ? "No Date Selected" : formatter.format(_selectedDate!)),
                IconButton(onPressed: _showDatePicker, icon: const Icon(Icons.calendar_month)),
              ],
            ),
            ),
          ],
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: 
                // gets the "values" enum list, call map() to convert each one into a dropdownmenuitem object, and then toList() on the whole thing
                Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category, 
                    child: 
                      Text(category.name.toUpperCase()))).toList(), 
                    onChanged: (value) {
                      if (value == null) {
                          return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text("Cancel")
              ),
              ElevatedButton(
                onPressed: (){
                  print(_titleController.text); // verify that the value is stored
                  print(_amountController.text);
                }, 
                child: Text("Save Expense")
              ),
            ],
          )
        ],
      ),
    );
  }
}