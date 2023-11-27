import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill, required this.amount});

  final double fill;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    // getting the available width for the total amount display option.
    final availableWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
            // if we're in landscape mode, or the chart bar is at least at 20%,
            // we display the total amount within the bar
            // 600 is the breaking point we use in expenses_base, this could be a global variable..
            child: fill >= 0.2 || availableWidth >= 600
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          "\$${amount.toString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: fill < 0.2 ? 0.8 : 1,
                        ),
                      ),
                    ],
                    // ..and if not, we don't.
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
