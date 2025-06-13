// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OffsetStruct extends FFFirebaseStruct {
  OffsetStruct({
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

  static OffsetStruct fromMap(Map<String, dynamic> data) => OffsetStruct(
        dx: castToType<double>(data['dx']),
        dy: castToType<double>(data['dy']),
      );

  static OffsetStruct? maybeFromMap(dynamic data) =>
      data is Map ? OffsetStruct.fromMap(data.cast<String, dynamic>()) : null;

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

  static OffsetStruct fromSerializableMap(Map<String, dynamic> data) =>
      OffsetStruct(
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
  String toString() => 'OffsetStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OffsetStruct && dx == other.dx && dy == other.dy;
  }

  @override
  int get hashCode => const ListEquality().hash([dx, dy]);
}

OffsetStruct createOffsetStruct({
  double? dx,
  double? dy,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OffsetStruct(
      dx: dx,
      dy: dy,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OffsetStruct? updateOffsetStruct(
  OffsetStruct? offset, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    offset
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOffsetStructData(
  Map<String, dynamic> firestoreData,
  OffsetStruct? offset,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (offset == null) {
    return;
  }
  if (offset.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && offset.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final offsetData = getOffsetFirestoreData(offset, forFieldValue);
  final nestedData = offsetData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = offset.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOffsetFirestoreData(
  OffsetStruct? offset, [
  bool forFieldValue = false,
]) {
  if (offset == null) {
    return {};
  }
  final firestoreData = mapToFirestore(offset.toMap());

  // Add any Firestore field values
  offset.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOffsetListFirestoreData(
  List<OffsetStruct>? offsets,
) =>
    offsets?.map((e) => getOffsetFirestoreData(e, true)).toList() ?? [];
