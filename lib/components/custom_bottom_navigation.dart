import 'package:boats_mobile_app/constants/colors.dart';
import 'package:boats_mobile_app/screens/home_screen.dart';
import 'package:boats_mobile_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int pageIndex;

  const CustomBottomNavigation({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: const Color(0xFFBCBCBC),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[800]!.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.to(
                HomeScreen(),
                transition: Transition.noTransition,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.sunny_snowing,
                        color: pageIndex == 0
                            ? Colors.white
                            : AppColors.primaryAccent,
                        size: pageIndex == 0 ? 25 : 20,
                      ),
                    ),
                    Text(
                      'Weather',
                      style: GoogleFonts.roboto(
                          fontSize: pageIndex == 0 ? 16 : 14,
                          color: pageIndex == 0
                              ? Colors.white
                              : AppColors.primaryAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.to(
                MapScreen(),
                transition: Transition.noTransition,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.directions_bike_rounded,
                        color: pageIndex == 1
                            ? Colors.white
                            : AppColors.primaryAccent,
                        size: pageIndex == 1 ? 25 : 20,
                      ),
                    ),
                    Text(
                      'Ride Now',
                      style: GoogleFonts.roboto(
                          fontSize: pageIndex == 1 ? 16 : 14,
                          color: pageIndex == 1
                              ? Colors.white
                              : AppColors.primaryAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
