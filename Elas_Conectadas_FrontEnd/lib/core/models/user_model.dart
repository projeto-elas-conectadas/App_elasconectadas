import 'package:openapi/openapi.dart';

/// Modelo de usuário
class UserModel {
  final String? id;
  final String email;
  final String name;
  final String? phone;
  final String? dob;
  final String? occupation;
  final String? rua;
  final String? numero;
  final String? bairro;
  final String? cidade;
  final String? estado;
  final String? bio;
  final String? pfp; // URL da foto de perfil
  final String? accountStatus; // VERIFIED | UNVERIFIED
  final String? role; // USER | ADMIN

  const UserModel({
    this.id,
    required this.email,
    required this.name,
    this.phone,
    this.dob,
    this.occupation,
    this.rua,
    this.numero,
    this.bairro,
    this.cidade,
    this.estado,
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
      dob: json['dob'] as String?,
      occupation: json['occupation'] as String?,
      rua: json['rua'] as String?,
      numero: json['numero'] as String?,
      bairro: json['bairro'] as String?,
      cidade: json['cidade'] as String?,
      estado: json['estado'] as String?,
      bio: json['bio'] as String?,
      pfp: json['pfp'] as String?,
      accountStatus: json['accountStatus'] as String?,
      role: json['role'] as String?,
    );
  }

  factory UserModel.fromDto(UserResponseDto dto) {
    return UserModel(
      id: dto.id,
      email: dto.email,
      name: dto.name,
      phone: dto.phone,
      dob: dto.dob,
      occupation: dto.occupation,
      rua: dto.rua,
      numero: dto.numero,
      bairro: dto.bairro,
      cidade: dto.cidade,
      estado: dto.estado,
      bio: dto.bio,
      pfp: dto.pfp,
      accountStatus: dto.accountStatus.name,
      role: dto.role.name,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'dob': dob,
        'occupation': occupation,
        'rua': rua,
        'numero': numero,
        'bairro': bairro,
        'cidade': cidade,
        'estado': estado,
        'bio': bio,
        'pfp': pfp,
        'accountStatus': accountStatus,
        'role': role,
      };

  bool get isVerified => accountStatus == 'VERIFIED';
  bool get isAdmin => role == 'ADMIN';

  String get localizacao {
    return [cidade, estado]
        .whereType<String>()
        .where((value) => value.trim().isNotEmpty)
        .map((value) => value.trim())
        .join(' - ');
  }

  /// Initials para o avatar (ex: "Ana Maria" -> "AM")
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '?';
  }
}
