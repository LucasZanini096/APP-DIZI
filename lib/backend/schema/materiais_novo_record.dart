import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MateriaisNovoRecord extends FirestoreRecord {
  MateriaisNovoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "caderno" field.
  DocumentReference? _caderno;
  DocumentReference? get caderno => _caderno;
  bool hasCaderno() => _caderno != null;

  // "descricao" field.
  String? _descricao;
  String get descricao => _descricao ?? '';
  bool hasDescricao() => _descricao != null;

  // "tipo_pagina" field.
  String? _tipoPagina;
  String get tipoPagina => _tipoPagina ?? '';
  bool hasTipoPagina() => _tipoPagina != null;

  // "tipo_modelo" field.
  String? _tipoModelo;
  String get tipoModelo => _tipoModelo ?? '';
  bool hasTipoModelo() => _tipoModelo != null;

  // "criador" field.
  DocumentReference? _criador;
  DocumentReference? get criador => _criador;
  bool hasCriador() => _criador != null;

  // "url_doc" field.
  String? _urlDoc;
  String get urlDoc => _urlDoc ?? '';
  bool hasUrlDoc() => _urlDoc != null;

  // "id_material" field.
  String? _idMaterial;
  String get idMaterial => _idMaterial ?? '';
  bool hasIdMaterial() => _idMaterial != null;

  // "capa_material" field.
  String? _capaMaterial;
  String get capaMaterial => _capaMaterial ?? '';
  bool hasCapaMaterial() => _capaMaterial != null;

  // "data_criacao" field.
  DateTime? _dataCriacao;
  DateTime? get dataCriacao => _dataCriacao;
  bool hasDataCriacao() => _dataCriacao != null;

  void _initializeFields() {
    _nome = snapshotData['nome'] as String?;
    _caderno = snapshotData['caderno'] as DocumentReference?;
    _descricao = snapshotData['descricao'] as String?;
    _tipoPagina = snapshotData['tipo_pagina'] as String?;
    _tipoModelo = snapshotData['tipo_modelo'] as String?;
    _criador = snapshotData['criador'] as DocumentReference?;
    _urlDoc = snapshotData['url_doc'] as String?;
    _idMaterial = snapshotData['id_material'] as String?;
    _capaMaterial = snapshotData['capa_material'] as String?;
    _dataCriacao = snapshotData['data_criacao'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('materiaisNovo');

  static Stream<MateriaisNovoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MateriaisNovoRecord.fromSnapshot(s));

  static Future<MateriaisNovoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MateriaisNovoRecord.fromSnapshot(s));

  static MateriaisNovoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MateriaisNovoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MateriaisNovoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MateriaisNovoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MateriaisNovoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MateriaisNovoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMateriaisNovoRecordData({
  String? nome,
  DocumentReference? caderno,
  String? descricao,
  String? tipoPagina,
  String? tipoModelo,
  DocumentReference? criador,
  String? urlDoc,
  String? idMaterial,
  String? capaMaterial,
  DateTime? dataCriacao,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nome': nome,
      'caderno': caderno,
      'descricao': descricao,
      'tipo_pagina': tipoPagina,
      'tipo_modelo': tipoModelo,
      'criador': criador,
      'url_doc': urlDoc,
      'id_material': idMaterial,
      'capa_material': capaMaterial,
      'data_criacao': dataCriacao,
    }.withoutNulls,
  );

  return firestoreData;
}

class MateriaisNovoRecordDocumentEquality
    implements Equality<MateriaisNovoRecord> {
  const MateriaisNovoRecordDocumentEquality();

  @override
  bool equals(MateriaisNovoRecord? e1, MateriaisNovoRecord? e2) {
    return e1?.nome == e2?.nome &&
        e1?.caderno == e2?.caderno &&
        e1?.descricao == e2?.descricao &&
        e1?.tipoPagina == e2?.tipoPagina &&
        e1?.tipoModelo == e2?.tipoModelo &&
        e1?.criador == e2?.criador &&
        e1?.urlDoc == e2?.urlDoc &&
        e1?.idMaterial == e2?.idMaterial &&
        e1?.capaMaterial == e2?.capaMaterial &&
        e1?.dataCriacao == e2?.dataCriacao;
  }

  @override
  int hash(MateriaisNovoRecord? e) => const ListEquality().hash([
        e?.nome,
        e?.caderno,
        e?.descricao,
        e?.tipoPagina,
        e?.tipoModelo,
        e?.criador,
        e?.urlDoc,
        e?.idMaterial,
        e?.capaMaterial,
        e?.dataCriacao
      ]);

  @override
  bool isValidKey(Object? o) => o is MateriaisNovoRecord;
}
