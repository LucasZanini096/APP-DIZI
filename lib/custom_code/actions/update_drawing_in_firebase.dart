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

// VERSÃO CORRIGIDA: updateDrawingInFirebase
// Solução para o erro "Unable to process parameter"

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:convert';

// SOLUÇÃO 1: Usando JSON String (Recomendada)
Future<bool> updateDrawingInFirebase(
  String drawingId,
  String drawingDataJson,
  String drawingTitle,
) async {
  try {
    // Verificar se usuário está logado
    if (currentUserUid.isEmpty) {
      print('Usuário não está logado');
      return false;
    }

    // Parse do JSON string
    Map<String, dynamic> drawingData;
    try {
      drawingData = jsonDecode(drawingDataJson) as Map<String, dynamic>;
    } catch (e) {
      print('Erro ao fazer parse do JSON: $e');
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
      print('Usuário não tem permissão para editar este desenho');
      return false;
    }

    // Atualizar dados
    await docRef.update({
      'title': drawingTitle.isNotEmpty ? drawingTitle : docData['title'],
      'drawingData': drawingData,
      'lastModified': FieldValue.serverTimestamp(),
      'pageType': drawingData['pageType'] ?? docData['pageType'] ?? 'blank',
      'version': (docData['version'] ?? 1) + 1,
    });

    print('Desenho atualizado com sucesso');
    return true;
  } catch (e) {
    print('Erro ao atualizar desenho: $e');
    return false;
  }
}

// HELPER: Batch update para múltiplos desenhos
Future<bool> batchUpdateDrawings(
  List<String> drawingIds,
  List<String> drawingDataJsonList,
) async {
  try {
    if (drawingIds.length != drawingDataJsonList.length) {
      print('Listas de IDs e dados devem ter o mesmo tamanho');
      return false;
    }

    final batch = FirebaseFirestore.instance.batch();

    for (int i = 0; i < drawingIds.length; i++) {
      final drawingData =
          jsonDecode(drawingDataJsonList[i]) as Map<String, dynamic>;
      final docRef =
          FirebaseFirestore.instance.collection('drawings').doc(drawingIds[i]);

      batch.update(docRef, {
        'drawingData': drawingData,
        'lastModified': FieldValue.serverTimestamp(),
        'pageType': drawingData['pageType'] ?? 'blank',
      });
    }

    await batch.commit();
    print('Batch update realizado com sucesso');
    return true;
  } catch (e) {
    print('Erro no batch update: $e');
    return false;
  }
}
