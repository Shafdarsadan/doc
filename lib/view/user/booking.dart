import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Booking extends StatelessWidget {
  String categoryName;
  bool is_video;
  // Booking({Key? key}) : super(key: key);
  Booking({required this.categoryName,required this.is_video});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Color(0xff1D7BA1),
      ),

      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('user').where("specialisation", isEqualTo: categoryName).where("consult_type", isEqualTo:is_video? "Online":"offline").get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                
            if(snapshot.hasData){
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
                                child: Image.asset("assets/images/doctors.jpg"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 2, bottom: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                onTap: ()async{
                                 showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) async{
                                  await FirebaseFirestore.instance.collection('appoinments').doc(snapshot.data!.docs[i]['doc_id']+FirebaseAuth.instance.currentUser!.uid+ DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,value!.hour,value.minute ).toString(),).set({
                                    'doc_name':snapshot.data!.docs[i]['name'],
                                    'uid':FirebaseAuth.instance.currentUser!.uid,
                                    'name':FirebaseAuth.instance.currentUser!.email,
                                    'doctor':snapshot.data!.docs[i]['doc_id'],
                                    'meet_link':"",
                                    'time':DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,value!.hour,value.minute ),
                                  }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Appoint booked"))));
                                 });
                                  // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 1)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black),
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
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
            }else{
                  return Center(child: Text("No doctors Available", style: TextStyle(color: Colors.black),));

            }
          }
        ),
      ),
    );
  }
}
