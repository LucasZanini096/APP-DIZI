// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrawingDataStruct extends FFFirebaseStruct {
  DrawingDataStruct({
    /// Array de strokes
    List<DrawingStrokesStruct>? drawingStrokes,

    /// Array de textos
    List<TextElementsStruct>? textElements,
    String? pageType,
    int? timestamp,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _drawingStrokes = drawingStrokes,
        _textElements = textElements,
        _pageType = pageType,
        _timestamp = timestamp,
        super(firestoreUtilData);

  // "drawingStrokes" field.
  List<DrawingStrokesStruct>? _drawingStrokes;
  List<DrawingStrokesStruct> get drawingStrokes => _drawingStrokes ?? const [];
  set drawingStrokes(List<DrawingStrokesStruct>? val) => _drawingStrokes = val;

  void updateDrawingStrokes(Function(List<DrawingStrokesStruct>) updateFn) {
    updateFn(_drawingStrokes ??= []);
  }

  bool hasDrawingStrokes() => _drawingStrokes != null;

  // "textElements" field.
  List<TextElementsStruct>? _textElements;
  List<TextElementsStruct> get textElements => _textElements ?? const [];
  set textElements(List<TextElementsStruct>? val) => _textElements = val;

  void updateTextElements(Function(List<TextElementsStruct>) updateFn) {
    updateFn(_textElements ??= []);
  }

  bool hasTextElements() => _textElements != null;

  // "pageType" field.
  String? _pageType;
  String get pageType => _pageType ?? '';
  set pageType(String? val) => _pageType = val;

  bool hasPageType() => _pageType != null;

  // "timestamp" field.
  int? _timestamp;
  int get timestamp => _timestamp ?? 0;
  set timestamp(int? val) => _timestamp = val;

  void incrementTimestamp(int amount) => timestamp = timestamp + amount;

  bool hasTimestamp() => _timestamp != null;

  static DrawingDataStruct fromMap(Map<String, dynamic> data) =>
      DrawingDataStruct(
        drawingStrokes: getStructList(
          data['drawingStrokes'],
          DrawingStrokesStruct.fromMap,
        ),
        textElements: getStructList(
          data['textElements'],
          TextElementsStruct.fromMap,
        ),
        pageType: data['pageType'] as String?,
        timestamp: castToType<int>(data['timestamp']),
      );

  static DrawingDataStruct? maybeFromMap(dynamic data) => data is Map
      ? DrawingDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'drawingStrokes': _drawingStrokes?.map((e) => e.toMap()).toList(),
        'textElements': _textElements?.map((e) => e.toMap()).toList(),
        'pageType': _pageType,
        'timestamp': _timestamp,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'drawingStrokes': serializeParam(
          _drawingStrokes,
          ParamType.DataStruct,
          isList: true,
        ),
        'textElements': serializeParam(
          _textElements,
          ParamType.DataStruct,
          isList: true,
        ),
        'pageType': serializeParam(
          _pageType,
          ParamType.String,
        ),
        'timestamp': serializeParam(
          _timestamp,
          ParamType.int,
        ),
      }.withoutNulls;

  static DrawingDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DrawingDataStruct(
        drawingStrokes: deserializeStructParam<DrawingStrokesStruct>(
          data['drawingStrokes'],
          ParamType.DataStruct,
          true,
          structBuilder: DrawingStrokesStruct.fromSerializableMap,
        ),
        textElements: deserializeStructParam<TextElementsStruct>(
          data['textElements'],
          ParamType.DataStruct,
          true,
          structBuilder: TextElementsStruct.fromSerializableMap,
        ),
        pageType: deserializeParam(
          data['pageType'],
          ParamType.String,
          false,
        ),
        timestamp: deserializeParam(
          data['timestamp'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'DrawingDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DrawingDataStruct &&
        listEquality.equals(drawingStrokes, other.drawingStrokes) &&
        listEquality.equals(textElements, other.textElements) &&
        pageType == other.pageType &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([drawingStrokes, textElements, pageType, timestamp]);
}

DrawingDataStruct createDrawingDataStruct({
  String? pageType,
  int? timestamp,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DrawingDataStruct(
      pageType: pageType,
      timestamp: timestamp,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DrawingDataStruct? updateDrawingDataStruct(
  DrawingDataStruct? drawingData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    drawingData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDrawingDataStructData(
  Map<String, dynamic> firestoreData,
  DrawingDataStruct? drawingData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (drawingData == null) {
    return;
  }
  if (drawingData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && drawingData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final drawingDataData =
      getDrawingDataFirestoreData(drawingData, forFieldValue);
  final nestedData =
      drawingDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = drawingData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDrawingDataFirestoreData(
  DrawingDataStruct? drawingData, [
  bool forFieldValue = false,
]) {
  if (drawingData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(drawingData.toMap());

  // Add any Firestore field values
  drawingData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDrawingDataListFirestoreData(
  List<DrawingDataStruct>? drawingDatas,
) =>
    drawingDatas?.map((e) => getDrawingDataFirestoreData(e, true)).toList() ??
    [];
