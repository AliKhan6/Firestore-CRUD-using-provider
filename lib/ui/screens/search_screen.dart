import 'package:firestorecrud/ui/custom_widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search screen'),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(1)
    );
  }
}
