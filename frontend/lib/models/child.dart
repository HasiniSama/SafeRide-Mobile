class Child {

  final String name;
  final String parentUid;
  final String driverUid;
  final String schoolUid;

  Child({
    required this.name,
    required this.parentUid,
    required this.driverUid,
    required this.schoolUid,
  });

  // You can also add a factory constructor to create a Child instance from a map (e.g., from a JSON response)
  factory Child.fromMap(Map<String, dynamic> map) {

    return Child(
      name: map['name'],
      parentUid: map['parentUid'],
      driverUid: map['driverUid'],
      schoolUid: map['schoolUid'],
    );
  }

  // Add a method to convert a Child instance to a map (e.g., to store it in a database)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parentUid': parentUid,
      'driverUid': driverUid,
      'schoolUid': schoolUid,
    };
  }
}
