import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  // call the get function for all buckets and return a list with each one
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final double availableWidth = MediaQuery.of(context).size.width;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      // use the available height if we're in landscape mode
      // again, 600 is the number we use in expenses_base..
      height: availableWidth < 600 ? 180 : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // we cycle through the buckets and create a chart bar
                // if the total is higher than 0.
                // the highest total is always 100% height, the others
                // a fraction of that one.
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    amount: bucket.totalExpenses,
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          Icon(
                            semanticLabel: "${bucket.category}",
                            categoryIcons[bucket.category],
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                          availableWidth >= 600
                              ? Text(bucket.category.name.replaceRange(
                                  0,
                                  1,
                                  bucket.category.name
                                      .substring(0, 1)
                                      .toUpperCase()))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
