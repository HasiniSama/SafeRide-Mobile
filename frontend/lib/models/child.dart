class Child {
  final String name;
  final String parentId;
  final String schoolId;
  final String? id;

  Child({
    required this.name,
    required this.parentId,
    required this.schoolId,
    this.id,
  });

  factory Child.fromMap(Map<String, dynamic> map, String? key) {
    return Child(
      id: key,
      name: map['name'],
      parentId: map['parentId'],
      schoolId: map['schoolId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parentId': parentId,
      'schoolId': schoolId,
    };
  }
}