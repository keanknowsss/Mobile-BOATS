import 'package:boats_mobile_app/components/custom_bottom_navigation.dart';
import 'package:boats_mobile_app/utils/background_gradient.dart';
import 'package:boats_mobile_app/utils/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'weather_screen.dart';
// import 'map_screen.dart';
// import 'bluetooth_screen.dart';
import '../components/app_bar.dart';
import '../components/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: const BoatsAppBar(),
      body: SafeArea(
        child: Container(
          decoration: appBackgroundGradient(),
          child: Column(
            children: [
              Expanded(
                child: _weatherDashboardWidget(),
              ),
              const CustomBottomNavigation(
                pageIndex: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // to remove when the app will have a proper menu,
  // for now this is the default menu
  Widget _weatherDashboardWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Metro Manila, Pasig City, Philippines',
              style: GoogleFonts.lobster(fontSize: 18, color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
            padding: const EdgeInsets.only(left: 5, right: 15, top: 10),
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 4,
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Monday',
                            style: GoogleFonts.lobster(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/weather/01d.png',
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '28 °C',
                                  style: GoogleFonts.lobster(
                                    fontSize: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wind:',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  '13 KPH',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Humidity:',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  '100 %',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cloudiness:',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  '50 %',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  child: Text(
                    'heavy shower rain and drizzle'.toTitleCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 15),
            child: Column(
              children: List.generate(
                7,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Colors.grey[300],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Text(
                          'Sat',
                          style: GoogleFonts.lobster(fontSize: 16),
                        ),
                      ),
                      Image.asset(
                        'assets/weather/01d.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        '28 °C',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
