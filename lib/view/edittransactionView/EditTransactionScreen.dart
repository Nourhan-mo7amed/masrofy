import 'package:flutter/material.dart';
import '../../widgets/TransactionInputField.dart';

class EditTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  @override
  _EditTransactionScreen createState() => _EditTransactionScreen();
}

class _EditTransactionScreen extends State<EditTransactionScreen> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _DescriptionController;
  late TextEditingController _amountController;

  DateTime? selectedDate;
  int selectedCategory = -1;

  final List<IconData> categories = [
    Icons.widgets_outlined,
    Icons.shopping_bag,
    Icons.receipt,
    Icons.fastfood_outlined,
  ];

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.transaction["title"].toString(),
    );
    _dateController = TextEditingController(
      text: widget.transaction["date"].toString(),
    );
    _DescriptionController = TextEditingController(
      text: widget.transaction["description"].toString(),
    );
    _amountController = TextEditingController(
      text: widget.transaction["amount"].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Expense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Transactioninputfield(
                  label: "Expense Title",
                  hint: "Food",
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: List.generate(categories.length, (index) {
                        final List<Color> colors = [
                          Colors.blue,
                          Colors.orange,
                          Colors.red,
                          Colors.purple,
                        ];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selectedCategory == index
                                  ? colors[index].withOpacity(0.2)
                                  : Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              categories[index],
                              color: selectedCategory == index
                                  ? colors[index]
                                  : Colors.black54,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transactioninputfield(
                            label: "Amount",
                            hint: "\$ 2000",
                            controller: _amountController,
                            prefixIcon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transactioninputfield(
                            label: "Select Date",
                            hint: "22 July 2025",
                            controller: _dateController,
                            prefixIcon: Icons.calendar_today,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2025, 7, 22),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  _dateController.text =
                                      "${pickedDate.day} ${_monthName(pickedDate.month)} ${pickedDate.year}";
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Transactioninputfield(
                  label: "Description",
                  hint: "Write notes...",
                  controller: _DescriptionController,
                  maxLines: 5,
                ),
                SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }
}
