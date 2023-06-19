import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({Key? key}) : super(key: key);

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  Rxn<GeoPoint> location = Rxn<GeoPoint>();
  Rx<String> loc = "".obs;

  late MapController controller;
  bool _folded = true;

  Future<void> setPoint() async => await controller
      .getCurrentPositionAdvancedPositionPicker()
      .then((value) => location.value = value);

  @override
  void initState() {
    controller = MapController(initMapWithUserPosition: true);
    controller.init();
    controller.advancedPositionPicker();
    controller.listenerRegionIsChanging.addListener(() async {
      location.value =
          controller.listenerRegionIsChanging.value?.center ?? location.value;
      loc.value = await getLoc(
          lat: location.value?.latitude ?? 0,
          long: location.value?.longitude ?? 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.cancelAdvancedPositionPicker();
    controller.dispose();
    super.dispose();
  }

  Future<String> getLoc({required double lat, required double long}) async =>
      placemarkFromCoordinates(lat, long).then((value) {
        if (value.isEmpty) return "unknown";
        String out = '';
        if (value.first.name != null) out += '${value.first.name},';
        if (value.first.locality != null) out += '${value.first.locality},';
        if (value.first.administrativeArea != null)
          out += '${value.first.administrativeArea},';
        if (value.first.country != null) out += '${value.first.country},';
        if (value.first.postalCode != null) out += '${value.first.postalCode}';
        return out.endsWith(',') ? out.substring(0, out.length - 1) : out;
      });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            OSMFlutter(
              initZoom: 12,
              mapIsLoading: Center(child: CircularProgressIndicator()),
              controller: controller,
              androidHotReloadSupport: true,
              isPicker: true,
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       height: 50,
            //       color: Colors.grey[200],
            //       child: Autocomplete<SearchInfo>(
            //         optionsBuilder: (TextEditingValue textEditingValue) async {
            //           if (textEditingValue.text == '') {
            //             return const Iterable<SearchInfo>.empty();
            //           }
            //           return await addressSuggestion(textEditingValue.text);
            //         },
            //         onSelected: (SearchInfo selection) {
            //           controller.changeLocation(selection.point!);
            //         },
            //         displayStringForOption: (info) => "${info.address?.name}"
            //             ",${info.address?.street}"
            //             ",${info.address?.city}"
            //             ",${info.address?.state}"
            //             ",${info.address?.country}"
            //             "${info.address?.postcode == null ? "" : ",${info.address?.postcode}"}",
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: _folded ? 56 : 350,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: kElevationToShadow[6],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        child: !_folded
                            ? Autocomplete<SearchInfo>(optionsBuilder:
                                (TextEditingValue textEditingValue) async {
                                if (textEditingValue.text == '') {
                                  return const Iterable<SearchInfo>.empty()
                                      .toList();
                                }
                                return await addressSuggestion(
                                        textEditingValue.text)
                                    .catchError((e, s) =>
                                        const Iterable<SearchInfo>.empty()
                                            .toList());
                              }, onSelected: (SearchInfo selection) {
                                if (selection.point != null) {
                                  try {
                                    controller.changeLocation(selection.point!);
                                  } catch (e) {}
                                }
                              }, displayStringForOption: (info) {
                                String out = "";
                                if (info.address?.name != null)
                                  out += "${info.address!.name},";
                                if (info.address?.street != null)
                                  out += "${info.address!.street},";
                                if (info.address?.city != null)
                                  out += "${info.address!.city},";
                                if (info.address?.state != null)
                                  out += "${info.address!.state},";
                                if (info.address?.country != null)
                                  out += "${info.address!.country},";
                                if (info.address?.postcode != null)
                                  out += "${info.address!.postcode}";
                                return out.endsWith(',')
                                    ? out.substring(0, out.length - 1)
                                    : out;
                              })
                            : null,
                      ),
                    ),
                    AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: Radius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                _folded ? Icons.search : Icons.close,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _folded = !_folded;
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        )),
        bottomSheet: BottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          elevation: 10,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Select your location",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  // Obx(() => FutureBuilder(
                  //     future: getLoc(
                  //         lat: location.value.latitude,
                  //         long: location.value.longitude),
                  //     builder: (context, data) => Text(data.data ?? "no data"))),
                  // Obx(
                  //   () => Text(
                  //     "${loc.value}",
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: MaterialButton(
                      onPressed: () {
                        print(
                            '${location.value?.latitude} ${location.value?.longitude}');
                        Navigator.pop(context, location.value);
                      },
                      height: 60,
                      textColor: Colors.white,
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      // style: ButtonStyle(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   backgroundColor:
                      //       MaterialStateProperty.all<Color>(MyColors.Color2),
                      //   elevation: MaterialStateProperty.all(10),
                      // ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Select",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          enableDrag: false,
          onClosing: () {},
        ),
      ),
    );
  }
}
