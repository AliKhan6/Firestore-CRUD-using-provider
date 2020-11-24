import 'package:firestorecrud/ui/screens/add_product_screen.dart';
import 'package:firestorecrud/ui/screens/cart_screen.dart';
import 'package:firestorecrud/ui/screens/chat_screen.dart';
import 'package:firestorecrud/ui/screens/home_screen.dart';
import 'package:firestorecrud/ui/screens/more_screen.dart';
import 'package:firestorecrud/ui/screens/profile_screen.dart';
import 'package:firestorecrud/ui/screens/search_screen.dart';
import 'package:firestorecrud/ui/screens/signin_screen.dart';
import 'package:firestorecrud/ui/screens/product_detail_screen.dart';
import 'package:firestorecrud/ui/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home_screen' :
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'search_screen':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case 'chat_screen':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case 'cart_screen':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case 'more_screen':
        return MaterialPageRoute(builder: (_) => MoreScreen());
      case 'profile_screen':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case 'add_products':
        return MaterialPageRoute(builder: (_) => AddProductScreen());
      case 'product_details':
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      case 'sign_in_screen':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case 'sign_up_screen':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
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