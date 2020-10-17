import 'package:firestorecrud/ui/screens/add_product_screen.dart';
import 'package:firestorecrud/ui/screens/home_screen.dart';
import 'package:firestorecrud/ui/screens/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'add_products':
        return MaterialPageRoute(builder: (_) => AddProductScreen());
      case 'product_details':
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                )
        );
    }
  }
}