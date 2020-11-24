import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  /// database reference to all functions
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  /// Collection reference for products
  CollectionReference productRef = FirebaseFirestore.instance.collection('products');
  /// Collection reference for profile data
  CollectionReference profileRef = FirebaseFirestore.instance.collection('profile');

  //// *********************************************************** ////
  ///  These functions will do all the operations on Products data ////
  //// *********************************************************** ////
  
  Future<QuerySnapshot> getProductsData(){
    return _db.collection('products').get();
  }

  Stream<QuerySnapshot> getProductsDataStream(){
    return _db.collection('products').snapshots();
  }

  Future<DocumentSnapshot> getProductById(String id){
    return _db.collection('products').doc(id).get();
  }

  Future<void> removeProduct(String id){
    return _db.collection('products').doc(id).delete();
  }

  Future<DocumentReference> addProduct(Map data){
    return productRef.add(data);
  }

  Future<void> updateProduct(Map data, String id){
    return productRef.doc(id).update(data);
  }

  //// *********************************************************** ////
  ///  These functions will do all the operations on Profile data ////
  //// *********************************************************** ////

  Future<DocumentReference> addUserProfile(Map data, String id){
    return profileRef.doc(id).set(data);
  }
/// Function for getting profile of specific user using his " document id "
//  Stream getUserProfileData(String id){
//    return _db.collection('profile').doc(id).snapshots();
//  }

    Stream<QuerySnapshot> getUserProfileStream(){
     return _db.collection('profile').snapshots();
    }

  Future<void> editProfile(Map data, String id){
    return profileRef.doc(id).update(data);
  }
}