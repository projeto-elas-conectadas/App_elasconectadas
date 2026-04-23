/// Modelo de requisição de login
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

/// Modelo de resposta do login (token JWT)
class LoginResponse {
  final String? token;
  final String? message;

  const LoginResponse({this.token, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String?,
      message: json['message'] is List
          ? (json['message'] as List).join(', ')
          : json['message'] as String?,
    );
  }
}

/// Modelo de requisição de registro
class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String dob; // DD/MM/AAAA

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.dob,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'phone': phone,
    'dob': dob,
  };
}

/// Modelo de usuário
class UserModel {
  final String? id;
  final String email;
  final String name;
  final String? phone;
  final String? occupation;
  final String? location;
  final String? bio;
  final String? pfp; // URL da foto de perfil
  final String? accountStatus; // VERIFIED | UNVERIFIED
  final String? role; // USER | ADMIN

  const UserModel({
    this.id,
    required this.email,
    required this.name,
    this.phone,
    this.occupation,
    this.location,
    this.bio,
    this.pfp,
    this.accountStatus,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String?,
      occupation: json['occupation'] as String?,
      location: json['location'] as String?,
      bio: json['bio'] as String?,
      pfp: json['pfp'] as String?,
      accountStatus: json['accountStatus'] as String?,
      role: json['role'] as String?,
    );
  }

  bool get isVerified => accountStatus == 'VERIFIED';
  bool get isAdmin => role == 'ADMIN';

  /// Initials para o avatar (ex: "Ana Maria" -> "AM")
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty && parts[0].isNotEmpty) return parts[0][0].toUpperCase();
    return '?';
  }
}
