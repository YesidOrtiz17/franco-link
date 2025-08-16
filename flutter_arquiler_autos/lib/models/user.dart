class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? token;

  User({required this.id, required this.name, required this.email, this.phone, this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'token': token,
      };
}
