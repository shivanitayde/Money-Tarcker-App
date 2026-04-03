import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  String _category = 'Food';

  List<String> expenseCategories = ['Food', 'Travel', 'Shopping'];
  List<String> incomeCategories = ['Salary', 'Freelance', 'Bonus'];

  List<String> get categories {
    return _type == 'income' ? incomeCategories : expenseCategories;
  }

  void _saveTransaction() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter amount")));
      return;
    }
    final transaction = TransactionModel(
      id: const Uuid().v4(),
      amount: double.tryParse(_amountController.text) ?? 0,
      type: _type,
      category: _category,
      date: DateTime.now(),
      note: _noteController.text,
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(transaction);
    _amountController.clear();
    _noteController.clear();

    setState(() {
      _type = 'expense';
      _category = 'Food';
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),

            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: "Note"),
            ),

            DropdownButton<String>(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'income', child: Text("Income")),
                DropdownMenuItem(value: 'expense', child: Text("Expense")),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                  _category = categories.first; // ✅ reset category
                });
              },
            ),

            DropdownButton<String>(
              value: _category,
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
