import 'package:firestorecrud/core/services/firebase_auth_helper.dart';
import 'package:firestorecrud/core/services/database_service.dart';
import 'package:firestorecrud/core/viewmodels/produts_view_model.dart';
import 'package:firestorecrud/core/viewmodels/profile_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton(() => ProductsViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => FirebaseAuthHelper.instance());
}