import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotebookCoversRecord extends FirestoreRecord {
  NotebookCoversRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  void _initializeFields() {
    _url = snapshotData['url'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notebookCovers');

  static Stream<NotebookCoversRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotebookCoversRecord.fromSnapshot(s));

  static Future<NotebookCoversRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotebookCoversRecord.fromSnapshot(s));

  static NotebookCoversRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotebookCoversRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotebookCoversRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotebookCoversRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotebookCoversRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotebookCoversRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotebookCoversRecordData({
  String? url,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'url': url,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotebookCoversRecordDocumentEquality
    implements Equality<NotebookCoversRecord> {
  const NotebookCoversRecordDocumentEquality();

  @override
  bool equals(NotebookCoversRecord? e1, NotebookCoversRecord? e2) {
    return e1?.url == e2?.url;
  }

  @override
  int hash(NotebookCoversRecord? e) => const ListEquality().hash([e?.url]);

  @override
  bool isValidKey(Object? o) => o is NotebookCoversRecord;
}
