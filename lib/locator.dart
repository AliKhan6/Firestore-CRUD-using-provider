import 'package:firestorecrud/core/services/api.dart';
import 'package:firestorecrud/core/viewmodels/crud_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => CrudModel());
}