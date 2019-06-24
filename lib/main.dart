import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// import './item_adder.dart';
import './pages/authentication.dart';
import './pages/item_admin.dart';
import './pages/home.dart';
import './pages/item_details.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _bucketlist = [];

  void _addItem(Map<String, dynamic> item) {
    setState(() {
      _bucketlist.add(item);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _bucketlist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff2d767f),
          // primarySwatch: Color(),
          accentColor: Color(0xffb4f1f1),
          // fontFamily: 'Oswald'
          ),
      // home: AuthPage(),
      routes: {
        "/": (BuildContext context) =>
            AuthPage(),
        "/display": (BuildContext context) =>
            HomePage(_bucketlist),
        "/admin": (BuildContext context) => ProductsAdmin(_addItem, _deleteItem),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'item') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => Details(
                  _bucketlist[index]['title'], _bucketlist[index]['image']));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePage(_bucketlist));
      },
    );
  }
}
