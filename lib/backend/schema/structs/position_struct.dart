// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PositionStruct extends FFFirebaseStruct {
  PositionStruct({
    double? dx,
    double? dy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dx = dx,
        _dy = dy,
        super(firestoreUtilData);

  // "dx" field.
  double? _dx;
  double get dx => _dx ?? 0.0;
  set dx(double? val) => _dx = val;

  void incrementDx(double amount) => dx = dx + amount;

  bool hasDx() => _dx != null;

  // "dy" field.
  double? _dy;
  double get dy => _dy ?? 0.0;
  set dy(double? val) => _dy = val;

  void incrementDy(double amount) => dy = dy + amount;

  bool hasDy() => _dy != null;

  static PositionStruct fromMap(Map<String, dynamic> data) => PositionStruct(
        dx: castToType<double>(data['dx']),
        dy: castToType<double>(data['dy']),
      );

  static PositionStruct? maybeFromMap(dynamic data) =>
      data is Map ? PositionStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'dx': _dx,
        'dy': _dy,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'dx': serializeParam(
          _dx,
          ParamType.double,
        ),
        'dy': serializeParam(
          _dy,
          ParamType.double,
        ),
      }.withoutNulls;

  static PositionStruct fromSerializableMap(Map<String, dynamic> data) =>
      PositionStruct(
        dx: deserializeParam(
          data['dx'],
          ParamType.double,
          false,
        ),
        dy: deserializeParam(
          data['dy'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'PositionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PositionStruct && dx == other.dx && dy == other.dy;
  }

  @override
  int get hashCode => const ListEquality().hash([dx, dy]);
}

PositionStruct createPositionStruct({
  double? dx,
  double? dy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PositionStruct(
      dx: dx,
      dy: dy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PositionStruct? updatePositionStruct(
  PositionStruct? position, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    position
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPositionStructData(
  Map<String, dynamic> firestoreData,
  PositionStruct? position,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (position == null) {
    return;
  }
  if (position.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && position.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final positionData = getPositionFirestoreData(position, forFieldValue);
  final nestedData = positionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = position.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPositionFirestoreData(
  PositionStruct? position, [
  bool forFieldValue = false,
]) {
  if (position == null) {
    return {};
  }
  final firestoreData = mapToFirestore(position.toMap());

  // Add any Firestore field values
  position.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPositionListFirestoreData(
  List<PositionStruct>? positions,
) =>
    positions?.map((e) => getPositionFirestoreData(e, true)).toList() ?? [];
