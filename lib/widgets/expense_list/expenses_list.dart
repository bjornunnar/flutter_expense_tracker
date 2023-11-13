import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  Widget buildExpensesList(context, index){
    return ExpenseItem(expense: expenses[index]);
  }

  @override
  Widget build(context){
    return ListView.builder(
      itemBuilder: buildExpensesList,
      itemCount: expenses.length,
      );
  }
}