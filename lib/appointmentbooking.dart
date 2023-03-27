
import 'package:doc/booking.dart';
import 'package:doc/home_page.dart';
import 'package:doc/homelocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
        title: Text("Appoinment Booking"),
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
                              'Search for Doctor',
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
              decoration: BoxDecoration(
                color: Color(0xFFFAE9AA)
              ),

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
    InkWell( onTap: (){

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    Booking()));
    },
                  child: Card(

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
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("General Physician",style: TextStyle(fontSize: 12),),

                            ],
                          ),
                        ),
                      ],
                    ),
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
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Dermatologist",style: TextStyle(fontSize: 12),),

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
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Gynaecologist",style: TextStyle(fontSize: 12),),

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
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("ENT specialist",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/coughandfever.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Cough and Fever",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/skinallergy.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Skin Allergy",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/dentist.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Dentist",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/dietician.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Deitician",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/orthopaedics.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Orthopaedics",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/physiotherapy.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Physiotherapy",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/ayurvedic.jpg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Ayurvedic",style: TextStyle(fontSize: 12),),

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
                            child: Image.asset("assets/images/mentalhealth.jpeg",width: 40,height: 40,)),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0),
                          child: Column(
                            children: [
                              Text("Mental  Health",style: TextStyle(fontSize: 12),),

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

