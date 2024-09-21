class Dive {
  String? id;
  final String diverAddress;
  final String placeId;
  final String diveMasterAddress;
  String? placeName;

  Dive({
    required this.diverAddress,
    required this.placeId,
    required this.diveMasterAddress,
  });

  Dive.withId({
    required this.id,
    required this.diverAddress,
    required this.placeId,
    required this.diveMasterAddress,
    required this.placeName,
  });

  factory Dive.fromJson(Map<String, dynamic> json) {
    return Dive.withId(
      id: json['id'],
      diverAddress: json['diverAddress'],
      placeId: json['placeId'],
      diveMasterAddress: json['diveMasterAddress'],
      placeName: json['placeName'],
    );
  }

  @override
  String toString() {
    return 'Dive(id: $id, diverAddress: $diverAddress, placeId: $placeId, diveMasterAddress: $diveMasterAddress, placeName: $placeName)';
  }

  Map<String, dynamic> toJson() {
    return {
      'diverAddress': diverAddress,
      'placeId': placeId,
      'diveMasterAddress': diveMasterAddress,
    };
  }
}
