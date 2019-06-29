/*import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';
import 'package:http/http.dart' as http;

import './helpers/ensure_visible.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInput = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _addressInput.addListener(_updateLocation);
    super.initState();
  }

  @override
  void dispose() {
    _addressInput.removeListener(_updateLocation);
    super.dispose();
  }

  void getStaticMap(String address) async {
    print('getlocation');
    /* if (address.isEmpty) {
      return;
    }
    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json',
        {'address': address, 'key': 'AIzaSyA2fDW_LSDHLevrlZtrvDqex3tdsm0M-hU'});
    final http.Response response =  await http.get(uri);
    final decodedResponse = json.decode(response.body); */

    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider('AIzaSyA2fDW_LSDHLevrlZtrvDqex3tdsm0M-hU');
    final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
        [Marker('position', 'Position', 41.40338, 2.17403)],
        center: Location(41.40338, 2.17403),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      print('settinguri');
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {
    print('updatelocation');
    if (!_addressInput.hasFocus) {
      getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInput,
          child: TextFormField(
            focusNode: _addressInput,
            controller: _addressInputController,
            decoration: InputDecoration(
              labelText: 'address',
              border: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: new BorderRadius.circular(10)),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString()),
      ],
    );
  }
}*/
