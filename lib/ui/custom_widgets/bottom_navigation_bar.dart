import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final index;
  CustomBottomNavigationBar(this.index);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,// this will be set when a new tab is tapped
      onTap: (int index){
        setState(() {
          if(index == 0){
            Navigator.pushReplacementNamed(context, 'home_screen');
          } else if(index == 1){
            Navigator.pushReplacementNamed(context, 'search_screen');
          }else if(index == 2){
            Navigator.pushReplacementNamed(context, 'chat_screen');
          }else if(index == 3){
            Navigator.pushReplacementNamed(context, 'cart_screen');
          }else{
            Navigator.pushReplacementNamed(context, 'more_screen');
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text('More')
        ),
      ],
    );
  }
}
