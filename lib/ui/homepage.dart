import 'package:flutter/material.dart';
import 'package:task_gulftechno/ui/product_screen.dart';
import 'dart:async';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  static const String _channel = 'test_activity';
  static const platform = const MethodChannel(_channel);
  var result;
  String qrResult="";
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Gulftecho"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 30),
                child: Text("Note: For testing the QR Scanner functionality please go to QR Code generator website. This website returns a QR code result as text which is shown after scan is complete in the text widget.")),
            ElevatedButton(
                onPressed: qrCodeScreenNavigation,
                child: Text("Open QR code Screen")),
            qrResult!=""? Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
                child: RichText(
                  text: new TextSpan(
                    text: 'Qr Scan Result: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Fira Sans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: qrResult,
                          style: new TextStyle(
                              fontSize: 13)),
                    ],
                  ),
                )):Container(),
            ElevatedButton(
                onPressed: homeScreenNavigation, child: Text("Open Product Screen")),
          ],
        ),
      ),
    );
  }

  qrCodeScreenNavigation() async {
    try {
    final result  = await platform.invokeMethod('startNewActivity');
    print("checkResult======"+result);
    qrResult=result;
    setState(() {
    });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }


  void homeScreenNavigation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductScreen()));
  }
}
