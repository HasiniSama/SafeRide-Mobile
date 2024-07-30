class Child {
  final String name;
  final String parentId;
  final String schoolName;
  final String district;
  final String tripStartingLocationName;
  final double tripStartingLocationLng;
  final double tripStartingLocationLat;
  final String? selectedBusId;
  final String? id;

  Child({
    required this.name,
    required this.parentId,
    required this.schoolName,
    required this.district,
    required this.tripStartingLocationName,
    required this.tripStartingLocationLng,
    required this.tripStartingLocationLat,
    this.selectedBusId,
    this.id,
  });

  factory Child.fromMap(Map<String, dynamic> map, String? key) {
    return Child(
      id: key,
      name: map['name'] ?? 'Unknown',
      parentId: map['parentId'] ?? 'Unknown',
      schoolName: map['school'] != null ? map['school']['name'] ?? 'Unknown' : 'Unknown',
      district: map['district'] ?? 'Unknown',
      tripStartingLocationName: map['tripStartingLocation'] != null ? map['tripStartingLocation']['locationName'] ?? 'Unknown' : 'Unknown',
      tripStartingLocationLng: map['tripStartingLocation'] != null ? map['tripStartingLocation']['lng'] ?? 0.0 : 0.0,
      tripStartingLocationLat: map['tripStartingLocation'] != null ? map['tripStartingLocation']['lat'] ?? 0.0 : 0.0,
      selectedBusId: map['selectedBusId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parentId': parentId,
      'school': {
        'name': schoolName,
      },
      'district': district,
      'tripStartingLocation': {
        'locationName': tripStartingLocationName,
        'lng': tripStartingLocationLng,
        'lat': tripStartingLocationLat,
      },
      'selectedBusId': selectedBusId,
    };
  }
}
