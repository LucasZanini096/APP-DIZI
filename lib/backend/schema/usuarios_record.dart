import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsuariosRecord extends FirestoreRecord {
  UsuariosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "area_interesse" field.
  String? _areaInteresse;
  String get areaInteresse => _areaInteresse ?? '';
  bool hasAreaInteresse() => _areaInteresse != null;

  // "tipo_ensino" field.
  String? _tipoEnsino;
  String get tipoEnsino => _tipoEnsino ?? '';
  bool hasTipoEnsino() => _tipoEnsino != null;

  // "senha" field.
  String? _senha;
  String get senha => _senha ?? '';
  bool hasSenha() => _senha != null;

  // "id_usuario" field.
  String? _idUsuario;
  String get idUsuario => _idUsuario ?? '';
  bool hasIdUsuario() => _idUsuario != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "followers" field.
  List<DocumentReference>? _followers;
  List<DocumentReference> get followers => _followers ?? const [];
  bool hasFollowers() => _followers != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "photo_background" field.
  String? _photoBackground;
  String get photoBackground => _photoBackground ?? '';
  bool hasPhotoBackground() => _photoBackground != null;

  // "actual_streak" field.
  int? _actualStreak;
  int get actualStreak => _actualStreak ?? 0;
  bool hasActualStreak() => _actualStreak != null;

  // "last_time_activity" field.
  DateTime? _lastTimeActivity;
  DateTime? get lastTimeActivity => _lastTimeActivity;
  bool hasLastTimeActivity() => _lastTimeActivity != null;

  // "stripe_id_account" field.
  String? _stripeIdAccount;
  String get stripeIdAccount => _stripeIdAccount ?? '';
  bool hasStripeIdAccount() => _stripeIdAccount != null;

  // "is_active_stripe" field.
  bool? _isActiveStripe;
  bool get isActiveStripe => _isActiveStripe ?? false;
  bool hasIsActiveStripe() => _isActiveStripe != null;

  // "numero_telefone" field.
  String? _numeroTelefone;
  String get numeroTelefone => _numeroTelefone ?? '';
  bool hasNumeroTelefone() => _numeroTelefone != null;

  void _initializeFields() {
    _nome = snapshotData['nome'] as String?;
    _email = snapshotData['email'] as String?;
    _areaInteresse = snapshotData['area_interesse'] as String?;
    _tipoEnsino = snapshotData['tipo_ensino'] as String?;
    _senha = snapshotData['senha'] as String?;
    _idUsuario = snapshotData['id_usuario'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _followers = getDataList(snapshotData['followers']);
    _description = snapshotData['description'] as String?;
    _photoBackground = snapshotData['photo_background'] as String?;
    _actualStreak = castToType<int>(snapshotData['actual_streak']);
    _lastTimeActivity = snapshotData['last_time_activity'] as DateTime?;
    _stripeIdAccount = snapshotData['stripe_id_account'] as String?;
    _isActiveStripe = snapshotData['is_active_stripe'] as bool?;
    _numeroTelefone = snapshotData['numero_telefone'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('usuarios');

  static Stream<UsuariosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsuariosRecord.fromSnapshot(s));

  static Future<UsuariosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsuariosRecord.fromSnapshot(s));

  static UsuariosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UsuariosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsuariosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsuariosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsuariosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsuariosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsuariosRecordData({
  String? nome,
  String? email,
  String? areaInteresse,
  String? tipoEnsino,
  String? senha,
  String? idUsuario,
  String? photoUrl,
  String? description,
  String? photoBackground,
  int? actualStreak,
  DateTime? lastTimeActivity,
  String? stripeIdAccount,
  bool? isActiveStripe,
  String? numeroTelefone,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nome': nome,
      'email': email,
      'area_interesse': areaInteresse,
      'tipo_ensino': tipoEnsino,
      'senha': senha,
      'id_usuario': idUsuario,
      'photo_url': photoUrl,
      'description': description,
      'photo_background': photoBackground,
      'actual_streak': actualStreak,
      'last_time_activity': lastTimeActivity,
      'stripe_id_account': stripeIdAccount,
      'is_active_stripe': isActiveStripe,
      'numero_telefone': numeroTelefone,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsuariosRecordDocumentEquality implements Equality<UsuariosRecord> {
  const UsuariosRecordDocumentEquality();

  @override
  bool equals(UsuariosRecord? e1, UsuariosRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nome == e2?.nome &&
        e1?.email == e2?.email &&
        e1?.areaInteresse == e2?.areaInteresse &&
        e1?.tipoEnsino == e2?.tipoEnsino &&
        e1?.senha == e2?.senha &&
        e1?.idUsuario == e2?.idUsuario &&
        e1?.photoUrl == e2?.photoUrl &&
        listEquality.equals(e1?.followers, e2?.followers) &&
        e1?.description == e2?.description &&
        e1?.photoBackground == e2?.photoBackground &&
        e1?.actualStreak == e2?.actualStreak &&
        e1?.lastTimeActivity == e2?.lastTimeActivity &&
        e1?.stripeIdAccount == e2?.stripeIdAccount &&
        e1?.isActiveStripe == e2?.isActiveStripe &&
        e1?.numeroTelefone == e2?.numeroTelefone;
  }

  @override
  int hash(UsuariosRecord? e) => const ListEquality().hash([
        e?.nome,
        e?.email,
        e?.areaInteresse,
        e?.tipoEnsino,
        e?.senha,
        e?.idUsuario,
        e?.photoUrl,
        e?.followers,
        e?.description,
        e?.photoBackground,
        e?.actualStreak,
        e?.lastTimeActivity,
        e?.stripeIdAccount,
        e?.isActiveStripe,
        e?.numeroTelefone
      ]);

  @override
  bool isValidKey(Object? o) => o is UsuariosRecord;
}
