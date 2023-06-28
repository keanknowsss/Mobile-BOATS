import 'package:boats_mobile_app/api/map_information.dart';
import 'package:boats_mobile_app/components/app_bar.dart';
import 'package:boats_mobile_app/components/side_bar.dart';
import 'package:boats_mobile_app/constants/api_key.dart';
import 'package:boats_mobile_app/controllers/global_controller.dart';
import 'package:boats_mobile_app/screens/map_screen.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DrivingScreen extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;
  const DrivingScreen(
      {super.key, required this.origin, required this.destination});

  @override
  State<DrivingScreen> createState() => _DrivingScreenState();
}

class _DrivingScreenState extends State<DrivingScreen> {
  final GlobalController globalController = Get.put(
    GlobalController(),
    permanent: true,
  );

  late LatLng currentLocation = LatLng(0, 0);
  late LatLng destinationLocation = LatLng(0, 0);
  late GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  double bearing = 0.0;
  Set<Marker> markers = {};
  bool isMoving = false;

  @override
  void initState() {
    super.initState();
    setPolylines();
    getUserLocation();
    setState(() {
      currentLocation = widget.origin;
      destinationLocation = widget.destination;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: const BoatsAppBar(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) =>
                mapController = controller,
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 18,
              bearing: bearing,
            ),
            minMaxZoomPreference: const MinMaxZoomPreference(5, 25),
            markers: markers,
            polylines: Set<Polyline>.of(polylines.values),
            onCameraMove: (CameraPosition position) {
              mapController?.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: currentLocation,
                    zoom: position.zoom,
                    bearing: bearing,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.pedal_bike,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    if (result.status == 'OK') {
      polylineCoordinates.clear(); // Clear the previous coordinates
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('main_route');

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue.withOpacity(0.5),
      points: polylineCoordinates,
    );

    setState(() {
      polylines.clear(); // Clear the previous polylines
      polylines[id] = polyline; // Add the new polyline
    });
  }

  void getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        bearing = getBearing(currentLocation, destinationLocation);
        updateMarkers();
        moveCamera();
      });

      if (!isMoving) {
        isMoving = true;
        Geolocator.getPositionStream(
          locationSettings:
              LocationSettings(accuracy: LocationAccuracy.bestForNavigation),
        ).listen((Position position) {
          setState(() {
            currentLocation = LatLng(position.latitude, position.longitude);
            bearing = position.heading;
            updateMarkers();
            moveCamera();
            updatePolyline();
          });
        });
      }
    }
  }

  void updateMarkers() {
    Marker marker = Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      markers = Set<Marker>.of([marker]);
    });
  }

  void moveCamera() {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 18,
          bearing: bearing,
        ),
      ),
    );
  }

  void updatePolyline() async {
    if (!mounted) return; // Check if the State object is still mounted

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        currentLocation.latitude,
        currentLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
    );

    if (!mounted) return; // Check again after the asynchronous operation

    if (result.status == 'OK') {
      polylineCoordinates.clear();
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    double distance = await MapInformationApi().getDistance(
      currentLocation,
      destinationLocation,
    );
    if (distance < 0.05) {
      if (mounted) {
        Get.to(() =>
            const MapScreen()); // Check if the widget is still mounted before calling Get.back()
      }
    }

    PolylineId id = const PolylineId('main_route');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue.withOpacity(0.5),
      points: polylineCoordinates,
    );

    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }

  double getBearing(LatLng start, LatLng end) {
    double startLat = degreesToRadians(start.latitude);
    double startLng = degreesToRadians(start.longitude);
    double endLat = degreesToRadians(end.latitude);
    double endLng = degreesToRadians(end.longitude);

    double dLng = endLng - startLng;

    double y = math.sin(dLng) * math.cos(endLat);
    double x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(dLng);

    double bearing = math.atan2(y, x);

    return radiansToDegrees(bearing);
  }

  double degreesToRadians(double degrees) {
    return degrees * (math.pi / 180.0);
  }

  double radiansToDegrees(double radians) {
    return radians * (180.0 / math.pi);
  }
}
