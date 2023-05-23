import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  String categoryName;
  bool is_video;

  List<Map<String, TimeOfDay>> morningSlots = [
    {
      "from": TimeOfDay(hour: 9, minute: 0),
      "to": TimeOfDay(hour: 9, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 9, minute: 30),
      "to": TimeOfDay(hour: 10, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 10, minute: 0),
      "to": TimeOfDay(hour: 10, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 10, minute: 30),
      "to": TimeOfDay(hour: 11, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 11, minute: 0),
      "to": TimeOfDay(hour: 11, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 11, minute: 30),
      "to": TimeOfDay(hour: 12, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 12, minute: 0),
      "to": TimeOfDay(hour: 12, minute: 30)
    }
  ];
  List<Map<String, TimeOfDay>> eveningSlots = [
    {
      "from": TimeOfDay(hour: 13, minute: 30),
      "to": TimeOfDay(hour: 14, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 14, minute: 0),
      "to": TimeOfDay(hour: 14, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 14, minute: 30),
      "to": TimeOfDay(hour: 15, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 15, minute: 0),
      "to": TimeOfDay(hour: 15, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 15, minute: 30),
      "to": TimeOfDay(hour: 16, minute: 0)
    },
    {
      "from": TimeOfDay(hour: 16, minute: 0),
      "to": TimeOfDay(hour: 16, minute: 30)
    },
    {
      "from": TimeOfDay(hour: 16, minute: 30),
      "to": TimeOfDay(hour: 17, minute: 0)
    }
  ];
  late List<Map<String, TimeOfDay>> fullSlots;

  // Booking({Key? key}) : super(key: key);
  Booking({required this.categoryName, required this.is_video});

  @override
  Widget build(BuildContext context) {
    fullSlots = morningSlots + eveningSlots;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Color(0xff1D7BA1),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('user')
                .where("specialisation", isEqualTo: categoryName)
                .where("consult_type",
                    isEqualTo: is_video ? "Online" : "offline")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 1, color: Colors.white)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 85,
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                        "assets/images/doctors.jpg"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, top: 2, bottom: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[i]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    //sr
                                    onTap: () async {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection('appoinments')
                                            .doc(
                                              snapshot.data!.docs[i]['doc_id'] +
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid +
                                                  DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day,
                                                          value!.hour,
                                                          value.minute)
                                                      .toString(),
                                            )
                                            .set({
                                          'doc_name': snapshot.data!.docs[i]
                                              ['name'],
                                          'uid': FirebaseAuth
                                              .instance.currentUser!.uid,
                                          'name': FirebaseAuth
                                              .instance.currentUser!.email,
                                          'doctor': snapshot.data!.docs[i]
                                              ['doc_id'],
                                          'meet_link': "",
                                          'time': DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                              value!.hour,
                                              value.minute),
                                        }).then((value) => ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Appoint booked"))));
                                      });
                                      // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 1)));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.black),
                                      child: Text(
                                        "Book Now",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.symmetric(vertical: 6)),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Slot 10.00am - 06.00pm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Text(
                                    snapshot.data!.docs[i]['fee'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                );
              } else {
                return Center(
                    child: Text(
                  "No doctors Available",
                  style: TextStyle(color: Colors.black),
                ));
              }
            }),
      ),
    );
  }

  void selectDateButtonSheet(BuildContext context,
      {required String doc_id,
      required String shift,
      required String doc_name,
      String meeting_link = '',
      String type = 'online'}) {
    showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              DateTime? date;
              Map<String, TimeOfDay>? selected;
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() async {
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2222));
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black26),
                        child: Text(date == null
                            ? "select date"
                            : "date : ${date.day}/${date.month}/${date.year}"),
                      ),
                    ),
                    if (date != null)
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('appoinments')
                              .where('doctor', isEqualTo: doc_id)
                              .where('time',
                                  isLessThan: DateTime(date!.year, date!.month,
                                      date!.day, 23, 59, 59))
                              .where('time',
                                  isGreaterThan: DateTime(
                                      date!.year, date!.month, date!.day))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Center(child: CircularProgressIndicator());
                            if (snapshot.hasData) {
                              return Container(
                                height: 400,
                                child: ListView(
                                    shrinkWrap: true,
                                    children: (shift == "full"
                                            ? fullSlots
                                            : shift == 'morning'
                                                ? morningSlots
                                                : eveningSlots)
                                        .map(
                                      (data) {
                                        String? status = getStatus(
                                            DateTime(
                                                date!.day,
                                                date!.month,
                                                date!.day,
                                                selected!['from']!.hour,
                                                selected!['from']!.minute),
                                            data: snapshot.data!.docs);
                                        return InkWell(
                                          onTap: () {
                                            if (status != null) return;
                                            setState(() => selected = data);
                                            FirebaseFirestore.instance
                                                .collection('appoinments')
                                                .doc(
                                                    '${doc_id}-${selected!['from']}')
                                                .set({
                                              'doc_name': doc_name,
                                              'uid': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'name': FirebaseAuth
                                                  .instance.currentUser!.email,
                                              'doctor': doc_id,
                                              'type': type,
                                              'meet_link': meeting_link,
                                              'start_time': selected!['from'],
                                              'end_time': selected!['to'],
                                              'status': "waiting"
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: status == null
                                                        ? Colors.green
                                                        : status == 'waiting'
                                                            ? Colors.yellow
                                                            : Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[500]),
                                            child: Center(
                                              child: Text(
                                                  '${data['from']!.hour}:${data['from']!.minute}\t${data['to']!.hour}:${data['to']!.minute}'),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()),
                              );
                            }
                            return Center(
                              child: Text("something went wrong!"),
                            );
                          }),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('appoinments')
                              .doc('${doc_id}-${selected!['from']}')
                              .update({"status": "booked"});
                        },
                        child: Text("Confirm"))
                  ],
                ),
              );
            }));
  }

  String? getStatus(DateTime date,
      {required List<QueryDocumentSnapshot<Map>> data}) {
    return data.firstWhere((element) =>
            date.isAtSameMomentAs(element['start_time']))['status'] ??
        null;
  }
}
