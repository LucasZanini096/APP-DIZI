// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TextElementsStruct extends FFFirebaseStruct {
  TextElementsStruct({
    String? fontFamily,
    double? fontSize,
    int? color,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fontFamily = fontFamily,
        _fontSize = fontSize,
        _color = color,
        super(firestoreUtilData);

  // "fontFamily" field.
  String? _fontFamily;
  String get fontFamily => _fontFamily ?? '';
  set fontFamily(String? val) => _fontFamily = val;

  bool hasFontFamily() => _fontFamily != null;

  // "fontSize" field.
  double? _fontSize;
  double get fontSize => _fontSize ?? 0.0;
  set fontSize(double? val) => _fontSize = val;

  void incrementFontSize(double amount) => fontSize = fontSize + amount;

  bool hasFontSize() => _fontSize != null;

  // "color" field.
  int? _color;
  int get color => _color ?? 0;
  set color(int? val) => _color = val;

  void incrementColor(int amount) => color = color + amount;

  bool hasColor() => _color != null;

  static TextElementsStruct fromMap(Map<String, dynamic> data) =>
      TextElementsStruct(
        fontFamily: data['fontFamily'] as String?,
        fontSize: castToType<double>(data['fontSize']),
        color: castToType<int>(data['color']),
      );

  static TextElementsStruct? maybeFromMap(dynamic data) => data is Map
      ? TextElementsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'fontFamily': _fontFamily,
        'fontSize': _fontSize,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fontFamily': serializeParam(
          _fontFamily,
          ParamType.String,
        ),
        'fontSize': serializeParam(
          _fontSize,
          ParamType.double,
        ),
        'color': serializeParam(
          _color,
          ParamType.int,
        ),
      }.withoutNulls;

  static TextElementsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TextElementsStruct(
        fontFamily: deserializeParam(
          data['fontFamily'],
          ParamType.String,
          false,
        ),
        fontSize: deserializeParam(
          data['fontSize'],
          ParamType.double,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TextElementsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TextElementsStruct &&
        fontFamily == other.fontFamily &&
        fontSize == other.fontSize &&
        color == other.color;
  }

  @override
  int get hashCode => const ListEquality().hash([fontFamily, fontSize, color]);
}

TextElementsStruct createTextElementsStruct({
  String? fontFamily,
  double? fontSize,
  int? color,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TextElementsStruct(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TextElementsStruct? updateTextElementsStruct(
  TextElementsStruct? textElements, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    textElements
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTextElementsStructData(
  Map<String, dynamic> firestoreData,
  TextElementsStruct? textElements,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (textElements == null) {
    return;
  }
  if (textElements.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && textElements.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final textElementsData =
      getTextElementsFirestoreData(textElements, forFieldValue);
  final nestedData =
      textElementsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = textElements.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTextElementsFirestoreData(
  TextElementsStruct? textElements, [
  bool forFieldValue = false,
]) {
  if (textElements == null) {
    return {};
  }
  final firestoreData = mapToFirestore(textElements.toMap());

  // Add any Firestore field values
  textElements.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTextElementsListFirestoreData(
  List<TextElementsStruct>? textElementss,
) =>
    textElementss?.map((e) => getTextElementsFirestoreData(e, true)).toList() ??
    [];
