class Child {
  final String name;
  final String parentId;
  final String schoolId;

  Child({
    required this.name,
    required this.parentId,
    required this.schoolId,
  });

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
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