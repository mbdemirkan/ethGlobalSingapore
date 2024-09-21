import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deneme/model/place.dart';

class PlaceDropdownMenu extends StatefulWidget {
  const PlaceDropdownMenu(this.serverIp, this.updateSelected, {super.key});

  final String serverIp;
  final void Function(String selected) updateSelected;

  @override
  State<PlaceDropdownMenu> createState() => _PlaceDropdownMenuState();
}

class _PlaceDropdownMenuState extends State<PlaceDropdownMenu> {
  late String serverIp;

  @override
  void initState() {
    super.initState();
    serverIp = widget.serverIp;
  }

  Future<List<Place>> getPlaceList() async {
    String backendUrl = 'http://$serverIp:8080/place/v1/';
    final response = await http.get(Uri.parse(backendUrl));
    //print('Received JSON data: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Place> allMessages = data.map((json) {
        return Place.fromJson(json);
      }).toList();
      return allMessages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  var dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('Place:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      FutureBuilder<List<Place>>(
        future: getPlaceList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
              // Initial Value
              value: dropDownValue,
              hint: const Text(
                'Select place',
                style: TextStyle(color: Colors.white),
              ),
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: snapshot.data!.map((item) {
                return DropdownMenuItem(
                  value: item.id,
                  child: Text(
                    item.name.toString(),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                dropDownValue = value;
                print("Selected:" + dropDownValue);
                widget.updateSelected(value as String);
                setState(() {});
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ]);
  }
}
