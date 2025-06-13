import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AgendaRecord extends FirestoreRecord {
  AgendaRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "anotacao" field.
  String? _anotacao;
  String get anotacao => _anotacao ?? '';
  bool hasAnotacao() => _anotacao != null;

  // "Data_Fim" field.
  DateTime? _dataFim;
  DateTime? get dataFim => _dataFim;
  bool hasDataFim() => _dataFim != null;

  // "Data_Criacao" field.
  DateTime? _dataCriacao;
  DateTime? get dataCriacao => _dataCriacao;
  bool hasDataCriacao() => _dataCriacao != null;

  // "situacao" field.
  String? _situacao;
  String get situacao => _situacao ?? '';
  bool hasSituacao() => _situacao != null;

  void _initializeFields() {
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _anotacao = snapshotData['anotacao'] as String?;
    _dataFim = snapshotData['Data_Fim'] as DateTime?;
    _dataCriacao = snapshotData['Data_Criacao'] as DateTime?;
    _situacao = snapshotData['situacao'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('agenda');

  static Stream<AgendaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AgendaRecord.fromSnapshot(s));

  static Future<AgendaRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AgendaRecord.fromSnapshot(s));

  static AgendaRecord fromSnapshot(DocumentSnapshot snapshot) => AgendaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AgendaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AgendaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AgendaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AgendaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAgendaRecordData({
  DocumentReference? usuario,
  String? anotacao,
  DateTime? dataFim,
  DateTime? dataCriacao,
  String? situacao,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'usuario': usuario,
      'anotacao': anotacao,
      'Data_Fim': dataFim,
      'Data_Criacao': dataCriacao,
      'situacao': situacao,
    }.withoutNulls,
  );

  return firestoreData;
}

class AgendaRecordDocumentEquality implements Equality<AgendaRecord> {
  const AgendaRecordDocumentEquality();

  @override
  bool equals(AgendaRecord? e1, AgendaRecord? e2) {
    return e1?.usuario == e2?.usuario &&
        e1?.anotacao == e2?.anotacao &&
        e1?.dataFim == e2?.dataFim &&
        e1?.dataCriacao == e2?.dataCriacao &&
        e1?.situacao == e2?.situacao;
  }

  @override
  int hash(AgendaRecord? e) => const ListEquality()
      .hash([e?.usuario, e?.anotacao, e?.dataFim, e?.dataCriacao, e?.situacao]);

  @override
  bool isValidKey(Object? o) => o is AgendaRecord;
}
