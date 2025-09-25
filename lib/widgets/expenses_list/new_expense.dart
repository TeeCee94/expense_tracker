import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }                                 .....alternatively,

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text); // tryParse('Hello') =>null, tryParse('12.34') => 12.34
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
     amountIsInvalid ||
     _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
        ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory,
        ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: now,
      );
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  Category _selectedCategory = Category.leisure;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(16),
    child: Column(
      children: [
        TextField(
          // onChanged: _saveTitleInput, .....alternatively,
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(
            label: Text('Title')
          ),
        ),
        Row(
          children: [
          Expanded(
            child: TextField(
            // onChanged: _saveTitleInput, .....alternatively,
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '\$ ',
              label: Text('Amount'),
            ),
                    ),
          ),
        SizedBox(width: 20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _selectedDate == null ? 'No Date selected' : formatter.format(_selectedDate!)),
              IconButton(
              onPressed: _presentDatePicker,
              icon: Icon(
                Icons.calendar_month
              ),
              ),
            ],
          ),
          ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase(),),),
              ).toList(), 
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              },
              ),
              Spacer(),
            TextButton(
              onPressed: _submitExpenseData,
            child: Text('Save Expense'),
            ),
            ElevatedButton(onPressed: () {
             Navigator.pop(context);
            }, 
            child: Text('Cancel'),
            ),
          ],
        )
      ],
    ),
    );
  }
}