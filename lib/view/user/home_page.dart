import 'package:doc/helper/helper.dart';
import 'package:doc/view/user/appointmentbooking.dart';
import 'package:doc/view/user/booking_history.dart';
import 'package:doc/view/user/help.dart';
import 'package:doc/view/user/loginScreen.dart';
import 'package:doc/view/user/update_profile.dart';
import 'package:doc/view/user/videoconsultation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doc"),
        backgroundColor: Color(0xff1D7BA1),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(children: [
          ListTile(
            leading:
                Icon(Icons.account_circle_sharp, size: 25, color: Colors.black),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, size: 25, color: Colors.black),
            title: Text(
              'Booking',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingHistory()));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.app_registration, size: 25, color: Colors.black),
            title: Text(
              'Help',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Help()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, size: 25, color: Colors.red),
            title: Text(
              'SignOut',
              style: TextStyle(fontSize: 12),
            ),
            onTap: () async {
              final _helper = Helper();
              try {
                await _helper.firebaseSignout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } on FirebaseAuthException catch (e) {
                print(e.message);
              }
            },
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentScreen()));
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                              // height: 75,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xffdcdada),
                              ),
                              child: Image.asset(
                                "assets/images/booking.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Book Appointment",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoAppoinment()));
                  },
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xffdcdada),
                              ),
                              child: Image.asset(
                                "assets/images/video_consult.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Video Consultation ",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => CheckupScreen()));
                //   },
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Column(
                //       children: [
                //         Container(
                //             height: 75,
                //             width: double.infinity,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(10),
                //                   topRight: Radius.circular(10)),
                //               color: Color(0xffdcdada),
                //             ),
                //             child: Image.asset(
                //               "assets/images/body_checkups.png",
                //               width: 50,
                //               height: 40,
                //             )),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 8.0),
                //           child: Column(
                //             children: [
                //               Text(
                //                 "Body",
                //                 style: TextStyle(fontSize: 12),
                //               ),
                //               Text("Checkups", style: TextStyle(fontSize: 12)),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            Container(
                height: 150,
                // width: MediaQuery.of(context).size.width * 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "assets/images/ads.jpg",
                  fit: BoxFit.fill,
                )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: EdgeInsets.only(left: 15)),
                Text(
                  "Instant video consultation with specialists",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(30),
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset(
                              "assets/images/general.png",
                              width: 50,
                              height: 40,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "General Physician",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            "Consult for fever, cough, pain, headache, tiredness and more ",
                            style: TextStyle(fontSize: 8)),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset(
                              "assets/images/dermatology.png",
                              width: 50,
                              height: 40,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Dermatologist",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            "Get answer to hairfall, pimples, skin rashes, and more such problems",
                            style: TextStyle(fontSize: 8)),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset(
                              "assets/images/gynaecologist.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 35,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Gynaecologist",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            "Consult for periods-related problems, pregnancy, fertility issues",
                            style: TextStyle(fontSize: 8)),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(8)),
                              color: Color(0xcc1D7BA1),
                            ),
                            child: Image.asset(
                              "assets/images/ent.png",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "ENT specialist",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                            "Consult your ENT specialist for vertigo, runny nose ",
                            style: TextStyle(fontSize: 8)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
