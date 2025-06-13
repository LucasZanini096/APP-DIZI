import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductsRecord extends FirestoreRecord {
  ProductsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "vendedor" field.
  DocumentReference? _vendedor;
  DocumentReference? get vendedor => _vendedor;
  bool hasVendedor() => _vendedor != null;

  // "valor" field.
  double? _valor;
  double get valor => _valor ?? 0.0;
  bool hasValor() => _valor != null;

  // "data_postagem" field.
  DateTime? _dataPostagem;
  DateTime? get dataPostagem => _dataPostagem;
  bool hasDataPostagem() => _dataPostagem != null;

  // "material" field.
  DocumentReference? _material;
  DocumentReference? get material => _material;
  bool hasMaterial() => _material != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _vendedor = snapshotData['vendedor'] as DocumentReference?;
    _valor = castToType<double>(snapshotData['valor']);
    _dataPostagem = snapshotData['data_postagem'] as DateTime?;
    _material = snapshotData['material'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductsRecord.fromSnapshot(s));

  static Future<ProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductsRecord.fromSnapshot(s));

  static ProductsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductsRecordData({
  String? id,
  DocumentReference? vendedor,
  double? valor,
  DateTime? dataPostagem,
  DocumentReference? material,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'vendedor': vendedor,
      'valor': valor,
      'data_postagem': dataPostagem,
      'material': material,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductsRecordDocumentEquality implements Equality<ProductsRecord> {
  const ProductsRecordDocumentEquality();

  @override
  bool equals(ProductsRecord? e1, ProductsRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.vendedor == e2?.vendedor &&
        e1?.valor == e2?.valor &&
        e1?.dataPostagem == e2?.dataPostagem &&
        e1?.material == e2?.material;
  }

  @override
  int hash(ProductsRecord? e) => const ListEquality()
      .hash([e?.id, e?.vendedor, e?.valor, e?.dataPostagem, e?.material]);

  @override
  bool isValidKey(Object? o) => o is ProductsRecord;
}
