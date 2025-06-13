import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DrawingsRecord extends FirestoreRecord {
  DrawingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "lastModified" field.
  DateTime? _lastModified;
  DateTime? get lastModified => _lastModified;
  bool hasLastModified() => _lastModified != null;

  // "pageType" field.
  String? _pageType;
  String get pageType => _pageType ?? '';
  bool hasPageType() => _pageType != null;

  // "version" field.
  int? _version;
  int get version => _version ?? 0;
  bool hasVersion() => _version != null;

  // "isPublic" field.
  bool? _isPublic;
  bool get isPublic => _isPublic ?? false;
  bool hasIsPublic() => _isPublic != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTags() => _tags != null;

  // "drawingData" field.
  DrawingDataStruct? _drawingData;
  DrawingDataStruct get drawingData => _drawingData ?? DrawingDataStruct();
  bool hasDrawingData() => _drawingData != null;

  // "isDelete" field.
  bool? _isDelete;
  bool get isDelete => _isDelete ?? false;
  bool hasIsDelete() => _isDelete != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _title = snapshotData['title'] as String?;
    _userId = snapshotData['userId'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _lastModified = snapshotData['lastModified'] as DateTime?;
    _pageType = snapshotData['pageType'] as String?;
    _version = castToType<int>(snapshotData['version']);
    _isPublic = snapshotData['isPublic'] as bool?;
    _tags = getDataList(snapshotData['tags']);
    _drawingData = snapshotData['drawingData'] is DrawingDataStruct
        ? snapshotData['drawingData']
        : DrawingDataStruct.maybeFromMap(snapshotData['drawingData']);
    _isDelete = snapshotData['isDelete'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('drawings');

  static Stream<DrawingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DrawingsRecord.fromSnapshot(s));

  static Future<DrawingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DrawingsRecord.fromSnapshot(s));

  static DrawingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DrawingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DrawingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DrawingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DrawingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DrawingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDrawingsRecordData({
  String? id,
  String? title,
  String? userId,
  DateTime? createdAt,
  DateTime? lastModified,
  String? pageType,
  int? version,
  bool? isPublic,
  DrawingDataStruct? drawingData,
  bool? isDelete,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'title': title,
      'userId': userId,
      'createdAt': createdAt,
      'lastModified': lastModified,
      'pageType': pageType,
      'version': version,
      'isPublic': isPublic,
      'drawingData': DrawingDataStruct().toMap(),
      'isDelete': isDelete,
    }.withoutNulls,
  );

  // Handle nested data for "drawingData" field.
  addDrawingDataStructData(firestoreData, drawingData, 'drawingData');

  return firestoreData;
}

class DrawingsRecordDocumentEquality implements Equality<DrawingsRecord> {
  const DrawingsRecordDocumentEquality();

  @override
  bool equals(DrawingsRecord? e1, DrawingsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.id == e2?.id &&
        e1?.title == e2?.title &&
        e1?.userId == e2?.userId &&
        e1?.createdAt == e2?.createdAt &&
        e1?.lastModified == e2?.lastModified &&
        e1?.pageType == e2?.pageType &&
        e1?.version == e2?.version &&
        e1?.isPublic == e2?.isPublic &&
        listEquality.equals(e1?.tags, e2?.tags) &&
        e1?.drawingData == e2?.drawingData &&
        e1?.isDelete == e2?.isDelete;
  }

  @override
  int hash(DrawingsRecord? e) => const ListEquality().hash([
        e?.id,
        e?.title,
        e?.userId,
        e?.createdAt,
        e?.lastModified,
        e?.pageType,
        e?.version,
        e?.isPublic,
        e?.tags,
        e?.drawingData,
        e?.isDelete
      ]);

  @override
  bool isValidKey(Object? o) => o is DrawingsRecord;
}
