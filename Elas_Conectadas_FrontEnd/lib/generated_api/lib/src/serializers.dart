//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/create_ad_dto.dart';
import 'package:openapi/src/model/create_admin_dto.dart';
import 'package:openapi/src/model/create_post_dto.dart';
import 'package:openapi/src/model/create_produto_dto.dart';
import 'package:openapi/src/model/create_user_dto.dart';
import 'package:openapi/src/model/login_dto.dart';
import 'package:openapi/src/model/login_response_dto.dart';
import 'package:openapi/src/model/produto_response_dto.dart';
import 'package:openapi/src/model/request_token_dto.dart';
import 'package:openapi/src/model/send_email_dto.dart';
import 'package:openapi/src/model/update_ad_dto.dart';
import 'package:openapi/src/model/update_post_dto.dart';
import 'package:openapi/src/model/update_user_dto.dart';
import 'package:openapi/src/model/upload_response_dto.dart';
import 'package:openapi/src/model/user_response_dto.dart';
import 'package:openapi/src/model/verify_otp_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  CreateAdDto,
  CreateAdminDto,
  CreatePostDto,
  CreateProdutoDto,
  CreateUserDto,
  LoginDto,
  LoginResponseDto,
  ProdutoResponseDto,
  RequestTokenDto,
  SendEmailDto,
  UpdateAdDto,
  UpdatePostDto,
  UpdateUserDto,
  UploadResponseDto,
  UserResponseDto,
  VerifyOtpDto,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ProdutoResponseDto)]),
        () => ListBuilder<ProdutoResponseDto>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
