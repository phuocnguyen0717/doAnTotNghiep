import 'package:endgame/controllers/db_helper.dart';
import 'package:endgame/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  DbHelper dbHelper = DbHelper();
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: Padding(
        padding: const EdgeInsets.all(
            12.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12.0,
                ),
              ),
              padding: EdgeInsets.all(16.0,
              ),
              child: Image.asset(
                "assets/icon.png",
                height: 64.0,
                width: 64.0,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text("Let Me Know Your Name? ",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Your Name",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            SizedBox(
              height: 50.0,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  if (name.isNotEmpty) {
                    dbHelper.addName(name);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Homepage()
                        ),
                    );
                  } else {}
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                    ),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}