import 'package:endgame/controllers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:endgame/static.dart' as Static;
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Some Expense";
  String type = "Imcome";
  DateTime selectedDate = DateTime.now();
  String dropdownValue = 'Supermarket';
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime(2100, 01),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        backgroundColor: Color(0xffe2e7ef),
        body: ListView(
          padding: EdgeInsets.all(
            12.0,
          ),
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Add Transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.attach_money,
                      size: 24.0,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    onChanged: (val) {
                      try {
                        amount = int.parse(val);
                      } catch (e) {
                        // show Error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(
                              seconds: 2,
                            ),
                            content: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  "Enter only Numbers as Amount",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.description,
                      size: 24.0,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Color(0xff004eeb)),
                    underline: Container(
                      height: 2,
                      color: Color(0xff004eeb),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Fuel', 'Supermarket','Sports', 'Travels', 'Fun','Pets','Cosmetic',
                      'Food','Drink','Salary','Other','Investment','Transaction','Rental']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.moving_sharp,
                      size: 24.0,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Static.PrimaryColor,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                        if (dropdownValue.isEmpty || dropdownValue == "Expense") {
                          dropdownValue = 'Income';
                        }
                      });
                    }
                  },
                  selected: type == "Income" ? true : false,
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Expense" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Static.PrimaryColor,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";

                        if (dropdownValue.isEmpty || dropdownValue == "Income") {
                          dropdownValue = 'Expense';
                        }
                      });
                    }
                  },
                  selected: type == "Expense" ? true : false,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                  onPressed: () {
                    _selectDate(context);

                    FocusScope.of(context).unfocus();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Static.PrimaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: EdgeInsets.all(
                          12.0,
                        ),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "${selectedDate.day}${months[selectedDate.month - 1]}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (amount != null ) {

                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(amount!, selectedDate, dropdownValue, type);
                    Navigator.of(context).pop();
                  } //Z2
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[700],
                        content: Text(
                          "Please enter a valid Amount !",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
