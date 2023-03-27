
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



void main() => runApp(const Help());

_makingPhoneCall() async {
  var url = Uri.parse("tel:8289884234");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), color: Colors.white,onPressed: () {
            Navigator.pop(context);
          }
          ),
          title: const Text("Help",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xff1D7BA1),
        ),// AppBar
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 250.0,
                ),//Container
                const Text(
                  'Welcome to Doc helpline',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),//TextStyle
                ),//Text
                Container(
                  height: 20.0,
                ),

                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: _makingPhoneCall,
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.black),
                    ),
                  ),
                  child: const Text('Call'),
                ), // ElevatedButton


                // DEPRECATED
                // RaisedButton(
                // onPressed: _makingPhoneCall,
                // child: Text('Call'),
                // textColor: Colors.black,
                // padding: const EdgeInsets.all(5.0),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
