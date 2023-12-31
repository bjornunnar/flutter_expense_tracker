import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});

  final void Function(Expense data) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // catches changes made in the textfield below, and stores in a variable
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // tells flutter to shut down the TextEditingController when the overlay is closed
  // otherwise it lives on in memory
  @override
  void dispose() {
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
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

// checks if user is running IOS and displays native popup if so
  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text("Invalid input!"),
                content: const Text(
                    "Please make sure valid Title, Date and Amount values are entered."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OK"))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input!"),
                content: const Text(
                    "Please make sure valid Title, Date and Amount values are entered."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OK"))
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    // returns false if no amount is given, or if it's zero or below
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // no title, no or invalid amount, or no date returns an error
      _showDialog();
      return; // exit the function as last step in the error path
    }
    // after checks are made, everything is OK, we now add the input expense to the list
    // Expense(title: , amount: , date: , category: )
    Expense addedExpense = Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory);
    widget.addNewExpense(addedExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text("Title")),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                              prefixText: "\$",
                              prefixStyle: TextStyle(fontSize: 12),
                              label: Text("Amount")),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items:
                              // gets the "values" enum list, call map() to convert each one into a dropdownmenuitem object, and then toList() on the whole thing
                              Category.values
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase())))
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? "No Date Selected"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _showDatePicker,
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                              prefixText: "\$", label: Text("Amount")),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? "No Date Selected"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _showDatePicker,
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // closes the overlay by 'popping' the context given to the current build method
                          },
                          child: const Text("Cancel")),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense")),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items:
                              // gets the "values" enum list, call map() to convert each one into a dropdownmenuitem object, and then toList() on the whole thing
                              Category.values
                                  .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase())))
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // closes the overlay by 'popping' the context given to the current build method
                          },
                          child: const Text("Cancel")),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense")),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
