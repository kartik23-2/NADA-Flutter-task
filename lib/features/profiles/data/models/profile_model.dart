class Profile {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String city;
  final String? community;
  final String? profession;
  final String? education;
  final int? degree;
  final String? connectedThrough;
  final String? about;

  const Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    this.community,
    this.profession,
    this.education,
    this.degree,
    this.connectedThrough,
    this.about,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String?)?.trim() ?? 'Unknown',
      age: json['age'] as int? ?? 0,
      gender: (json['gender'] as String?)?.trim() ?? '',
      city: (json['city'] as String?)?.trim() ?? '',
      community: _normalizeNullableString(json['community']),
      profession: _normalizeNullableString(json['profession']),
      education: _normalizeNullableString(json['education']),
      degree: json['degree'] as int?,
      connectedThrough: _normalizeNullableString(json['connected_through']),
      about: _normalizeNullableString(json['about']),
    );
  }

  static String? _normalizeNullableString(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final trimmed = value.trim();
      return trimmed.isEmpty ? null : trimmed;
    }
    return value.toString().trim();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'city': city,
      if (community != null) 'community': community,
      if (profession != null) 'profession': profession,
      if (education != null) 'education': education,
      if (degree != null) 'degree': degree,
      if (connectedThrough != null) 'connected_through': connectedThrough,
      if (about != null) 'about': about,
    };
  }

  bool get hasConnection =>
      connectedThrough != null && connectedThrough!.trim().isNotEmpty;

  String get connectionDisplayText =>
      hasConnection ? connectedThrough! : 'No connection yet';

  String get genderDisplay {
    if (gender.toUpperCase() == 'F') return 'Female';
    if (gender.toUpperCase() == 'M') return 'Male';
    return gender.isNotEmpty ? gender : 'Not specified';
  }

  String? get degreeDisplay {
    if (degree == null) return null;
    switch (degree) {
      case 1:
        return '1st degree connection';
      case 2:
        return '2nd degree connection';
      case 3:
        return '3rd degree connection';
      default:
        return '${degree}th degree connection';
    }
  }

  /// Initial letters for user avatar (e.g. "Ananya Sharma" -> "AS")
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    final firstChar = parts.first.substring(0, 1);
    final lastChar = parts.last.substring(0, 1);
    return '$firstChar$lastChar'.toUpperCase();
  }
}
