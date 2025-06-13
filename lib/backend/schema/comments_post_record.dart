import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsPostRecord extends FirestoreRecord {
  CommentsPostRecord._(
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

  // "postUser" field.
  DocumentReference? _postUser;
  DocumentReference? get postUser => _postUser;
  bool hasPostUser() => _postUser != null;

  // "postRef" field.
  DocumentReference? _postRef;
  DocumentReference? get postRef => _postRef;
  bool hasPostRef() => _postRef != null;

  void _initializeFields() {
    _comment = snapshotData['comment'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _postUser = snapshotData['postUser'] as DocumentReference?;
    _postRef = snapshotData['postRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('commentsPost');

  static Stream<CommentsPostRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsPostRecord.fromSnapshot(s));

  static Future<CommentsPostRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsPostRecord.fromSnapshot(s));

  static CommentsPostRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsPostRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsPostRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommentsPostRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsPostRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsPostRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsPostRecordData({
  String? comment,
  DateTime? date,
  DocumentReference? postUser,
  DocumentReference? postRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment': comment,
      'date': date,
      'postUser': postUser,
      'postRef': postRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsPostRecordDocumentEquality
    implements Equality<CommentsPostRecord> {
  const CommentsPostRecordDocumentEquality();

  @override
  bool equals(CommentsPostRecord? e1, CommentsPostRecord? e2) {
    return e1?.comment == e2?.comment &&
        e1?.date == e2?.date &&
        e1?.postUser == e2?.postUser &&
        e1?.postRef == e2?.postRef;
  }

  @override
  int hash(CommentsPostRecord? e) =>
      const ListEquality().hash([e?.comment, e?.date, e?.postUser, e?.postRef]);

  @override
  bool isValidKey(Object? o) => o is CommentsPostRecord;
}
