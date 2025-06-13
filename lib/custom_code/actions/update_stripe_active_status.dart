// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> updateStripeActiveStatus(
  String? userDocId,
  bool isActive,
) async {
  // Se o ID do documento não for fornecido, retorna falha
  if (userDocId == null || userDocId.isEmpty) {
    return false;
  }

  try {
    // Referência ao documento do usuário
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String documentPath = "/users/$userDocId"; // Caminho do documento
    DocumentReference documentReference = firestore.doc(documentPath);

    // Verificar se o documento existe
    final docSnapshot = await documentReference.get();
    if (!docSnapshot.exists) {
      print('Documento não encontrado: $documentPath');
      return false;
    }

    // Atualizar apenas o campo is_active_stripe
    await documentReference.update({
      'is_active_stripe': isActive,
    });

    print('Status Stripe atualizado com sucesso para: $isActive');
    return true;
  } catch (e) {
    print('Erro ao atualizar status Stripe: ${e.toString()}');
    return false;
  }
}
