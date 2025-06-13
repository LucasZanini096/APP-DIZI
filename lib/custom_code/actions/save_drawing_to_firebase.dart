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

Future<String?> saveDrawingToFirebase(
  String drawingDataJson,
  String drawingTitle,
) async {
  try {
    // Verificar se usuário está logado
    if (currentUserUid.isEmpty) {
      print('Usuário não está logado');
      return null;
    }

    // Parse do JSON string
    Map<String, dynamic> drawingData;
    try {
      drawingData = jsonDecode(drawingDataJson) as Map<String, dynamic>;
    } catch (e) {
      print('Erro ao fazer parse do JSON: $e');
      return null;
    }

    // Preparar dados para salvar
    final dataToSave = {
      'title': drawingTitle.isNotEmpty ? drawingTitle : 'Desenho sem título',
      'userId': currentUserUid,
      'drawingData': drawingData,
      'createdAt': FieldValue.serverTimestamp(),
      'lastModified': FieldValue.serverTimestamp(),
      'pageType': drawingData['pageType'] ?? 'blank',
      'version': 1,
      'isPublic': false,
      'tags': <String>[],
    };

    // Salvar no Firestore
    final docRef =
        await FirebaseFirestore.instance.collection('drawings').add(dataToSave);

    print('Desenho salvo com ID: ${docRef.id}');
    return docRef.id;
  } catch (e) {
    print('Erro ao salvar desenho: $e');
    return null;
  }
}
