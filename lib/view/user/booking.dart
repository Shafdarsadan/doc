import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc/view/user/razorpay.dart';
import 'package:doc/view/user/select_location_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLocationPage()));
              },
              icon: Icon(Icons.search))
        ],
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
                if (snapshot.data!.docs.isEmpty)
                  return Center(
                      child: Text(
                    "No doctors Available",
                    style: TextStyle(color: Colors.black),
                  ));
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
                                      selectDateButtonSheet(context,
                                          doc_id: snapshot.data!.docs[i].id,
                                          shift: snapshot.data!.docs[i]['slot'],
                                          doc_name: snapshot.data!.docs[i]
                                              ['name'],
                                          meeting_link: snapshot.data!.docs[i]
                                              ['meet_link'],
                                          type: is_video ? "online" : "offline",
                                          fee: snapshot.data!.docs[i]['fee']);
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
                          ],
                        ));
                  },
                );
              } else {
                return Center(
                    child: Text(
                  "something went wrong",
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
      required String fee,
      String meeting_link = '',
      String type = 'online'}) {
    DateTime? date;
    Map<String, TimeOfDay>? selected;
    showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () async {
                        var selected_date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2222));
                        setState(() {
                          date = selected_date;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent[500]),
                        child: Text(date == null
                            ? "select date"
                            : "date : ${date?.day}/${date?.month}/${date?.year}"),
                      ),
                    ),
                    if (date != null)
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('appoinments')
                              .where('doctor', isEqualTo: doc_id)
                              .where('start_time',
                                  isLessThan: DateTime(date!.year, date!.month,
                                      date!.day, 23, 59, 59))
                              .where('start_time',
                                  isGreaterThan: DateTime(
                                      date!.year, date!.month, date!.day))
                              .snapshots(),
                          builder: (context, snapshot) {
                            print(snapshot.error.toString());
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Center(child: CircularProgressIndicator());
                            if (snapshot.hasData) {
                              var list = (shift == "full"
                                      ? fullSlots
                                      : shift == 'morning'
                                          ? morningSlots
                                          : eveningSlots)
                                  .skipWhile((value) {
                                return DateTime(
                                            date!.year,
                                            date!.month,
                                            date!.day,
                                            value['from']!.hour,
                                            value['from']!.minute)
                                        .microsecondsSinceEpoch <
                                    DateTime.now().microsecondsSinceEpoch;
                              });
                              if (list.isEmpty)
                                return Center(
                                  child: Text(
                                      "No Slot Available for ${DateFormat('dd MMM yyyy').format(date!)}"),
                                );
                              return Container(
                                height: 300,
                                child: ListView(
                                    shrinkWrap: true,
                                    children: list.map(
                                      (data) {
                                        String? status = getStatus(
                                            DateTime(
                                                date!.year,
                                                date!.month,
                                                date!.day,
                                                data['from']!.hour,
                                                data['from']!.minute),
                                            data: snapshot.data!.docs);
                                        return InkWell(
                                          onTap: () async {
                                            if (status != null) return;
                                            if (selected != null)
                                              await FirebaseFirestore.instance
                                                  .collection('appoinments')
                                                  .doc(
                                                      '${doc_id}-${selected!['from']}')
                                                  .delete();
                                            setState(() => selected = data);
                                            await FirebaseFirestore.instance
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
                                              'payment_id': null,
                                              'type': type,
                                              'meet_link': meeting_link,
                                              'created_at': DateTime.now(),
                                              'start_time': getDate(
                                                  date!, selected!['from']!),
                                              'end_time': getDate(
                                                  date!, selected!['to']!),
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
                                                color: status == null
                                                    ? Colors.green[
                                                        selected == data
                                                            ? 200
                                                            : 100]
                                                    : status == 'waiting'
                                                        ? selected == data
                                                            ? Colors.grey
                                                            : Colors.yellow[100]
                                                        : Colors.red[
                                                            selected == data
                                                                ? 200
                                                                : 100]),
                                            child: Center(
                                              child: Text(
                                                  '${DateFormat("hh:mm a").format(new DateTime(2000, 1, 1, data['from']!.hour, data['from']!.minute))}\t-\t${DateFormat("hh:mm a").format(new DateTime(2000, 1, 1, data['to']!.hour, data['to']!.minute))}'),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RazorpayPaymentScreen(
                                      amount: fee,
                                      booking_id:
                                          '${doc_id}-${selected!['from']}',
                                      email: FirebaseAuth
                                              .instance.currentUser!.email ??
                                          "")));
                        },
                        child: Text("Confirm"))
                  ],
                ),
              );
            }));
  }

  DateTime getDate(DateTime date, TimeOfDay day) =>
      DateTime(date.year, date.month, date.day, day.hour, day.minute);

  String? getStatus(DateTime date,
      {required List<QueryDocumentSnapshot<Map>> data}) {
    if (data.isEmpty) return null;
    print(date);
    try {
      return data.firstWhere((element) {
        var startDate = (element['start_time'] as Timestamp).toDate();
        print("start date:" + startDate.toString());
        var val = date.isAtSameMomentAs(startDate);
        if (val && element['status'] == 'waiting') {
          val = ((element['created_at'] as Timestamp)
                      .toDate()
                      .microsecondsSinceEpoch +
                  Duration(minutes: 5).inMicroseconds) >
              DateTime.now().microsecondsSinceEpoch;
        }
        return val;
      })['status'];
    } catch (e) {
      return null;
    }
  }
}
