import 'package:firestorecrud/core/models/more_data.dart';
import 'package:flutter/material.dart';

class MoreDataViewModel extends ChangeNotifier{
  List<MoreData> moreScreenData = [
    MoreData(
        icon: Icons.person,
        name: 'Profile',
    ),
    MoreData(
      icon: Icons.favorite_border,
      name: 'Favourite',
    ),
    MoreData(
        icon: Icons.notifications,
        name: 'Notifications'
    ),
    MoreData(
        icon: Icons.subdirectory_arrow_left,
        name: 'Logout'
    ),
  ];
}