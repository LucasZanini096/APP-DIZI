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

// AutoSaveManager CORRIGIDO para FlutterFlow
// Usando JSON strings ao invés de Map<String, dynamic>

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:convert';

class AutoSaveManager {
  static Timer? _autoSaveTimer;
  static String? _currentDrawingId;
  static String? _lastSavedDataJson; // Mudança: String ao invés de Map
  static int _intervalSeconds = 30;
  static bool _isAutoSaving = false;

  // VERSÃO CORRIGIDA: startAutoSave
  static void startAutoSave(
    String drawingId,
    String drawingDataJson, // Mudança: JSON string
    int intervalSeconds,
  ) {
    try {
      // Cancelar timer anterior se existir
      stopAutoSave();

      _currentDrawingId = drawingId;
      _lastSavedDataJson = drawingDataJson;
      _intervalSeconds = intervalSeconds;

      // Criar novo timer
      _autoSaveTimer = Timer.periodic(
        Duration(seconds: intervalSeconds),
        (timer) async {
          if (_currentDrawingId != null &&
              _lastSavedDataJson != null &&
              !_isAutoSaving) {
            _isAutoSaving = true;

            try {
              // Usar função corrigida de update
              final success = await updateDrawingInFirebase(
                _currentDrawingId!,
                _lastSavedDataJson!,
                '', // Mantém título atual
              );

              if (success) {
                print('Auto-save realizado com sucesso');
              } else {
                print('Falha no auto-save');
              }
            } catch (e) {
              print('Erro no auto-save: $e');
            } finally {
              _isAutoSaving = false;
            }
          }
        },
      );

      print('Auto-save iniciado: ${intervalSeconds}s para ID $drawingId');
    } catch (e) {
      print('Erro ao iniciar auto-save: $e');
    }
  }

  // VERSÃO CORRIGIDA: updateDataForAutoSave
  static void updateDataForAutoSave(String newDataJson) {
    try {
      _lastSavedDataJson = newDataJson;
      // Validar se é JSON válido
      jsonDecode(newDataJson);
    } catch (e) {
      print('Erro ao atualizar dados para auto-save: $e');
    }
  }

  // Sobrecarga para aceitar Map (converte automaticamente)
  static void updateDataForAutoSaveFromMap(Map<String, dynamic> newData) {
    try {
      _lastSavedDataJson = jsonEncode(newData);
    } catch (e) {
      print('Erro ao converter Map para JSON: $e');
    }
  }

  static void stopAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
    _currentDrawingId = null;
    _lastSavedDataJson = null;
    _isAutoSaving = false;
    print('Auto-save parado');
  }

  // Getters para status
  static bool get isActive => _autoSaveTimer != null;
  static String? get currentDrawingId => _currentDrawingId;
  static int get intervalSeconds => _intervalSeconds;
  static bool get isAutoSaving => _isAutoSaving;

  // Forçar auto-save manual
  static Future<bool> forceSave() async {
    if (_currentDrawingId != null &&
        _lastSavedDataJson != null &&
        !_isAutoSaving) {
      _isAutoSaving = true;

      try {
        final success = await updateDrawingInFirebase(
          _currentDrawingId!,
          _lastSavedDataJson!,
          '',
        );

        print('Force save ${success ? 'realizado' : 'falhou'}');
        return success;
      } catch (e) {
        print('Erro no force save: $e');
        return false;
      } finally {
        _isAutoSaving = false;
      }
    }
    return false;
  }

  // Resetar timer (útil para mudar intervalo)
  static void restartWithNewInterval(int newIntervalSeconds) {
    if (_currentDrawingId != null && _lastSavedDataJson != null) {
      final currentId = _currentDrawingId!;
      final currentData = _lastSavedDataJson!;

      stopAutoSave();
      startAutoSave(currentId, currentData, newIntervalSeconds);
    }
  }
}

// FUNÇÃO PRINCIPAL CORRIGIDA para Custom Action
Future<void> autoSaveDrawing(
  String drawingId,
  String drawingDataJson, // Mudança: JSON string
  int intervalSeconds,
) async {
  try {
    if (drawingId.isEmpty || drawingDataJson.isEmpty) {
      print('Dados inválidos para auto-save');
      return;
    }

    // Validar JSON
    jsonDecode(drawingDataJson);

    AutoSaveManager.startAutoSave(drawingId, drawingDataJson, intervalSeconds);
  } catch (e) {
    print('Erro ao iniciar auto-save: $e');
  }
}

// VERSÃO ALTERNATIVA: aceita Map e converte internamente
Future<void> autoSaveDrawingFromMap(
  String drawingId,
  Map<String, dynamic> drawingData,
  int intervalSeconds,
) async {
  try {
    final drawingDataJson = jsonEncode(drawingData);
    await autoSaveDrawing(drawingId, drawingDataJson, intervalSeconds);
  } catch (e) {
    print('Erro ao converter Map para auto-save: $e');
  }
}

// HELPER FUNCTIONS para integração fácil

// Para usar no callback do DiziDrawingBoardWidget
void setupAutoSaveFromWidget(String drawingId, Map<String, dynamic> initialData,
    {int intervalSeconds = 30}) {
  try {
    final jsonString = jsonEncode(initialData);
    AutoSaveManager.startAutoSave(drawingId, jsonString, intervalSeconds);
  } catch (e) {
    print('Erro ao configurar auto-save: $e');
  }
}

// Para atualizar dados no callback onSave
void updateAutoSaveData(Map<String, dynamic> newData) {
  AutoSaveManager.updateDataForAutoSaveFromMap(newData);
}

// Para parar auto-save ao sair da tela
void cleanupAutoSave() {
  AutoSaveManager.stopAutoSave();
}

// CONFIGURAÇÃO AVANÇADA: Auto-save inteligente
class SmartAutoSave {
  static DateTime? _lastChange;
  static Timer? _debounceTimer;
  static const int _debounceSeconds = 3; // Espera 3s após última mudança

  static void onDrawingChanged(
    String drawingId,
    Map<String, dynamic> drawingData,
  ) {
    _lastChange = DateTime.now();

    // Cancelar timer anterior
    _debounceTimer?.cancel();

    // Atualizar dados no AutoSaveManager
    AutoSaveManager.updateDataForAutoSaveFromMap(drawingData);

    // Criar novo timer de debounce
    _debounceTimer = Timer(Duration(seconds: _debounceSeconds), () {
      // Se não houve mudanças nos últimos X segundos, fazer save
      final timeSinceLastChange = DateTime.now().difference(_lastChange!);
      if (timeSinceLastChange.inSeconds >= _debounceSeconds) {
        AutoSaveManager.forceSave();
      }
    });
  }

  static void cleanup() {
    _debounceTimer?.cancel();
    _lastChange = null;
  }
}

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
