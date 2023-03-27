import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckupScreen extends StatefulWidget {
  const CheckupScreen({super.key});

  @override
  State<CheckupScreen> createState() => _CheckupScreenState();
}

class _CheckupScreenState extends State<CheckupScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), color: Colors.white,onPressed: () {
            Navigator.pop(context);
          }
          ),
          title: const Text("Body Checkup",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xff1D7BA1),
        ),
        body:
        Column(
          children:<Widget>[
            Container(

              height: height*0.2,
              width:width*1.0,
              decoration: BoxDecoration
                (color: Color.fromARGB(255, 94, 163, 204),
                  borderRadius: BorderRadius.circular(20.0)),
              padding:EdgeInsets.all(20),
                margin: EdgeInsets.all(5),

              child: Padding(
                padding: const EdgeInsets.only(left: 335.0,top: 10.0,right:0.0,bottom: 10),
                child: Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration
                    (color: Colors.indigo[900],borderRadius: BorderRadius.circular(10)),
                child: RotatedBox(quarterTurns: 1,
                child: Center(child: Text('BOOK NOW',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),))
                ),

              )
            ),
            Container(
                height: height*0.2,
                width:width*1.0,
                decoration: BoxDecoration
                  (color: Color.fromARGB(255, 94, 163, 204),
                    borderRadius: BorderRadius.circular(20.0)),
                padding:EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 335.0,top: 10.0,right:0.0,bottom: 10),
                  child: Container(
                      height: 100,
                      width: 20,
                      decoration: BoxDecoration
                        (color: Colors.indigo[900],borderRadius: BorderRadius.circular(10)),
                      child: RotatedBox(quarterTurns: 1,
                          child: Center(child: Text('BOOK NOW',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),))
                  ),
                )
            ),
            Container(
                height: height*0.2,
                width:width*1.0,
                decoration: BoxDecoration
                  (color: Color.fromARGB(255, 94, 163, 204),
                    borderRadius: BorderRadius.circular(20.0)),
                padding:EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 335.0,top: 10.0,right:0.0,bottom: 10),
                  child: Container(
                      height: 100,
                      width: 20,
                      decoration: BoxDecoration
                        (color: Colors.indigo[900],borderRadius: BorderRadius.circular(10)),
                      child: RotatedBox(quarterTurns: 1,
                          child: Center(child: Text('BOOK NOW',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),))
                  ),
                )
            ),
            Container(
                height: height*0.2,
                width:width*1.0,
                decoration: BoxDecoration
                  (color: Color.fromARGB(255, 94, 163, 204),
                    borderRadius: BorderRadius.circular(20.0)),
                padding:EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 335.0,top: 10.0,right:0.0,bottom: 10),
                  child: Container(
                      height: 100,
                      width: 20,
                      decoration: BoxDecoration
                        (color: Colors.indigo[900],borderRadius: BorderRadius.circular(10)),
                      child: RotatedBox(quarterTurns: 1,
                          child: Center(child: Text('BOOK NOW',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),))
                  ),
                )
            ),

          ],
        )
    );
  }
}
