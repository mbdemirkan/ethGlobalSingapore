import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deneme/model/dive_master.dart';

class DiveMasterDropdownMenu extends StatefulWidget {
  const DiveMasterDropdownMenu(this.serverIp, this.updateSelected, {super.key});

  final String serverIp;
  final void Function(String selected) updateSelected;

  @override
  State<DiveMasterDropdownMenu> createState() => _DiveMasterDropdownMenuState();
}

class _DiveMasterDropdownMenuState extends State<DiveMasterDropdownMenu> {
  late String serverIp;

  @override
  void initState() {
    super.initState();
    serverIp = widget.serverIp;
  }

  Future<List<DiveMaster>> getDiveMasterList() async {
    String backendUrl = 'http://$serverIp:8080/dive-master/v1/';
    final response = await http.get(Uri.parse(backendUrl));
    //print('Received JSON data: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<DiveMaster> allMessages = data.map((json) {
        return DiveMaster.fromJson(json);
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
        child: Text('Dive Master:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      FutureBuilder<List<DiveMaster>>(
        future: getDiveMasterList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
              // Initial Value
              value: dropDownValue,
              hint: const Text(
                'Select Dive Master',
                style: TextStyle(color: Colors.white),
              ),
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: snapshot.data!.map((item) {
                return DropdownMenuItem(
                  value: item.address,
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
      )
    ]);
  }
}
