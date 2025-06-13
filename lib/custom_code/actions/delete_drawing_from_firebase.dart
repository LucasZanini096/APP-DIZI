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

import 'package:dizi/auth/firebase_auth/auth_util.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

Future<bool> deleteDrawingFromFirebase(String drawingId) async {
  try {
    // Verificar se usuário está logado
    if (currentUserUid.isEmpty) {
      print('Usuário não está logado');
      return false;
    }

    // Verificar se o documento existe e pertence ao usuário
    final docRef =
        FirebaseFirestore.instance.collection('drawings').doc(drawingId);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      print('Documento não encontrado');
      return false;
    }

    final docData = docSnapshot.data() as Map<String, dynamic>;
    if (docData['userId'] != currentUserUid) {
      print('Usuário não tem permissão para deletar este desenho');
      return false;
    }

    // Deletar documento
    await docRef.delete();
    print('Desenho deletado com sucesso');
    return true;
  } catch (e) {
    print('Erro ao deletar desenho: $e');
    return false;
  }
}
