class MostDived {
  final String address;

  MostDived({
    required this.address,
  });

  factory MostDived.fromJson(Map<String, dynamic> json) {
    return MostDived(
      address: json['diver'],
    );
  }

  @override
  String toString() {
    return 'MostDived(id: $address)';
  }
}
