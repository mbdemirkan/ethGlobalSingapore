import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class NotConnected extends StatelessWidget {
  const NotConnected(this._w3mService, {super.key});

  final W3MService _w3mService;
  @override
  Widget build(context) {
    return Column(
      children: [
        W3MNetworkSelectButton(service: _w3mService),
        W3MConnectWalletButton(service: _w3mService),
      ],
    );
  }
}
