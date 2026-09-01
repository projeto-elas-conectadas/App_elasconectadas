//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_response_dto.g.dart';

/// UploadResponseDto
///
/// Properties:
/// * [imageUrl] - URL segura da imagem armazenada no Cloudinary
@BuiltValue()
abstract class UploadResponseDto implements Built<UploadResponseDto, UploadResponseDtoBuilder> {
  /// URL segura da imagem armazenada no Cloudinary
  @BuiltValueField(wireName: r'imageUrl')
  String get imageUrl;

  UploadResponseDto._();

  factory UploadResponseDto([void updates(UploadResponseDtoBuilder b)]) = _$UploadResponseDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadResponseDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadResponseDto> get serializer => _$UploadResponseDtoSerializer();
}

class _$UploadResponseDtoSerializer implements PrimitiveSerializer<UploadResponseDto> {
  @override
  final Iterable<Type> types = const [UploadResponseDto, _$UploadResponseDto];

  @override
  final String wireName = r'UploadResponseDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'imageUrl';
    yield serializers.serialize(
      object.imageUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UploadResponseDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadResponseDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadResponseDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

