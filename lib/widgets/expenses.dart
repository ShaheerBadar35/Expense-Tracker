import 'package:flutter/material.dart';
import 'package:fourth_project/widgets/chart/chart.dart';
import 'package:fourth_project/widgets/expenses-list/expenses_list.dart';
import 'package:fourth_project/models/expense.dart';
import 'package:fourth_project/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 5000,
      date: DateTime.now(),
      title: "Your mom",
      category: Category.Leisure,
    ),
    Expense(
      amount: 2323,
      date: DateTime.now(),
      title: "Your sis",
      category: Category.Food,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final recentIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 222, 230, 230),
        duration: const Duration(seconds: 3),
        content: const Text(
          "Expense Deleted",
          style: TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
          textColor: Colors.black,
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(recentIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    final swidth = MediaQuery.of(context).size.width;
//    print("sadasd");
//    print(MediaQuery.of(context).size.width);
//    print("sadasd");
    Widget content = const Center(
      child: Text(
        "No Expenses. Click on + to add more!",
        style: TextStyle(color: Color.fromARGB(255, 222, 230, 230)),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      content = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        //backgroundColor: Color.fromARGB(255, 78, 78, 78),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: swidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: content),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: content),
              ],
            ),
    );
  }
}
