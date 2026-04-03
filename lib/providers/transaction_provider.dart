import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  double get totalIncome {
    return _transactions
        .where((tx) => tx.type == 'income')
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => tx.type == 'expense')
        .fold(0, (sum, tx) => sum + tx.amount);
  }

  double get balance => totalIncome - totalExpense;

  // 🎯 ADD FROM HERE
  double _monthlyGoal = 5000;

  double get monthlyGoal => _monthlyGoal;

  void setGoal(double value) {
    _monthlyGoal = value;
    notifyListeners();
  }

  double get savings => totalIncome - totalExpense;

  double get progress {
    if (_monthlyGoal == 0) return 0;
    return savings / _monthlyGoal;
  }

  // 🎯 END HERE
}
