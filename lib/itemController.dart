import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Furniture {
  var Typ;
  String name;
  String desciption;
  double Price;
  String imageUrl;

  Furniture({
    required this.Typ,
    required this.name,
    required this.desciption,
    required this.imageUrl,
    required this.Price,
  });
}

class furnitureData extends GetxController {
  List<Furniture> _items = [];

  List<Furniture> get items {
    return [..._items];
  }

  Future<void> putdata() async {
    final url =
        "https://furnitureapp-84ac1-default-rtdb.firebaseio.com/furniture.json";

    for (var i = 0; i <= items.length; i++) {
      await http.post(Uri.parse(url),
          body: jsonEncode({
            "typ": items[i].Typ,
            "name": items[i].name,
            "imageUrl": items[i].imageUrl,
            "description": items[i].desciption,
            "Price": items[i].Price
          }));
    }
  }

  Future<void> fetchData() async {
    print('fetching Data ..');
    String url =
        "https://furnitureapp-84ac1-default-rtdb.firebaseio.com/furniture.json";
    final response = await http.get(Uri.parse(url));
    final fetchedData = jsonDecode(response.body) as Map<String, dynamic>;
    // if (fetchedData.isEmpty) {

    //   return;
    // }
    print('Fetched Data lenght : ${fetchedData.toString()}');
    List<Furniture> fetchedlist = [];
    fetchedData.forEach((itemId, itemData) {
      print('item typ : ${itemData['typ']}');
      fetchedlist.add(
        Furniture(
            Typ: itemData["typ"],
            name: itemData["name"],
            desciption: itemData["description"],
            imageUrl: itemData['imageUrl'],
            Price: itemData['Price']),
      );
      _items = fetchedlist;
      print(_items);
    });
  }
}
