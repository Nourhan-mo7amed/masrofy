import 'package:flutter/material.dart';
import 'package:masrofy/core/constants/month_name.dart';

class AddIncomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Income",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: CustomLoginFormField()
          ),
        ),
      ),
    );
  }

 
}

class CustomLoginFormField extends StatefulWidget {
  const CustomLoginFormField({super.key});

  @override
  State<CustomLoginFormField> createState() => _CustomLoginFormFieldState();
}

class _CustomLoginFormFieldState extends State<CustomLoginFormField> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Expense Title",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "ex Food",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Amount",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.attach_money, size: 20),
                                hintText: "\$ 2000",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Date",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            TextField(
                              controller: _dateController,
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
                                        "${pickedDate.day} ${monthName(pickedDate.month)} ${pickedDate.year}";
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today, size: 20),
                                hintText: "22 july 2025",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _notesController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
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
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
    );
  }
}