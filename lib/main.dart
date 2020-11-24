import 'package:firebase_core/firebase_core.dart';
import 'package:firestorecrud/core/emun/auth_status.dart';
import 'package:firestorecrud/core/services/firebase_auth_helper.dart';
import 'package:firestorecrud/core/viewmodels/more_data_view_model.dart';
import 'package:firestorecrud/core/viewmodels/produts_view_model.dart';
import 'package:firestorecrud/core/viewmodels/profile_view_model.dart';
import 'package:firestorecrud/router.dart';
import 'package:firestorecrud/ui/screens/home_screen.dart';
import 'package:firestorecrud/ui/screens/signin_screen.dart';
import 'package:firestorecrud/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // locator for firebase authentication stuff
          ChangeNotifierProvider(create: (_) => locator<FirebaseAuthHelper>(),),
          // locator for profile data communication
          ChangeNotifierProvider(create: (_) => locator<ProfileViewModel>(),),
          // locator for working on products data
          ChangeNotifierProvider(create: (_) => locator<ProductsViewModel>()),
          // more data view model
          ChangeNotifierProvider(create: (_) => MoreDataViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Router.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: Consumer(
            ///
            /// Use all these for selection of correct flow of app
            ///
              builder: (context, FirebaseAuthHelper auth, _,){
                switch (auth.status){
                  case AuthStatus.Uninitialized:
                    // this is used for navigation to sign up screen
                    return SignUpScreen();
                  case AuthStatus.Authenticating:
                    return SignInScreen();
                  case AuthStatus.Unauthenticated:
                    return SignInScreen();
                  case AuthStatus.Authenticated:
                    return HomeScreen();
                }
                return SignInScreen();
              }
          ),
        )
    );

  }
}

