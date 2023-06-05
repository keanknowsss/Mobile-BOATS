import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'weather_screen.dart';
import 'map_screen.dart';
import 'bluetooth_screen.dart';
import '../components/app_bar.dart';
import '../components/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: const BoatsAppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final desiredWidth = constraints.maxWidth * 0.9;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.primaryAccent],
            ),
          ),
          child: Column(
            children: [
              // WEATHER BUTTON
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: desiredWidth,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(-4, -4),
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeatherScreen(),
                            ));
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.white,
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/weather.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Weather',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // MAPS BUTTON
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                width: desiredWidth,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(-4, -4),
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapScreen(),
                            ));
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.white,
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/maps.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Maps',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // BLUETOOTH BUTTON
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                width: desiredWidth,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(-4, -4),
                          blurRadius: 9,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BluetoothScreen(),
                            ));
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.white,
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/bluetooth.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Bluetooth',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
