import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense data) removeExpense;

  Widget buildExpensesList(ctx, index){
    return Dismissible(
      onDismissed: (direction){
        removeExpense(expenses[index]);
      },
      key: ValueKey(expenses[index]),
      child: ExpenseItem(
        expense: expenses[index]
      )
    );
  }

  @override
  Widget build(context){
    return ListView.builder(
      itemBuilder: buildExpensesList,
      itemCount: expenses.length,
      );
  }
}