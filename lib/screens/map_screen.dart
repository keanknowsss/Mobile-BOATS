import 'dart:async';

import 'package:boats_mobile_app/components/custom_bottom_navigation.dart';
import 'package:boats_mobile_app/constants/colors.dart';
import 'package:boats_mobile_app/utils/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/app_bar.dart';
import '../components/side_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  bool _showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: BoatsAppBar(),
      body: SafeArea(
        child: Container(
          decoration: appBackgroundGradient(),
          child: Column(
            children: [
              SingleChildScrollView(child: _inputAddressWidget()),
              Expanded(
                child: _googleMapsWidget(),
              ),
              const CustomBottomNavigation(
                pageIndex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputAddressWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.trip_origin,
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.edit_location_alt_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        initialValue: 'Current Address',
                        enabled: false,
                        // controller: _originController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.primary.withOpacity(0.4),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: 'Origin',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: _originController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _originController.clear();
                                      setState(
                                        () {
                                          _showClearButton = false;
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.clear),
                                    color: Colors.white,
                                  )
                                : null),
                        onChanged: (value) {
                          if (_originController.text.isNotEmpty) {
                            setState(() {
                              _showClearButton = true;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: _destinationController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: 'Destination',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: _destinationController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _destinationController.clear();
                                      setState(
                                        () {
                                          _showClearButton = false;
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.clear),
                                    color: Colors.white,
                                  )
                                : null),
                        onChanged: (value) {
                          if (_destinationController.text.isNotEmpty) {
                            setState(() {
                              _showClearButton = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey
                        .withOpacity(0.5); // Fill color when clicked
                  }
                  return Colors.transparent; // No fill color
                }),
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                print('test');
              },
              child: Text(
                'START RIDE',
                style: GoogleFonts.montserrat(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Widget _googleMapsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GoogleMap(
            zoomControlsEnabled: false,
            buildingsEnabled: true,
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}
