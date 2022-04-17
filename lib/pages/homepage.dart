import 'package:endgame/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:endgame/static.dart' as Static;
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTransaction(),)
            ,)
          ;
        },
        backgroundColor:Static.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      body: Center(
        child: Text(
          "No Data !"
        ),
      ),
    );
  }
}
