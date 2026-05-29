//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_post_dto.g.dart';

/// CreatePostDto
///
/// Properties:
/// * [title] 
/// * [content] 
/// * [type] - Valores aceitos: EVENT ou COURSE
/// * [cover] - Link da imagem da capa no Cloudinary
@BuiltValue()
abstract class CreatePostDto implements Built<CreatePostDto, CreatePostDtoBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'content')
  String get content;

  /// Valores aceitos: EVENT ou COURSE
  @BuiltValueField(wireName: r'type')
  String get type;

  /// Link da imagem da capa no Cloudinary
  @BuiltValueField(wireName: r'cover')
  String? get cover;

  CreatePostDto._();

  factory CreatePostDto([void updates(CreatePostDtoBuilder b)]) = _$CreatePostDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePostDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePostDto> get serializer => _$CreatePostDtoSerializer();
}

class _$CreatePostDtoSerializer implements PrimitiveSerializer<CreatePostDto> {
  @override
  final Iterable<Type> types = const [CreatePostDto, _$CreatePostDto];

  @override
  final String wireName = r'CreatePostDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePostDto object, {
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
    CreatePostDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePostDtoBuilder result,
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
  CreatePostDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePostDtoBuilder();
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

