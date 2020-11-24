import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestorecrud/core/models/product.dart';
import 'package:firestorecrud/core/services/database_service.dart';
import 'package:flutter/material.dart';
import '../../locator.dart';


class ProductsViewModel extends ChangeNotifier{
  DatabaseService _databaseService = locator<DatabaseService>();

  List<Product> products;

  Future<List<Product>> fetchProducts() async {
    var result = await _databaseService.getProductsData();
    products = result.docs
        .map((doc) => Product.fromJson(doc.data(), doc.id))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream(){
    return _databaseService.getProductsDataStream();
  }

  Future<Product> getProductById(String id) async{
    var doc = await _databaseService.getProductById(id);
    return Product.fromJson(doc.data(), id);
  }

  Future removeProduct(String id) async{
    await _databaseService.removeProduct(id);
    return;
  }

  Future updateProduct(Product data, String id) async{
    await _databaseService.updateProduct(data.toJson(), id);
    return;
  }

  Future addProduct(Product data) async{
    await _databaseService.addProduct(data.toJson());
    return;
  }
}