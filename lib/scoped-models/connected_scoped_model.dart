import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/item_model.dart';

mixin ConnectedModel on Model {
  List<Item> _bucketlist = [];
  String _currentItemId;
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin ItemModel on ConnectedModel {
  bool _showFavourites = false;

  List<Item> get allItems {
    return List.from(_bucketlist);
  }

  List<Item> get displayedItems {
    if (_showFavourites) {
      return _bucketlist.where(
        (Item item) {
          return item.isFavourite;
        },
      ).toList();
    }
    return List.from(_bucketlist);
  }

  int get selectedItemIndex {
    return _bucketlist.indexWhere((Item item) {
      return item.id == _currentItemId;
    });
  }

  String get selectedItemId {
    return _currentItemId;
  }

  Item get selectedItem {
    if (selectedItemId == null) {
      return null;
    }
    return _bucketlist.firstWhere((Item item) {
      return item.id == _currentItemId;
    });
  }

  bool get displayFavourites {
    return _showFavourites;
  }

  Future<bool> addItem(
      String title, String description, String image, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> itemData = {
      'title': title,
      'description': description,
      'image':
          'https://www.doublclicks.com/wp-content/uploads/2013/05/blurred-background-3.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    try {
      final http.Response response = await http.post(
          'https://flutter-item-manager.firebaseio.com/items.json',
          body: json.encode(itemData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      Item _tempItem = Item(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _bucketlist.add(_tempItem);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateItem(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateItem = {
      'title': title,
      'description': description,
      'image':
          'https://www.doublclicks.com/wp-content/uploads/2013/05/blurred-background-3.jpg',
      'price': price,
      'userEmail': selectedItem.userEmail,
      'userId': selectedItem.userId
    };
    return http
        .put(
            'https://flutter-item-manager.firebaseio.com/items/${selectedItem.id}.json',
            body: json.encode(updateItem))
        .then((http.Response response) {
      _isLoading = false;
      final Item _tempItem = Item(
          id: selectedItem.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: selectedItem.userEmail,
          userId: selectedItem.userId);
      _bucketlist[selectedItemIndex] = _tempItem;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteItem() {
    _isLoading = true;
    final deletedItemId = selectedItem.id;
    _bucketlist.removeAt(selectedItemIndex);
    _currentItemId = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-item-manager.firebaseio.com/items/$deletedItemId.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchItems() {
    _isLoading = true;
    notifyListeners();
    return http
        .get('https://flutter-item-manager.firebaseio.com/items.json')
        .then<Null>((http.Response response) {
      final List<Item> fetchedItemsList = [];
      final Map<String, dynamic> fetchedItemsData = json.decode(response.body);
      if (fetchedItemsData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      fetchedItemsData.forEach((String itemUid, dynamic fetchedItemData) {
        final Item item = Item(
          id: itemUid,
          title: fetchedItemData['title'],
          description: fetchedItemData['description'],
          price: fetchedItemData['price'],
          image: fetchedItemData['image'],
          userEmail: fetchedItemData['userEmail'],
          userId: fetchedItemData['userId'],
        );
        fetchedItemsList.add(item);
      });
      _bucketlist = fetchedItemsList;
      _isLoading = false;
      notifyListeners();
      _currentItemId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void toggleIsFavourite() {
    final bool isCurrentlyFavourite = !selectedItem.isFavourite;
    final Item updatedItem = Item(
        id: selectedItem.id,
        title: selectedItem.title,
        description: selectedItem.description,
        price: selectedItem.price,
        image: selectedItem.image,
        userEmail: selectedItem.userEmail,
        userId: selectedItem.userId,
        isFavourite: isCurrentlyFavourite);
    _bucketlist[selectedItemIndex] = updatedItem;
    notifyListeners();
    _currentItemId = null;
  }

  void selectItem(String itemUid) {
    _currentItemId = itemUid;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '7139', email: email, password: password);
  }
}

mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
