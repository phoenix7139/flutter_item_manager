import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/user_model.dart';
import '../models/item_model.dart';
import '../models/auth_mode.dart';

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
          'https://media.istockphoto.com/photos/blurred-backgroundabstract-background-with-bokeh-defocused-ligh-picture-id483416992?k=6&m=483416992&s=612x612&w=0&h=eEASdxV0G3OqF0k_IlKjU4FwMuBud231aqMSFu1IAh8=',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
    };
    try {
      final http.Response response = await http.post(
          'https://flutter-item-manager.firebaseio.com/items.json?auth=${_authenticatedUser.token}',
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
          'https://media.istockphoto.com/photos/blurred-backgroundabstract-background-with-bokeh-defocused-ligh-picture-id483416992?k=6&m=483416992&s=612x612&w=0&h=eEASdxV0G3OqF0k_IlKjU4FwMuBud231aqMSFu1IAh8=',
      'price': price,
      'userEmail': selectedItem.userEmail,
      'userId': selectedItem.userId
    };
    return http
        .put(
            'https://flutter-item-manager.firebaseio.com/items/${selectedItem.id}.json?auth=${_authenticatedUser.token}',
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
            'https://flutter-item-manager.firebaseio.com/items/$deletedItemId.json?auth=${_authenticatedUser.token}')
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
        .get(
            'https://flutter-item-manager.firebaseio.com/items.json?auth=${_authenticatedUser.token}')
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
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.LoginMode]) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (mode == AuthMode.LoginMode) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDtNV_F79kyx1wdyIOBN6U3Rust7AwKJi8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDtNV_F79kyx1wdyIOBN6U3Rust7AwKJi8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'something went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'authenticated';
      _authenticatedUser = User(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken'],
      );
      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiry =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('expiry', expiry.toIso8601String());
      prefs.setString('token', responseData['idToken']);
      prefs.setString('email', email);
      prefs.setString('id', responseData['localId']);
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'email already exists';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'email does not exist';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'invalid password';
    }

    _isLoading = false;
    notifyListeners();

    return {
      'success': !hasError,
      'message': message,
    };
  }

  void autoAuthenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _token = prefs.getString('token');
    final String _expiryTime = prefs.getString('expiry');
    if (_token != null) {
      final DateTime now = DateTime.now();
      final DateTime _expiry = DateTime.parse(_expiryTime);
      if (_expiry.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String _email = prefs.getString('email');
      final String _id = prefs.getString('id');
      final int _tokenLifeSpan = _expiry.difference(now).inSeconds;
      _userSubject.add(true);
      setAuthTimeout(_tokenLifeSpan);
      _authenticatedUser = User(
        id: _id,
        email: _email,
        token: _token,
      );
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer.cancel();
    _userSubject.add(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('email');
    prefs.remove('id');
    notifyListeners();
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), () {
      logout();
    });
  }
}

mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
