class Product{
  String id;
  String price;
  String name;
  String img;

  Product({this.id, this.price, this.name, this.img});

  Product.fromJson(Map snapshot, String id):
      this.id = id ?? '',
      this.price = snapshot['price'] ?? '',
      this.name = snapshot['name'] ?? '',
      this.img = snapshot['img'] ?? '';

  toJson(){
    return{
      'price' : this.price,
      'name' : this.name,
      'img' : this.img,
    };
  }
}