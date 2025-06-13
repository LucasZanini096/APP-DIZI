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

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:convert';

/// SOLUÇÃO 1: Retornar JSON String (Recomendada)
Future<String?> loadDrawingFromFirebase(String drawingId) async {
  try {
    // Verificar se usuário está logado
    if (currentUserUid.isEmpty) {
      print('Usuário não está logado');
      return null;
    }

    // Buscar documento
    final docSnapshot = await FirebaseFirestore.instance
        .collection('drawings')
        .doc(drawingId)
        .get();

    if (!docSnapshot.exists) {
      print('Desenho não encontrado');
      return null;
    }

    final docData = docSnapshot.data() as Map<String, dynamic>;

    // Verificar permissões
    if (docData['userId'] != currentUserUid && docData['isPublic'] != true) {
      print('Usuário não tem permissão para acessar este desenho');
      return null;
    }

    // Preparar dados do desenho com metadados
    final result = {
      'id': drawingId,
      'title': docData['title'] ?? 'Sem título',
      'drawingData': docData['drawingData'] ?? {},
      'pageType': docData['pageType'] ?? 'blank',
      'createdAt': docData['createdAt']?.millisecondsSinceEpoch ?? 0,
      'lastModified': docData['lastModified']?.millisecondsSinceEpoch ?? 0,
      'version': docData['version'] ?? 1,
      'isOwner': docData['userId'] == currentUserUid,
      'isPublic': docData['isPublic'] ?? false,
      'tags': docData['tags'] ?? [],
      'viewCount': docData['viewCount'] ?? 0,
      'likeCount': docData['likeCount'] ?? 0,
    };

    // Converter para JSON string
    return jsonEncode(result);
  } catch (e) {
    print('Erro ao carregar desenho: $e');
    return null;
  }
}
