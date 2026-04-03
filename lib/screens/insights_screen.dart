import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    final expenses = provider.transactions
        .where((tx) => tx.type == 'expense')
        .toList();

    double totalSpent = 0;
    Map<String, double> categoryMap = {};

    for (var tx in expenses) {
      totalSpent += tx.amount;

      if (categoryMap.containsKey(tx.category)) {
        categoryMap[tx.category] = categoryMap[tx.category]! + tx.amount;
      } else {
        categoryMap[tx.category] = tx.amount;
      }
    }

    // Find highest category
    String topCategory = "None";
    double maxAmount = 0;

    categoryMap.forEach((key, value) {
      if (value > maxAmount) {
        maxAmount = value;
        topCategory = key;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: expenses.isEmpty
            ? const Center(child: Text("No data available"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Spent: ₹$totalSpent",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Top Category: $topCategory",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Spending by Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView(
                      children: categoryMap.entries.map((entry) {
                        return ListTile(
                          title: Text(entry.key),
                          trailing: Text("₹${entry.value}"),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
