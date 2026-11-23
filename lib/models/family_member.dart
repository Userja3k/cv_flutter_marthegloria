class FamilyMember {
  final int? id;
  final String name;
  final String job;
  final String image;

  FamilyMember({
    this.id,
    required this.name,
    required this.job,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'job': job,
      'image': image,
    };
  }

  factory FamilyMember.fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      job: map['job'] as String? ?? '',
      image: map['image'] as String? ?? '',
    );
  }

  FamilyMember copyWith({
    int? id,
    String? name,
    String? job,
    String? image,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      image: image ?? this.image,
    );
  }
}
