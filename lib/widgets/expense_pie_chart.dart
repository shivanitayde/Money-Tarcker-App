import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    // Filter only expenses
    final expenses = provider.transactions
        .where((tx) => tx.type == 'expense')
        .toList();

    // Group by category
    Map<String, double> dataMap = {};

    for (var tx in expenses) {
      if (dataMap.containsKey(tx.category)) {
        dataMap[tx.category] = dataMap[tx.category]! + tx.amount;
      } else {
        dataMap[tx.category] = tx.amount;
      }
    }

    if (dataMap.isEmpty) {
      return const Center(child: Text("No expense data"));
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: dataMap.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value,
              title: entry.key,
              radius: 50,
            );
          }).toList(),
        ),
      ),
    );
  }
}
