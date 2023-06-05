import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/side_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: BoatsAppBar(),
      body: Center(
        child: Text('MAP SCREEN'),
      ),
    );
  }
}
