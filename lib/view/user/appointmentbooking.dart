import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc/view/user/booking.dart';
import 'package:doc/view/user/home_page.dart';
import 'package:doc/view/user/homelocation.dart';
import 'package:flutter/material.dart';

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
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        title: Text("Appoinment Booking"),
        backgroundColor: Color(0xff1D7BA1),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 15, left: 15, bottom: 0),
            child: SizedBox(
              height: 50,
              width: 500,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Locationsearch(
                                title: '',
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xFFEBEDEF),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Color(0xFF283747),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
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
            padding: const EdgeInsets.only(top: 75.0),
            child: Container(
                decoration: BoxDecoration(color: Color(0xFFA1A1A1)),
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('DocCategory')
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return _CategoryCard(
                            category: snapshot.data!.docs[index].id,
                            img_url: snapshot.data!.docs[index]['img'],
                          );
                        },
                      );
                    } else {
                      return Text("no Doctors Available");
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  String category;
  String img_url;
  _CategoryCard({super.key, required this.category, required this.img_url});

  @override
  Widget build(BuildContext context) {
    print(img_url);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Booking(
                      categoryName: category,
                      is_video: false,
                    )));
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Color(0xcc1D7BA1),
                ),
                child: Image.network(
                  img_url,
                  width: 50,
                  height: 40,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: [
                  Text(
                    category,
                    style: TextStyle(fontSize: 12),
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
