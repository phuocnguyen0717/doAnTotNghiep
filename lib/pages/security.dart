import 'package:endgame/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xff033eeb),
            Color(0xff004eeb),
            Color(0xff005eeb),
            Color(0xff006eeb),
          ],
          begin: Alignment.topRight,
        )),
        child: pinCodeScreen(),
      ),
    );
  }
}

class pinCodeScreen extends StatefulWidget {
  const pinCodeScreen({Key? key}) : super(key: key);

  @override
  State<pinCodeScreen> createState() => _pinCodeScreenState();
}

class _pinCodeScreenState extends State<pinCodeScreen> {
  List<String> currentPin = [];
  List<TextEditingController> textEditing = [];

  @override
  void initState() {
    super.initState();
    TextEditingController pinOneController = TextEditingController();
    TextEditingController pinTwoController = TextEditingController();
    TextEditingController pinThreeController = TextEditingController();
    TextEditingController pinFourController = TextEditingController();
    textEditing.add(pinOneController);
    textEditing.add(pinTwoController);
    textEditing.add(pinThreeController);
    textEditing.add(pinFourController);
  }

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );
  int pinIndex = 0;

  void addPinNumber() {
    if (currentPin.length < 5) {
      for (int i = 0; i < currentPin.length; i++) {
        textEditing[i].text = currentPin[i];
      }
    }
  }
  void delText(){
    if(currentPin.length > 0 ){
      setState(() {
        currentPin.length -- ;

      });
    }

  }
  void addText(String text) {
    if (currentPin.length < 5) {
      setState(() {
        currentPin.add(text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    addPinNumber();

    return SafeArea(
        child: Column(
      children: <Widget>[

        Expanded(
            child: Container(
          alignment: Alignment(0, 0.5),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildSecurityText(),
              SizedBox(
                height: 40.0,
              ),
              buildPinText(),

            ],
          ),
        )),
        buildNumberPad(),
      ],
    ));
  }

  buildNumberPad() {
    return Expanded(
        child: Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyboardNumber(
                  n: 1,
                  onPressed: () {
                    addText('1');
                  },
                ),
                KeyboardNumber(
                  n: 2,
                  onPressed: () {
                    addText('2');
                  },
                ),
                KeyboardNumber(
                  n: 3,
                  onPressed: () {
                    addText('3');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyboardNumber(
                  n: 4,
                  onPressed: () {
                    addText('4');
                  },
                ),
                KeyboardNumber(
                  n: 5,
                  onPressed: () {
                    addText('5');
                  },
                ),
                KeyboardNumber(
                  n: 6,
                  onPressed: () {
                    addText('6');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyboardNumber(
                  n: 7,
                  onPressed: () {
                    addText('7');
                  },
                ),
                KeyboardNumber(
                  n: 8,
                  onPressed: () {
                    addText('8');
                  },
                ),
                KeyboardNumber(
                  n: 9,
                  onPressed: () {
                    addText('9');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                  child: MaterialButton(
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    onPressed: () {
                      setState(() {
                        authenticate();
                      });
                    },
                    child: Icon(
                      Icons.fingerprint_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                KeyboardNumber(
                  n: 0,
                  onPressed: () {
                    addText('0');
                  },
                ),
                Container(
                  width: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                  child: MaterialButton(
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    onPressed: () {
                      print(currentPin);
                      delText();

                    },
                    child: Icon(
                      Icons.backspace_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  buildPinText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: textEditing[0],
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: textEditing[1],
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: textEditing[2],
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: textEditing[3],
        ),
      ],
    );
  }

  buildSecurityText() {
    return Text(
      "Security Pin",
      style: TextStyle(
          color: Colors.white70, fontSize: 17.0, fontWeight: FontWeight.bold),
    );
  }

  bool authenticated = false;
  void authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      authenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to move forward',
      );
      if (authenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Scaffold(body: Container(color: Colors.red,),),
          ),
        );
      } else {
        setState((  ) {});
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "ERROR",
          ),
          content: Text(
            "You need to setup either PIN or Fingerprint Authentication to be able to use this App !\nI am doing this for your safety 🙂",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  PINNumber({
    required this.textEditingController,
    required this.outlineInputBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 21.0, color: Colors.white),
      ),
    );
  }


}

class KeyboardNumber extends StatelessWidget {
  final int n;

  final Function() onPressed;

  KeyboardNumber({required this.n, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent.withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
