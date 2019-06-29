import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';

import './pages/authentication.dart';
import './pages/item_admin.dart';
import './pages/home.dart';
import './pages/item_details.dart';
import './scoped-models/main_scoped_model.dart';
import './models/item_model.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // MapView.setApiKey('AIzaSyA2fDW_LSDHLevrlZtrvDqex3tdsm0M-hU');
  MapView.setApiKey('AIzaSyAIZ1SPf-2xwgrmndbp7TImdyQK5HZ4ihk');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
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
          "/": (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : HomePage(_model),
          "/admin": (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ItemsAdmin(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') return null;
          if (pathElements[1] == 'item') {
            final String itemUid = pathElements[2];
            final Item item = _model.allItems.firstWhere((Item item) {
              return item.id == itemUid;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : Details(item),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : HomePage(_model));
        },
      ),
    );
  }
}
