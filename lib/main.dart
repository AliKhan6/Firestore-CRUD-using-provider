import 'package:firebase_core/firebase_core.dart';
import 'package:firestorecrud/core/viewmodels/crud_model.dart';
import 'package:firestorecrud/router.dart';
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
          ChangeNotifierProvider(create: (_) => locator<CrudModel>()),
        ],
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Provider work',
          theme: ThemeData(),
          onGenerateRoute: Router.generateRoute,
          initialRoute: '/',
      ),
    );
  }
}

