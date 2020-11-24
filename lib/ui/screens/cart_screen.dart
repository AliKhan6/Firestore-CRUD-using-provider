import 'package:firestorecrud/ui/custom_widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cart screen'),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(3)

    );
  }
}