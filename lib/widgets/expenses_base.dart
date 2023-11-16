import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(addNewExpense: addNewExpense));
  }



  // create dummy data
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Groceries",
        amount: 5.20,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Bus Fare",
        amount: 2.90,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void addNewExpense(Expense data) {
    setState(() {
      _registeredExpenses.add(data);
    });
  }

  void removeExpense(Expense data){
    final expenseIndex = _registeredExpenses.indexOf(data);
    setState(() {
      _registeredExpenses.remove(data);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: (){
            setState((){
              _registeredExpenses.insert(expenseIndex, data);
        },);
        }
        ),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    
    // fallback text, displayed if there are no expenses in current view
    Widget mainContent = 
      const Center(
        child: Text(
          "No expenses found. Start adding some!"
        ),
    );

    // display the list of expenses, if there are any
    if (_registeredExpenses.isNotEmpty){
      mainContent = 
      ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker"), actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        )
      ]),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent
          ),
        ],
      ),
    );
  }
}
