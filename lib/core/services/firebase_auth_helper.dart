import 'package:firestorecrud/core/models/profile.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../emun/auth_status.dart';


class FirebaseAuthHelper with ChangeNotifier {

  FirebaseAuth _auth;
  User _user;
  AuthStatus _status = AuthStatus.Uninitialized;

  FirebaseAuthHelper.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  /// get status to give correct direction to app
  ///
  AuthStatus get status => _status;
  /// get user for checking that user is logged in or not
  ///
  User get user => _user;

  /// get current user for profile
  ///
  Future<User> getCurrentUser() async{
    var user = _auth.currentUser;
    return user;
  }

  /// Sign up function
  ///
  Future<bool> signUp({String email, String password,String name, String phoneNo, String location,String imageUrl, final provider}) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await provider.addUserProfile(Profile(id: authResult.user.uid, name: name, email: email, phoneNo: phoneNo, imageUrl: imageUrl, address: location), authResult.user.uid);
      _status = AuthStatus.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  /// Sign in functon
  ///
  Future<bool> signIn(String email, String password) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.Authenticated;
      return true;
    } catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  /// as the auth state changes this function invokes for setting direction
  ///
  Future<void> _onAuthStateChanged(User user) async {
    if (user == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      _user = user;
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }
}