//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_ad_dto.g.dart';

/// CreateAdDto
///
/// Properties:
/// * [title] 
/// * [content] 
/// * [type] - Valores aceitos: PRODUCT, SERVICE ou COLLAB
/// * [cover] - Link da imagem da capa no Cloudinary
@BuiltValue()
abstract class CreateAdDto implements Built<CreateAdDto, CreateAdDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'content')
  String get content;

  /// Valores aceitos: PRODUCT, SERVICE ou COLLAB
  @BuiltValueField(wireName: r'type')
  String get type;

  /// Link da imagem da capa no Cloudinary
  @BuiltValueField(wireName: r'cover')
  String? get cover;

  CreateAdDto._();

  factory CreateAdDto([void updates(CreateAdDtoBuilder b)]) = _$CreateAdDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAdDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAdDto> get serializer => _$CreateAdDtoSerializer();
}

class _$CreateAdDtoSerializer implements PrimitiveSerializer<CreateAdDto> {
  @override
  final Iterable<Type> types = const [CreateAdDto, _$CreateAdDto];

  @override
  final String wireName = r'CreateAdDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAdDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    if (object.cover != null) {
      yield r'cover';
      yield serializers.serialize(
        object.cover,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAdDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAdDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'cover':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cover = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAdDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAdDtoBuilder();
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

