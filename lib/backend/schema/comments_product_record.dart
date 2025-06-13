import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsProductRecord extends FirestoreRecord {
  CommentsProductRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "productRef" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  bool hasProductRef() => _productRef != null;

  // "vendorRef" field.
  DocumentReference? _vendorRef;
  DocumentReference? get vendorRef => _vendorRef;
  bool hasVendorRef() => _vendorRef != null;

  void _initializeFields() {
    _comment = snapshotData['comment'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _productRef = snapshotData['productRef'] as DocumentReference?;
    _vendorRef = snapshotData['vendorRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('commentsProduct');

  static Stream<CommentsProductRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsProductRecord.fromSnapshot(s));

  static Future<CommentsProductRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsProductRecord.fromSnapshot(s));

  static CommentsProductRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsProductRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsProductRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommentsProductRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsProductRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsProductRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsProductRecordData({
  String? comment,
  DateTime? date,
  DocumentReference? productRef,
  DocumentReference? vendorRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment': comment,
      'date': date,
      'productRef': productRef,
      'vendorRef': vendorRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsProductRecordDocumentEquality
    implements Equality<CommentsProductRecord> {
  const CommentsProductRecordDocumentEquality();

  @override
  bool equals(CommentsProductRecord? e1, CommentsProductRecord? e2) {
    return e1?.comment == e2?.comment &&
        e1?.date == e2?.date &&
        e1?.productRef == e2?.productRef &&
        e1?.vendorRef == e2?.vendorRef;
  }

  @override
  int hash(CommentsProductRecord? e) => const ListEquality()
      .hash([e?.comment, e?.date, e?.productRef, e?.vendorRef]);

  @override
  bool isValidKey(Object? o) => o is CommentsProductRecord;
}
