import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:deneme/select_place.dart';
import 'package:deneme/select_dive_master.dart';

class DiverPage extends StatelessWidget {
  const DiverPage(
      this._w3mService,
      this.serverIp,
      this.updateSelectedPlace,
      this.updateSelectedDiveMaster,
      this.recordDive,
      this.isDiveMaster,
      this.changePage,
      {super.key});

  final W3MService _w3mService;
  final String serverIp;
  final void Function(String selected) updateSelectedPlace;
  final void Function(String selected) updateSelectedDiveMaster;
  final void Function() recordDive;
  final bool isDiveMaster;
  final void Function(String selected) changePage;

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        W3MAccountButton(service: _w3mService),
        PlaceDropdownMenu(serverIp, updateSelectedPlace),
        DiveMasterDropdownMenu(serverIp, updateSelectedDiveMaster),
        Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: recordDive,
            child: const Icon(Icons.add),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: isDiveMaster
              ? OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white70,
                    ),
                  ),
                  onPressed: () {
                    changePage('dive-master-page');
                  },
                  child: const Text(
                    'Show Pending Records',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                )
              : const SizedBox(
                  height: 1,
                ),
        ),
      ],
    );
  }
}
