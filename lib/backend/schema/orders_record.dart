import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "comprador" field.
  DocumentReference? _comprador;
  DocumentReference? get comprador => _comprador;
  bool hasComprador() => _comprador != null;

  // "vendedor" field.
  DocumentReference? _vendedor;
  DocumentReference? get vendedor => _vendedor;
  bool hasVendedor() => _vendedor != null;

  // "valor" field.
  double? _valor;
  double get valor => _valor ?? 0.0;
  bool hasValor() => _valor != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "produto" field.
  DocumentReference? _produto;
  DocumentReference? get produto => _produto;
  bool hasProduto() => _produto != null;

  // "data_ocorrencia" field.
  DateTime? _dataOcorrencia;
  DateTime? get dataOcorrencia => _dataOcorrencia;
  bool hasDataOcorrencia() => _dataOcorrencia != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _comprador = snapshotData['comprador'] as DocumentReference?;
    _vendedor = snapshotData['vendedor'] as DocumentReference?;
    _valor = castToType<double>(snapshotData['valor']);
    _status = snapshotData['status'] as String?;
    _produto = snapshotData['produto'] as DocumentReference?;
    _dataOcorrencia = snapshotData['data_ocorrencia'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  String? id,
  DocumentReference? comprador,
  DocumentReference? vendedor,
  double? valor,
  String? status,
  DocumentReference? produto,
  DateTime? dataOcorrencia,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'comprador': comprador,
      'vendedor': vendedor,
      'valor': valor,
      'status': status,
      'produto': produto,
      'data_ocorrencia': dataOcorrencia,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.comprador == e2?.comprador &&
        e1?.vendedor == e2?.vendedor &&
        e1?.valor == e2?.valor &&
        e1?.status == e2?.status &&
        e1?.produto == e2?.produto &&
        e1?.dataOcorrencia == e2?.dataOcorrencia;
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.id,
        e?.comprador,
        e?.vendedor,
        e?.valor,
        e?.status,
        e?.produto,
        e?.dataOcorrencia
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
