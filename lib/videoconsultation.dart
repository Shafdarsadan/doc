
import 'package:doc/home_page.dart';
import 'package:doc/homelocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';


class VideoconsultScreen extends StatefulWidget {
  @override
  _VideoconsultScreenState createState() => _VideoconsultScreenState();
}

class _VideoconsultScreenState extends State<VideoconsultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home()));
          },
        ),
        title: Text("Video Consultation"),
        backgroundColor: Color(0xff1D7BA1),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0,right: 15,left: 15,bottom: 0),
            child: SizedBox(
              height: 50,
              width: 500,
              child: InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_)=>Locationsearch(title: '',) ));
              },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFFEBEDEF),

                  ),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:28.0),
                        child: Icon(Icons.search,size: 30, color: Color(0xFF283747),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: AnimatedTextKit(
                          totalRepeatCount: 40,
                          animatedTexts: [
                            RotateAnimatedText(
                              'Search for body checkup',
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top:75.0),
            child: Container(

              //height: 100,
              //width: 100,
              child:
              GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                padding: const EdgeInsets.all(30),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                // Generate 100 widgets that display their index in the List.
                children: [
                  Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset("assets/images/general.png",width: 50,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Column(
                            children: [
                              Text("General Physician",style: TextStyle(fontSize: 12),),
                              Text("Consult for fever, cough, pain, headache, tiredness and more ",style: TextStyle(fontSize: 8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset("assets/images/dermatology.png",width: 50,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Column(
                            children: [
                              Text("Dermatologist",style: TextStyle(fontSize: 12),),
                              Text("Get answer to hairfall, pimples, skin rashes, and more such problems",style: TextStyle(fontSize: 8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset("assets/images/gynaecologist.png",width: MediaQuery.of(context).size.width * 0.5,height: 35,)),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Column(
                            children: [
                              Text("Gynaecologist",style: TextStyle(fontSize: 12),),
                              Text("Consult for periods-related problems, pregnancy, fertility issues",style: TextStyle(fontSize: 8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(8)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset("assets/images/ent.png",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Column(
                            children: [
                              Text("ENT specialist",style: TextStyle(fontSize: 12),),
                              Text("Consult your ENT specialist for vertigo, runny nose ",style: TextStyle(fontSize: 8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

