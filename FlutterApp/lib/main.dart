import 'package:deneme/model/most_dived.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deneme/model/dive.dart';
import 'package:deneme/not_connected.dart';
import 'package:deneme/diver_page.dart';
import 'package:deneme/dive_master_page.dart';

const serverIp = "USE_YOUR_IP_ADDRESS";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late W3MService _w3mService;
  late String currentAddress = '';
  late String placeId;
  late String diveMasterAddress;
  String getMostDivedPersons = "";
  bool diveMasterPage = true;
  bool isDiveMaster = true;
  String currentPage = 'diver-page';

  @override
  void initState() {
    super.initState();
    _initializeW3MService();
  }

  void _initializeW3MService() async {
    // Add your own custom chain to chains presets list to show when using W3MNetworkSelectButton
    // See https://docs.walletconnect.com/appkit/flutter/core/custom-chains
    W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);

    _w3mService = W3MService(
      projectId: 'PROJECT_ID',
      metadata: const PairingMetadata(
        name: 'AppKit Flutter Example',
        description: 'AppKit Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: [
          'https://docs.walletconnect.com/assets/images/web3modalLogo-2cee77e07851ba0a710b56d03d4d09dd.png'
        ],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    await _w3mService.init();
    getMostDivedPersons = await getMostDived();

    setState(() {
      currentAddress = _w3mService.session?.address ?? 'No Address';
    });
  }

  void updateSelectedPlace(String selected) {
    placeId = selected;
  }

  void updateSelectedDiveMaster(String selected) {
    diveMasterAddress = selected;
  }

  Future<String> getMostDived() async {
    final response = await http.post(
      Uri.parse(
          'https://api.studio.thegraph.com/query/89512/diversubgraph/version/latest'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          "{\"query\":\"{diveLogs(orderBy: newDiveCount, orderDirection: desc){diver}}\",\"variables\":{}}",
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"]["diveLogs"];
      List<MostDived> mostDived = data.map((json) {
        return MostDived.fromJson(json);
      }).toList();
      if (mostDived.length > 0) {
        return mostDived[0].address;
      }
    }

    return "";
  }

  void recordDive() async {
    final response = await http.post(
      Uri.parse('http://$serverIp:8080/dive/v1/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(Dive(
        diverAddress: currentAddress,
        placeId: placeId,
        diveMasterAddress: diveMasterAddress,
      ).toJson()),
    );
    print(response);
  }

  void changePage(String pageName) {
    currentPage = pageName;
    setState(() {});
  }

  Widget getPage(String pageName) {
    Widget? page;

    if (pageName == 'diver-page') {
      page = DiverPage(_w3mService, serverIp, updateSelectedPlace,
          updateSelectedDiveMaster, recordDive, isDiveMaster, changePage);
    } else if (pageName == 'dive-master-page') {
      page = DiveMasterPage(_w3mService, serverIp, currentAddress, changePage);
    } else {
      page = const SizedBox(
        height: 1,
      );
    }
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      isDarkMode: true,
      child: MaterialApp(
        title: currentPage,
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(currentPage),
                backgroundColor: Web3ModalTheme.colorsOf(context).background100,
                foregroundColor: Web3ModalTheme.colorsOf(context).foreground100,
              ),
              backgroundColor: Web3ModalTheme.colorsOf(context).background300,
              body: Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    !_w3mService.isConnected
                        ? NotConnected(_w3mService)
                        : getPage(currentPage),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Most Dived Person:",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      getMostDivedPersons,
                      style: const TextStyle(color: Colors.white),
                    ),
                    /*
                    TextButton(
                      onPressed: () async {
                        print("Deneme");
                        const metamaskUrl = 'metamask://';
                        final Uri uri = Uri.parse(metamaskUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                        print("***bekliyoruzz");
                        final result = await _w3mService.request(
                          topic: _w3mService.session!.topic,
                          chainId: _w3mService.selectedChain!.chainId,
                          request: SessionRequestParams(
                            method: 'personal_sign',
                            params: [
                              "xxx",
                              _w3mService.session!.address!,
                            ],
                          ),
                        );
                        print(result);
                      },
                      child: const Text('İmzala'),
                    ),
                    */
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  chainId: '11155111',
  namespace: 'eip155:11155111',
  tokenName: 'SEP',
  rpcUrl: 'https://ethereum-sepolia.publicnode.com',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Etherscan',
    url: 'https://sepolia.etherscan.io/',
  ),
);
