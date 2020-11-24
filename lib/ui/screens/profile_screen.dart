import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestorecrud/core/constants/text_styles.dart';
import 'package:firestorecrud/core/models/profile.dart';
import 'package:firestorecrud/core/viewmodels/profile_view_model.dart';
import 'package:firestorecrud/ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {

  // Current user variables
  FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;
  List profile;

  @override
  void initState() {
    // get current user uid when this screen launches
    uid = _auth.currentUser.uid;
    print("Id: ${_auth.currentUser.uid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: profileProvider.fetchUserProfileData(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              profile = snapshot.data.docs.map((doc) => Profile.fromJson(doc.data(), doc.id)).toList();
              return ListView.builder(
                  itemCount: profile.length,
                  itemBuilder: (context, index){
                    return
                      ///
                      /// This line will check for a current user data to get for his profile
                      ///
                      uid == profile[index].id ?
                      Container(
                        height: MediaQuery.of(context).size.height*0.86,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: 60,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                      child: Image.network(profile[index].imageUrl)),
                                ),
                                SizedBox(height: 25,),
                                Text(profile[index].name,style: profileText,),
                                SizedBox(height: 35,),
                                customProfileData(profile[index].email, Icons.email),
                                SizedBox(height: 35,),
                                customProfileData(profile[index].phoneNo, Icons.phone),
                                SizedBox(height: 35,),
                                customProfileData(profile[index].address, Icons.location_on),
                              ],
                              ),
                            ),

                            ///
                            /// Edit Profile Button Leads to profile edit screen
                            ///
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen(
                                  profile: profile[index],
                                )));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 50,
                                  color: Colors.red,
                                  child: Center(child: Text('Edit Profile', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 18),)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ) : Container();
                  }
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }

  /// This function is custom for address, email and phone number area
  ///
  Widget customProfileData(String data, IconData icon){
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.red[300],),
            SizedBox(width: 20,),
            Text(data),
          ],
        ),
      ),
    );
  }
}
