import 'dart:convert';

class DiveMaster {
  final String address;
  final String name;

  DiveMaster({
    required this.address,
    required this.name,
  });

  factory DiveMaster.fromJson(Map<String, dynamic> json) {
    return DiveMaster(
      address: json['address'],
      name: utf8.decode(json['name'].codeUnits),
    );
  }

  @override
  String toString() {
    return 'DiveMaster(id: $address, name: $name)';
  }
}
