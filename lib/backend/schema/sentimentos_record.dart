import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SentimentosRecord extends FirestoreRecord {
  SentimentosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sentimento" field.
  String? _sentimento;
  String get sentimento => _sentimento ?? '';
  bool hasSentimento() => _sentimento != null;

  // "dataCriacao" field.
  DateTime? _dataCriacao;
  DateTime? get dataCriacao => _dataCriacao;
  bool hasDataCriacao() => _dataCriacao != null;

  // "usuarioRef" field.
  DocumentReference? _usuarioRef;
  DocumentReference? get usuarioRef => _usuarioRef;
  bool hasUsuarioRef() => _usuarioRef != null;

  void _initializeFields() {
    _sentimento = snapshotData['sentimento'] as String?;
    _dataCriacao = snapshotData['dataCriacao'] as DateTime?;
    _usuarioRef = snapshotData['usuarioRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sentimentos');

  static Stream<SentimentosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SentimentosRecord.fromSnapshot(s));

  static Future<SentimentosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SentimentosRecord.fromSnapshot(s));

  static SentimentosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SentimentosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SentimentosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SentimentosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SentimentosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SentimentosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSentimentosRecordData({
  String? sentimento,
  DateTime? dataCriacao,
  DocumentReference? usuarioRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sentimento': sentimento,
      'dataCriacao': dataCriacao,
      'usuarioRef': usuarioRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class SentimentosRecordDocumentEquality implements Equality<SentimentosRecord> {
  const SentimentosRecordDocumentEquality();

  @override
  bool equals(SentimentosRecord? e1, SentimentosRecord? e2) {
    return e1?.sentimento == e2?.sentimento &&
        e1?.dataCriacao == e2?.dataCriacao &&
        e1?.usuarioRef == e2?.usuarioRef;
  }

  @override
  int hash(SentimentosRecord? e) =>
      const ListEquality().hash([e?.sentimento, e?.dataCriacao, e?.usuarioRef]);

  @override
  bool isValidKey(Object? o) => o is SentimentosRecord;
}
