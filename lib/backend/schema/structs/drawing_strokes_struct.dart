// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrawingStrokesStruct extends FFFirebaseStruct {
  DrawingStrokesStruct({
    int? color,
    double? strokeWidth,
    int? tool,
    OffsetStruct? offset,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _color = color,
        _strokeWidth = strokeWidth,
        _tool = tool,
        _offset = offset,
        super(firestoreUtilData);

  // "color" field.
  int? _color;
  int get color => _color ?? 0;
  set color(int? val) => _color = val;

  void incrementColor(int amount) => color = color + amount;

  bool hasColor() => _color != null;

  // "strokeWidth" field.
  double? _strokeWidth;
  double get strokeWidth => _strokeWidth ?? 0.0;
  set strokeWidth(double? val) => _strokeWidth = val;

  void incrementStrokeWidth(double amount) =>
      strokeWidth = strokeWidth + amount;

  bool hasStrokeWidth() => _strokeWidth != null;

  // "tool" field.
  int? _tool;
  int get tool => _tool ?? 0;
  set tool(int? val) => _tool = val;

  void incrementTool(int amount) => tool = tool + amount;

  bool hasTool() => _tool != null;

  // "offset" field.
  OffsetStruct? _offset;
  OffsetStruct get offset => _offset ?? OffsetStruct();
  set offset(OffsetStruct? val) => _offset = val;

  void updateOffset(Function(OffsetStruct) updateFn) {
    updateFn(_offset ??= OffsetStruct());
  }

  bool hasOffset() => _offset != null;

  static DrawingStrokesStruct fromMap(Map<String, dynamic> data) =>
      DrawingStrokesStruct(
        color: castToType<int>(data['color']),
        strokeWidth: castToType<double>(data['strokeWidth']),
        tool: castToType<int>(data['tool']),
        offset: data['offset'] is OffsetStruct
            ? data['offset']
            : OffsetStruct.maybeFromMap(data['offset']),
      );

  static DrawingStrokesStruct? maybeFromMap(dynamic data) => data is Map
      ? DrawingStrokesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'color': _color,
        'strokeWidth': _strokeWidth,
        'tool': _tool,
        'offset': _offset?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'color': serializeParam(
          _color,
          ParamType.int,
        ),
        'strokeWidth': serializeParam(
          _strokeWidth,
          ParamType.double,
        ),
        'tool': serializeParam(
          _tool,
          ParamType.int,
        ),
        'offset': serializeParam(
          _offset,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static DrawingStrokesStruct fromSerializableMap(Map<String, dynamic> data) =>
      DrawingStrokesStruct(
        color: deserializeParam(
          data['color'],
          ParamType.int,
          false,
        ),
        strokeWidth: deserializeParam(
          data['strokeWidth'],
          ParamType.double,
          false,
        ),
        tool: deserializeParam(
          data['tool'],
          ParamType.int,
          false,
        ),
        offset: deserializeStructParam(
          data['offset'],
          ParamType.DataStruct,
          false,
          structBuilder: OffsetStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DrawingStrokesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DrawingStrokesStruct &&
        color == other.color &&
        strokeWidth == other.strokeWidth &&
        tool == other.tool &&
        offset == other.offset;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([color, strokeWidth, tool, offset]);
}

DrawingStrokesStruct createDrawingStrokesStruct({
  int? color,
  double? strokeWidth,
  int? tool,
  OffsetStruct? offset,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DrawingStrokesStruct(
      color: color,
      strokeWidth: strokeWidth,
      tool: tool,
      offset: offset ?? (clearUnsetFields ? OffsetStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DrawingStrokesStruct? updateDrawingStrokesStruct(
  DrawingStrokesStruct? drawingStrokes, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    drawingStrokes
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDrawingStrokesStructData(
  Map<String, dynamic> firestoreData,
  DrawingStrokesStruct? drawingStrokes,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (drawingStrokes == null) {
    return;
  }
  if (drawingStrokes.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && drawingStrokes.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final drawingStrokesData =
      getDrawingStrokesFirestoreData(drawingStrokes, forFieldValue);
  final nestedData =
      drawingStrokesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = drawingStrokes.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDrawingStrokesFirestoreData(
  DrawingStrokesStruct? drawingStrokes, [
  bool forFieldValue = false,
]) {
  if (drawingStrokes == null) {
    return {};
  }
  final firestoreData = mapToFirestore(drawingStrokes.toMap());

  // Handle nested data for "offset" field.
  addOffsetStructData(
    firestoreData,
    drawingStrokes.hasOffset() ? drawingStrokes.offset : null,
    'offset',
    forFieldValue,
  );

  // Add any Firestore field values
  drawingStrokes.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDrawingStrokesListFirestoreData(
  List<DrawingStrokesStruct>? drawingStrokess,
) =>
    drawingStrokess
        ?.map((e) => getDrawingStrokesFirestoreData(e, true))
        .toList() ??
    [];
