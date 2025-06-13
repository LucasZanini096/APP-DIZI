import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "is_a_like_post" field.
  bool? _isALikePost;
  bool get isALikePost => _isALikePost ?? false;
  bool hasIsALikePost() => _isALikePost != null;

  // "Is_a_comment_post" field.
  bool? _isACommentPost;
  bool get isACommentPost => _isACommentPost ?? false;
  bool hasIsACommentPost() => _isACommentPost != null;

  // "Is_new_follower" field.
  bool? _isNewFollower;
  bool get isNewFollower => _isNewFollower ?? false;
  bool hasIsNewFollower() => _isNewFollower != null;

  // "post_ref" field.
  DocumentReference? _postRef;
  DocumentReference? get postRef => _postRef;
  bool hasPostRef() => _postRef != null;

  // "made_by" field.
  DocumentReference? _madeBy;
  DocumentReference? get madeBy => _madeBy;
  bool hasMadeBy() => _madeBy != null;

  // "made_to" field.
  DocumentReference? _madeTo;
  DocumentReference? get madeTo => _madeTo;
  bool hasMadeTo() => _madeTo != null;

  // "user_new_follower" field.
  DocumentReference? _userNewFollower;
  DocumentReference? get userNewFollower => _userNewFollower;
  bool hasUserNewFollower() => _userNewFollower != null;

  // "is_read" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  bool hasIsRead() => _isRead != null;

  // "Is_a_message" field.
  bool? _isAMessage;
  bool get isAMessage => _isAMessage ?? false;
  bool hasIsAMessage() => _isAMessage != null;

  void _initializeFields() {
    _isALikePost = snapshotData['is_a_like_post'] as bool?;
    _isACommentPost = snapshotData['Is_a_comment_post'] as bool?;
    _isNewFollower = snapshotData['Is_new_follower'] as bool?;
    _postRef = snapshotData['post_ref'] as DocumentReference?;
    _madeBy = snapshotData['made_by'] as DocumentReference?;
    _madeTo = snapshotData['made_to'] as DocumentReference?;
    _userNewFollower = snapshotData['user_new_follower'] as DocumentReference?;
    _isRead = snapshotData['is_read'] as bool?;
    _isAMessage = snapshotData['Is_a_message'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  bool? isALikePost,
  bool? isACommentPost,
  bool? isNewFollower,
  DocumentReference? postRef,
  DocumentReference? madeBy,
  DocumentReference? madeTo,
  DocumentReference? userNewFollower,
  bool? isRead,
  bool? isAMessage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'is_a_like_post': isALikePost,
      'Is_a_comment_post': isACommentPost,
      'Is_new_follower': isNewFollower,
      'post_ref': postRef,
      'made_by': madeBy,
      'made_to': madeTo,
      'user_new_follower': userNewFollower,
      'is_read': isRead,
      'Is_a_message': isAMessage,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    return e1?.isALikePost == e2?.isALikePost &&
        e1?.isACommentPost == e2?.isACommentPost &&
        e1?.isNewFollower == e2?.isNewFollower &&
        e1?.postRef == e2?.postRef &&
        e1?.madeBy == e2?.madeBy &&
        e1?.madeTo == e2?.madeTo &&
        e1?.userNewFollower == e2?.userNewFollower &&
        e1?.isRead == e2?.isRead &&
        e1?.isAMessage == e2?.isAMessage;
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.isALikePost,
        e?.isACommentPost,
        e?.isNewFollower,
        e?.postRef,
        e?.madeBy,
        e?.madeTo,
        e?.userNewFollower,
        e?.isRead,
        e?.isAMessage
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
