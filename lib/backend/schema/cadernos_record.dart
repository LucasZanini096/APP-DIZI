import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CadernosRecord extends FirestoreRecord {
  CadernosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "capa" field.
  String? _capa;
  String get capa => _capa ?? '';
  bool hasCapa() => _capa != null;

  // "id_caderno" field.
  String? _idCaderno;
  String get idCaderno => _idCaderno ?? '';
  bool hasIdCaderno() => _idCaderno != null;

  void _initializeFields() {
    _nome = snapshotData['nome'] as String?;
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _capa = snapshotData['capa'] as String?;
    _idCaderno = snapshotData['id_caderno'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cadernos');

  static Stream<CadernosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CadernosRecord.fromSnapshot(s));

  static Future<CadernosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CadernosRecord.fromSnapshot(s));

  static CadernosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CadernosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CadernosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CadernosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CadernosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CadernosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCadernosRecordData({
  String? nome,
  DocumentReference? usuario,
  String? capa,
  String? idCaderno,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nome': nome,
      'usuario': usuario,
      'capa': capa,
      'id_caderno': idCaderno,
    }.withoutNulls,
  );

  return firestoreData;
}

class CadernosRecordDocumentEquality implements Equality<CadernosRecord> {
  const CadernosRecordDocumentEquality();

  @override
  bool equals(CadernosRecord? e1, CadernosRecord? e2) {
    return e1?.nome == e2?.nome &&
        e1?.usuario == e2?.usuario &&
        e1?.capa == e2?.capa &&
        e1?.idCaderno == e2?.idCaderno;
  }

  @override
  int hash(CadernosRecord? e) =>
      const ListEquality().hash([e?.nome, e?.usuario, e?.capa, e?.idCaderno]);

  @override
  bool isValidKey(Object? o) => o is CadernosRecord;
}
