import 'package:elasconectadas_app/core/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

void main() {
  test('serializa a foto de perfil no CreateUserDto gerado', () {
    final dto = CreateUserDto((builder) => builder
      ..email = 'empreendedora@teste.com'
      ..password = 'SenhaSegura123!'
      ..name = 'Maria da Silva'
      ..phone = '(43) 99999-8888'
      ..dob = '15/05/1995'
      ..pfp = 'https://res.cloudinary.com/teste/perfil.jpg');

    final json = standardSerializers.serializeWith(
      CreateUserDto.serializer,
      dto,
    ) as Map<String, dynamic>;

    expect(json['pfp'], 'https://res.cloudinary.com/teste/perfil.jpg');
  });

  test('desserializa a usuária tipada recebida no login', () {
    final dto = standardSerializers.deserializeWith(
      LoginResponseDto.serializer,
      const <String, dynamic>{
        'access_token': 'jwt-de-teste',
        'user': <String, dynamic>{
          'id': '42ddab2c-6d0b-4cf6-8075-8dc038c5096e',
          'email': 'empreendedora@teste.com',
          'name': 'Maria da Silva',
          'phone': '(43) 99999-8888',
          'pfp': 'https://res.cloudinary.com/teste/perfil.jpg',
          'role': 'USER',
          'accountStatus': 'VERIFIED',
        },
      },
    );

    expect(dto?.user, isA<UserResponseDto>());
    final user = UserModel.fromDto(dto!.user!);
    expect(user.name, 'Maria da Silva');
    expect(user.pfp, contains('cloudinary.com'));
    expect(user.isVerified, isTrue);
  });
}
