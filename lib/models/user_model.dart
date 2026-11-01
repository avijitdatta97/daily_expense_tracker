class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final bool isPhoneVerified;
  final String provider;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.isPhoneVerified,
    required this.provider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      provider: json['provider'] ?? 'LOCAL',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isPhoneVerified': isPhoneVerified,
      'provider': provider,
    };
  }
}