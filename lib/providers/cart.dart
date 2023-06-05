

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List _items = [];
  List get items => _items;

  int _counter = 0;
  int get counter => _counter;

  int getCounter() {
    return _counter;
  }

  Map<String, dynamic> format(){
    return {
      'productOrder': _items
          .where((i) => i['type'] == 'product')
          .map((i) => {
            'product': i['item'],
            'quantity': i['quantity']
          })
          .toList(),
      'serviceOrder': _items
          .where((i) => i['type'] == 'service')
          .map((i) => {
            'service': i['item'],
            'quantity': i['quantity']
          }).toList(),
      'totalQuantity': _counter,
      'totalPrice': getTotal(),
      'address': 'sample address'
    };
  }

  void reset() {
    _counter = 0;
    _items = [];
    notifyListeners();
  }

  int getTotal() {
    int sum = 0;
    for (var item in _items) {
      var index = item['type'] == 'service' ? 'fee' : 'price';
      var price = (item['quantity'] as int) * (item['item'][index] as int);
      sum = sum + price;
    }

    return sum;
  }

  void removeItem(dynamic item) {
      var found = _items.firstWhere((e) => e['item']['_id'] == item['item']['_id'], orElse: () => null);

      if(found != null) {
        _counter--;
        _items.remove(found);
      }
      notifyListeners();
  }

  void addItem(dynamic item, String type) {
    _counter++;

    var found = _items.firstWhere((e) => e['item']['_id'] == item['_id'], orElse: () => null);
    print(found);

    if(found != null) {
      if(type == 'product') {
        found['quantity']++;
      }
    } else {
      _items.add({
        'item': item,
        'quantity': 1,
        'type': type,
      });
    }


    notifyListeners();
  }
}