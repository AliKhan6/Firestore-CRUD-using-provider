import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestorecrud/core/emun/auth_status.dart';
import 'package:firestorecrud/core/models/profile.dart';
import 'package:firestorecrud/core/services/database_service.dart';
import 'package:firestorecrud/locator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier{
  DatabaseService _databaseService = locator<DatabaseService>();
  AuthStatus _status;


  /// get status to give correct direction to app
  ///
  AuthStatus get status => _status;

  String imageUrl;
  ///
  /// Image reference require for uploading to storage
  StorageReference imageRef;
  StorageUploadTask imageUpload;

  ///
  /// Add user profile data to cloud firestore
  ///
  Future addUserProfile(Profile data, String id) async{
    await _databaseService.addUserProfile(data.toJson(),id);
    return;
  }

  User _user;
  User get user => _user;
  Stream fetchUserProfileData(){
      return _databaseService.getUserProfileStream();
  }

  Future editProfile(Profile data, String id) async{
    _status = AuthStatus.Authenticating;
    notifyListeners();
    await _databaseService.editProfile(data.toJson(), id);
    _status = AuthStatus.Authenticated;
    notifyListeners();
    return;
  }

  //// **************************************************************************************************** ////
  ///  this function will pick image from gallery and upload it to firebase storage giving us it's url link ////
  //// ***************************************************************************************************  ////

  Future uploadImageToStorage() async {
    try  {
      var tempImage= await ImagePicker.pickImage(source: ImageSource.gallery);
      imageRef = FirebaseStorage.instance.ref().child("Profile_Images");
      imageUpload = imageRef.putFile(tempImage, StorageMetadata(contentType: 'image/png'));
      var uploadComplete = await imageUpload.onComplete;
      var downloadUrl = await uploadComplete.ref.getDownloadURL();
      imageUrl = downloadUrl.toString();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}