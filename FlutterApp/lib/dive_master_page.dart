import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:deneme/model/dive.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:async';

class DiveMasterPage extends StatefulWidget {
  const DiveMasterPage(
      this._w3mService, this.serverIp, this.diveMasterAddress, this.changePage,
      {super.key});
  final W3MService _w3mService;
  final String serverIp;
  final String diveMasterAddress;
  final void Function(String selected) changePage;

  @override
  State<DiveMasterPage> createState() => _DiveMasterPageState();
}

class _DiveMasterPageState extends State<DiveMasterPage> {
  late W3MService _w3mService;
  late String serverIp;
  late String diveMasterAddress;
  late List<Dive> diveList = [];

  @override
  void initState() {
    _w3mService = widget._w3mService;
    serverIp = widget.serverIp;
    diveMasterAddress = widget.diveMasterAddress;
    getPendingDiveList().then((data) {
      diveList = data;
    }).whenComplete(() => setState(() {}));
    super.initState();
  }

  String getFormattedAddress(diverAddress) {
    int len = diverAddress.toString().length;
    if (len > 8) {
      return diverAddress.substring(0, 4) +
          '...' +
          diverAddress.substring(len - 5, len - 1);
    }
    return diverAddress;
  }

  List<Widget> getList() {
    List<Widget> arr = [];
    for (var dive in diveList) {
      // print(dive);
      List<Widget> row = [];
      row.add(
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              getFormattedAddress(dive.diverAddress),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              utf8.decode((dive.placeName ?? "").codeUnits),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      );
      row.add(const SizedBox(
        width: 10,
      ));
      row.add(Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () async {
            const metamaskUrl = 'metamask://';
            final Uri uri = Uri.parse(metamaskUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
            final result = await _w3mService.requestWriteContract(
              topic: _w3mService.session?.topic ?? ' ',
              chainId: 'eip155:11155111',
              deployedContract: deployedContract,
              functionName: 'logDive',
              transaction: Transaction(
                from:
                    EthereumAddress.fromHex(_w3mService.session?.address ?? ''),
              ),
              parameters: [
                EthereumAddress.fromHex(dive.diverAddress),
                dive.placeId
              ],
            ).timeout(const Duration(seconds: 600), onTimeout: () {
              throw TimeoutException('Transaction took too long');
            });

            print(result);
            updateDB(dive.id);
          },
          child: const Icon(Icons.approval_sharp),
        ),
      ));

      arr.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row,
        ),
      );
      arr.add(const SizedBox(
        height: 5,
      ));
    }
    return arr;
  }

  void updateDB(id) async {
    String backendUrl = 'http://$serverIp:8080/dive/v1/success/$id';
    final response = await http.post(Uri.parse(backendUrl));
    //print('Received JSON data: ${response.body}');
    if (response.statusCode == 200) {
      print(response.body);
      getPendingDiveList().then((data) {
        diveList = data;
      }).whenComplete(() => setState(() {}));
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<List<Dive>> getPendingDiveList() async {
    String backendUrl =
        'http://$serverIp:8080/dive/v1/pending/$diveMasterAddress';
    print(backendUrl);
    final response = await http.get(Uri.parse(backendUrl));
    //print('Received JSON data: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Dive> allMessages = data.map((json) {
        return Dive.fromJson(json);
      }).toList();
      return allMessages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  @override
  Widget build(context) {
    return Column(children: [
      Column(children: getList()),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.white70,
          ),
        ),
        onPressed: () {
          widget.changePage('diver-page');
        },
        child: const Text(
          'Back to Dive Page',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    ]);
  }
}

final deployedContract = DeployedContract(
  ContractAbi.fromJson(
    jsonEncode([
      {"inputs": [], "stateMutability": "nonpayable", "type": "constructor"},
      {
        "anonymous": false,
        "inputs": [
          {
            "indexed": true,
            "internalType": "address",
            "name": "diver",
            "type": "address"
          },
          {
            "indexed": false,
            "internalType": "uint256",
            "name": "newDiveCount",
            "type": "uint256"
          }
        ],
        "name": "DiveLog",
        "type": "event"
      },
      {
        "inputs": [
          {"internalType": "address", "name": "diver", "type": "address"},
          {"internalType": "string", "name": "placeId", "type": "string"}
        ],
        "name": "logDive",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "inputs": [
          {
            "internalType": "address",
            "name": "diveMasterAddress",
            "type": "address"
          }
        ],
        "name": "setDiveMaster",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "inputs": [
          {"internalType": "address", "name": "diver", "type": "address"}
        ],
        "name": "getDiveLog",
        "outputs": [
          {
            "components": [
              {
                "internalType": "uint256",
                "name": "diveCount",
                "type": "uint256"
              },
              {"internalType": "string[]", "name": "places", "type": "string[]"}
            ],
            "internalType": "struct DiverLog.DiveLogType",
            "name": "",
            "type": "tuple"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      }
    ]), // ABI object
    'DiverLog',
  ),
  EthereumAddress.fromHex('0x94a9d6Bd833BFED6823E668a35386ca03Aff5967'),
);
