import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('appoinments')
              .where(
                'name',
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              )
              .where('status', isEqualTo: 'booked')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty)
                return Center(
                  child: Text('No Data'),
                );
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => Card(
                          child: ListTile(
                            title: Container(
                              child: Text('Doctor: ${e['doc_name']}'),
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mode: ${e['type']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Status: ${e['status']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Slot: ${DateFormat("dd MMM yyyy hh:mm a").format(e['start_time'].toDate())}\t-\t${DateFormat("hh:mm a").format(e['end_time'].toDate())}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            trailing: e['type'] == 'offline'
                                ? null
                                : ElevatedButton(
                                    onPressed: () async {
                                      _launchURL(e['meet_link']);
                                    },
                                    child: Text("Meet"),
                                  ),
                          ),
                        ))
                    .toList(),
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }

  void _launchURL(String _meetLink) async {
    if (await canLaunchUrl(Uri.parse(_meetLink))) {
      final uri = Uri.parse(_meetLink);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_meetLink';
    }
  }
}
