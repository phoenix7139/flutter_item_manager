import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

// import './item_adder.dart';
import './pages/authentication.dart';
import './pages/item_admin.dart';
import './pages/home.dart';
import './pages/item_details.dart';
import './scoped-models/main_scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff2f8189),
          // primarySwatch: Color(),
          accentColor: Color(0xffb4f1f1),
          // fontFamily: 'Oswald'
        ),
        // home: AuthPage(),
        routes: {
          "/": (BuildContext context) => AuthPage(),
          "/display": (BuildContext context) => HomePage(model),
          "/admin": (BuildContext context) => ItemsAdmin(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') return null;
          if (pathElements[1] == 'item') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => Details(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage(model));
        },
      ),
    );
  }
}
