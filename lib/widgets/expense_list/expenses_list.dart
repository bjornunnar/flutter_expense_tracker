import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense data) removeExpense;

  Widget buildExpensesList(ctx, index){
    int widgetWidth = (MediaQuery.of(ctx).size.width).floor();

    return Dismissible(
      resizeDuration: const Duration(milliseconds: 200), // a value between 300 and 800 ish will cause the text wiget within the background to persist after dismissed..?
      onDismissed: (direction){
        removeExpense(expenses[index]);
      },
      key: ValueKey(expenses[index]),
      background: Container(
        color: Theme.of(ctx).colorScheme.error,
        margin: EdgeInsets.symmetric(
        horizontal: Theme.of(ctx).cardTheme.margin!.horizontal,
        ),
          child: FittedBox( // makes the text within the box fill the available space
            fit: BoxFit.fitWidth,
            child: Text(
              "Swipe to delete".toUpperCase(),
              style: const TextStyle(
                color: Color.fromARGB(70, 0, 0, 0),
                fontWeight: FontWeight.w900,
                letterSpacing: 10,
                ),
              ),
          ),
      ),
      child: ExpenseItem(
        expense: expenses[index]
        ),
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