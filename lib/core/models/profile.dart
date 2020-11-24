class Profile{
  String id;
  String email;
  String name;
  String imageUrl;
  String phoneNo;
  String address;

  Profile({this.id, this.email, this.name, this.imageUrl, this.phoneNo, this.address});

  Profile.fromJson(Map snapshot, String id) :
        this.id = id ?? '',
        this.email = snapshot['email'] ?? '',
        this.name = snapshot['name'] ?? '',
        this.imageUrl = snapshot['imageUrl'] ?? '',
        this.phoneNo = snapshot['phoneNo'] ?? '',
        this.address = snapshot['address'] ?? '';

  toJson(){
    return{
      'id' : this.id,
      'email' : this.email,
      'name' : this.name,
      'imageUrl' : this.imageUrl,
      'phoneNo' : this.phoneNo,
      'address' : this.address,
    };
  }
}
