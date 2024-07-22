class School {
  final double lng;
  final double lat;
  final String name;

  School({
    required this.lng,
    required this.lat,
    required this.name,
  });

  factory School.fromMap(Map<dynamic, dynamic> map) {
    return School(
      lng: map['lng'] as double,
      lat: map['lat'] as double,
      name: map['name'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is School &&
        other.name == name &&
        other.lat == lat &&
        other.lng == lng;
  }

  // Override hashCode
  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ lng.hashCode;


  Map<String, dynamic> toMap() {
    return {
      'lng': lng,
      'lat': lat,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'School(name: $name, lat: $lat, lng: $lng)';
  }
}
