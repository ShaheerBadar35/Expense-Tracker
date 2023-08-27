import 'package:flutter/material.dart';
import 'package:fourth_project/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.Leisure;
  // void _presentDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000, 1, 1),
  //     lastDate: DateTime(3000, 1, 1),
  //   );
  // }

  void _setExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    bool check = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        check ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Invalid Entry"),
            content: const Text("Please make sure to enter a valid input."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay"),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          amount: enteredAmount,
          date: _selectedDate!,
          title: _titleController.text,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ks = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 248, 241),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, ks + 15),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    hintText: "title",
                    label: Text("Title"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$',
                          label: Text("\$ Amount"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    //const Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Text(_selectedDate == null
                              ? "No Date Selected"
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000, 1, 1),
                                lastDate: DateTime(3000, 1, 1),
                              ).then((value) {
                                setState(() {
                                  _selectedDate = value;
                                });
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    //const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 188, 240, 229)),
                      onPressed: _setExpense,
                      child: const Text("Save Expense"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
