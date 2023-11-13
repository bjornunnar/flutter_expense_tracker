import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => const NewExpense());
  }

  // create dummy data
  final List<Expense> _registeredExpenses = [
    Expense(title: "Flutter Course", amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: "Groceries", amount: 5.20, date: DateTime.now(), category: Category.food),
    Expense(title: "Bus Fare", amount: 2.90, date: DateTime.now(), category: Category.travel),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
            )
        ]
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses,)
            ),

        ],
      ),
    );
  }
}