import 'package:furniture/itemController.dart';
import 'package:get/get.dart';

class cartData extends GetxController {
  List<Furniture> _items = [];

  List<Furniture> get items {
    return [..._items];
  }

  void addItem(Furniture) {
    _items.insert(0, Furniture);
  }

  void addQty(name) {
    var firstItem = _items.firstWhere((item) => item.name == name);
    firstItem.Typ++;
  }

  void removeQty(name) {
    var firstItem = _items.firstWhere((item) => item.name == name);
    if (firstItem.Typ > 1) {
      firstItem.Typ--;
    } else {
      firstItem.Typ = 1;
    }
  }

  var totalA = 0.obs;
  void sumTotal() {
    for (var item in _items) {
      totalA += item.Price.toInt();
    }
  }

  void total() {
    num totalprice = 0;
    _items.forEach((element) {
      totalprice += element.Price.toInt() * element.Typ;
    });
    totalA = totalprice.toInt().obs;
  }

  bool available(name) {
    var availablename = false;
    _items.forEach((element) {
      if (element.name != name) {
        availablename = false;
      } else {
        availablename = true;
      }
      ;
    });
    return availablename;
  }
}
