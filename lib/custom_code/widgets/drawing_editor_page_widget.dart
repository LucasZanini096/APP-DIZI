// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// VERSÃO CORRIGIDA: DrawingEditorPageWidget para FlutterFlow
// Remove dependências de AutoSaveManager e Custom Actions que podem não estar disponíveis

import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/custom_code/widgets/dizi_drawing_board_widget.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:async';
import 'dart:convert';

class DrawingEditorPageWidget extends StatefulWidget {
  const DrawingEditorPageWidget({
    super.key,
    this.width,
    this.height,
    this.drawingId,
    this.title,
    this.pageType,
  });

  final String? drawingId;
  final String? title;
  final String? pageType;
  final double? width;
  final double? height;

  @override
  State<DrawingEditorPageWidget> createState() =>
      _DrawingEditorPageWidgetState();
}

class _DrawingEditorPageWidgetState extends State<DrawingEditorPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();

  // Estados da tela
  String? currentDrawingId;
  String currentTitle = '';
  String currentPageType = 'blank';
  Map<String, dynamic>? currentDrawingData;
  bool hasUnsavedChanges = false;
  bool isLoading = false;
  bool isSaving = false;
  DateTime? lastSaved;
  DateTime? lastAutoSave;
  bool isDeleted = false;

  // Auto-save simples
  Timer? autoSaveTimer;
  String? pendingDrawingDataJson;
  bool autoSaveEnabled = true;
  int autoSaveInterval = 30;
  String? lastSavedDataJson;
  bool isOnline = true;

  void _setupConnectivityListener() {
    // Verificar se está online periodicamente
    Timer.periodic(Duration(seconds: 60), (timer) {
      _checkConnectivity();
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
    _startAutoSave();
    _setupConnectivityListener();
  }

  @override
  void dispose() {
    autoSaveTimer?.cancel();
    titleController.dispose();
    super.dispose();
  }

  // Inicializar página
  Future<void> _initializePage() async {
    if (widget.drawingId != null) {
      // Carregar desenho existente
      await _loadExistingDrawing(widget.drawingId!);
    } else {
      // Novo desenho
      _setupNewDrawing();
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      await FirebaseFirestore.instance
          .collection('test')
          .doc('connectivity')
          .get();

      if (!isOnline) {
        setState(() {
          isOnline = true;
        });
        _showSuccessMessage('Conexão restabelecida');
      }
    } catch (e) {
      if (isOnline) {
        setState(() {
          isOnline = false;
        });
        _showErrorMessage('Sem conexão - salvamento offline ativado');
      }
    }
  }

  // Configurar novo desenho
  void _setupNewDrawing() {
    setState(() {
      currentDrawingId = null;
      currentTitle = widget.title ??
          'Novo Desenho ${DateTime.now().day}/${DateTime.now().month}';
      currentPageType = widget.pageType ?? 'blank';
      currentDrawingData = null;
      hasUnsavedChanges = false;
      titleController.text = currentTitle;
    });
  }

  // IMPLEMENTAÇÃO DIRETA: Carregar desenho existente
  Future<void> _loadExistingDrawing(String drawingId) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Implementação direta da consulta ao Firestore
      final docSnapshot = await FirebaseFirestore.instance
          .collection('drawings')
          .doc(drawingId)
          .get();

      if (!docSnapshot.exists) {
        _showErrorMessage('Desenho não encontrado');
        context.pop();
        return;
      }

      final docData = docSnapshot.data() as Map<String, dynamic>;

      // Verificar permissões
      if (docData['userId'] != currentUserUid && docData['isPublic'] != true) {
        _showErrorMessage('Sem permissão para acessar este desenho');
        context.pop();
        return;
      }

      if (mounted) {
        setState(() {
          currentDrawingId = drawingId;
          currentTitle = docData['title'] ?? 'Desenho sem título';
          currentPageType = docData['pageType'] ?? 'blank';
          currentDrawingData = docData['drawingData'];
          hasUnsavedChanges = false;
          titleController.text = currentTitle;
        });

        // Preparar dados para auto-save
        if (currentDrawingData != null) {
          pendingDrawingDataJson = jsonEncode(currentDrawingData!);
        }

        _showSuccessMessage('Desenho carregado com sucesso!');
      }
    } catch (e) {
      _showErrorMessage('Erro ao carregar: $e');
      context.pop();
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Timer de auto-save simples
  void _startAutoSave() {
    if (!autoSaveEnabled) return;

    autoSaveTimer =
        Timer.periodic(Duration(seconds: autoSaveInterval), (timer) async {
      if (currentDrawingId != null &&
          pendingDrawingDataJson != null &&
          hasUnsavedChanges &&
          !isSaving) {
        final success = await _performAutoSave();
        if (success && mounted) {
          setState(() {
            hasUnsavedChanges = false;
            lastAutoSave = DateTime.now();
          });
        }
      }
    });
  }

  // IMPLEMENTAÇÃO DIRETA: Auto-save
  Future<bool> _performAutoSave() async {
    if (currentDrawingId == null ||
        pendingDrawingDataJson == null ||
        !isOnline ||
        isDeleted) {
      return false;
    }

    // Verificar se realmente houve mudanças
    if (lastSavedDataJson == pendingDrawingDataJson) {
      print('💾 Nenhuma mudança detectada, pulando auto-save');
      return true;
    }

    try {
      final drawingData =
          jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

      // ADIÇÃO: Validar dados antes de salvar
      if (!_validateDrawingData(drawingData)) {
        print('⚠️ Dados inválidos, não salvando');
        return false;
      }

      await FirebaseFirestore.instance
          .collection('drawings')
          .doc(currentDrawingId!)
          .update({
        'drawingData': drawingData,
        'lastModified': FieldValue.serverTimestamp(),
        'title': currentTitle, // ADIÇÃO: Salvar título também
        'pageType': currentPageType,
        'version': FieldValue.increment(1),
        'isDeleted':
            false, // ADIÇÃO: Garantir que não está marcado como deletado
      });

      // Marcar como salvo
      lastSavedDataJson = pendingDrawingDataJson;

      print('✅ Auto-save realizado para: $currentDrawingId');
      return true;
    } catch (e) {
      print('❌ Erro no auto-save: $e');
      return false;
    }
  }

  bool _validateDrawingData(Map<String, dynamic> data) {
    try {
      // Verificar estrutura básica
      if (!data.containsKey('strokes')) {
        data['strokes'] = [];
      }

      if (!data.containsKey('backgroundColor')) {
        data['backgroundColor'] = '#FFFFFF';
      }

      if (!data.containsKey('canvasSize')) {
        data['canvasSize'] = {'width': 800, 'height': 600};
      }

      // Validar traços
      final strokes = data['strokes'] as List<dynamic>? ?? [];
      for (final stroke in strokes) {
        if (stroke is! Map<String, dynamic>) continue;

        // Garantir que stroke tem ID
        if (!stroke.containsKey('id')) {
          stroke['id'] = 'stroke_${DateTime.now().millisecondsSinceEpoch}';
        }

        // Garantir que tem pontos
        if (!stroke.containsKey('points')) {
          stroke['points'] = [];
        }
      }

      return true;
    } catch (e) {
      print('❌ Erro na validação dos dados: $e');
      return false;
    }
  }

  // IMPLEMENTAÇÃO DIRETA: Salvar desenho manualmente
  Future<void> _saveDrawing() async {
    if (isSaving || isDeleted) return;

    // Verificar conectividade
    if (!isOnline) {
      _showErrorMessage('Sem conexão. Tente novamente quando estiver online.');
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      bool success = false;

      if (currentDrawingId == null) {
        // Primeiro salvamento
        if (pendingDrawingDataJson != null) {
          final drawingData =
              jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

          final docRef =
              await FirebaseFirestore.instance.collection('drawings').add({
            'title': currentTitle,
            'userId': currentUserUid,
            'drawingData': drawingData,
            'createdAt': FieldValue.serverTimestamp(),
            'lastModified': FieldValue.serverTimestamp(),
            'pageType': currentPageType,
            'version': 1,
            'isPublic': false,
            'tags': <String>[],
          });

          setState(() {
            currentDrawingId = docRef.id;
          });

          success = await _createNewDrawing();
        }
      } else {
        // Atualizar existente
        if (pendingDrawingDataJson != null) {
          final drawingData =
              jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

          await FirebaseFirestore.instance
              .collection('drawings')
              .doc(currentDrawingId!)
              .update({
            'title': currentTitle,
            'drawingData': drawingData,
            'lastModified': FieldValue.serverTimestamp(),
            'pageType': drawingData['pageType'] ?? currentPageType,
            'version': FieldValue.increment(1),
          });

          success = await _updateExistingDrawing();
        }
      }

      if (success && mounted) {
        setState(() {
          hasUnsavedChanges = false;
          lastSaved = DateTime.now();
        });
        _showSuccessMessage('Desenho salvo com sucesso!');
      } else {
        _showErrorMessage('Erro ao salvar desenho');
      }
    } catch (e) {
      _showErrorMessage('Erro ao salvar: $e');
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Future<bool> _createNewDrawing() async {
    if (pendingDrawingDataJson == null) {
      // Criar dados vazios se não existir
      pendingDrawingDataJson = jsonEncode({
        'strokes': [],
        'backgroundColor': '#FFFFFF',
        'canvasSize': {'width': 800, 'height': 600},
      });
    }

    final drawingData =
        jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

    if (!_validateDrawingData(drawingData)) {
      return false;
    }

    final docRef = await FirebaseFirestore.instance.collection('drawings').add({
      'title': currentTitle.isNotEmpty ? currentTitle : 'Novo Desenho',
      'userId': currentUserUid,
      'drawingData': drawingData,
      'createdAt': FieldValue.serverTimestamp(),
      'lastModified': FieldValue.serverTimestamp(),
      'pageType': currentPageType,
      'version': 1,
      'isDeleted': false,
      'isPublic': false,
      'tags': <String>[],
    });

    setState(() {
      currentDrawingId = docRef.id;
    });

    lastSavedDataJson = pendingDrawingDataJson;
    print('✅ Novo desenho criado: ${docRef.id}');
    return true;
  }

  // NOVO: Atualizar desenho existente
  Future<bool> _updateExistingDrawing() async {
    if (pendingDrawingDataJson == null || currentDrawingId == null) {
      return false;
    }

    final drawingData =
        jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

    if (!_validateDrawingData(drawingData)) {
      return false;
    }

    await FirebaseFirestore.instance
        .collection('drawings')
        .doc(currentDrawingId!)
        .update({
      'title': currentTitle.isNotEmpty ? currentTitle : 'Desenho sem título',
      'drawingData': drawingData,
      'lastModified': FieldValue.serverTimestamp(),
      'pageType': currentPageType,
      'version': FieldValue.increment(1),
      'isDeleted': false,
    });

    lastSavedDataJson = pendingDrawingDataJson;
    print('✅ Desenho atualizado: $currentDrawingId');
    return true;
  }

  // Callback quando desenho muda
  void _onDrawingChanged(Map<String, dynamic> data) {
    pendingDrawingDataJson = jsonEncode(data);

    setState(() {
      currentDrawingData = data;
      hasUnsavedChanges = true;
    });

    // Se é novo desenho e ainda não tem ID, fazer primeiro salvamento
    if (currentDrawingId == null && pendingDrawingDataJson != null) {
      _performFirstSave();
    }
  }

  // Primeiro salvamento automático
  Future<void> _performFirstSave() async {
    // Aguardar um pouco para garantir que o usuário está realmente desenhando
    await Future.delayed(Duration(seconds: 2));

    if (currentDrawingId == null &&
        pendingDrawingDataJson != null &&
        !isSaving &&
        mounted) {
      setState(() {
        isSaving = true;
      });

      try {
        final drawingData =
            jsonDecode(pendingDrawingDataJson!) as Map<String, dynamic>;

        final docRef =
            await FirebaseFirestore.instance.collection('drawings').add({
          'title': currentTitle,
          'userId': currentUserUid,
          'drawingData': drawingData,
          'createdAt': FieldValue.serverTimestamp(),
          'lastModified': FieldValue.serverTimestamp(),
          'pageType': currentPageType,
          'version': 1,
          'isPublic': false,
          'tags': <String>[],
        });

        if (mounted) {
          setState(() {
            currentDrawingId = docRef.id;
            hasUnsavedChanges = false;
            isSaving = false;
          });

          _showSuccessMessage('Desenho salvo automaticamente!');
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isSaving = false;
          });
        }
        print('Erro no primeiro salvamento: $e');
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (isDeleted) return true;

    if (hasUnsavedChanges) {
      return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Mudanças não salvas'),
                ],
              ),
              content: Text(
                'Você tem mudanças não salvas. O que deseja fazer?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Descartar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context, false);
                    await _saveDrawing();
                    if (!hasUnsavedChanges && mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Salvar e Sair'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return true;
  }

  // Dialog para editar título
  Future<void> _showEditTitleDialog() async {
    titleController.text = currentTitle;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Título'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Título do desenho',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            textCapitalization: TextCapitalization.sentences,
            maxLength: 50,
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                titleController.text = currentTitle;
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                final newTitle = titleController.text.trim();
                if (newTitle.isNotEmpty && newTitle != currentTitle) {
                  setState(() {
                    currentTitle = newTitle;
                    hasUnsavedChanges = true;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Dialog de configurações
  Future<void> _showSettingsDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.settings,
                      color: FlutterFlowTheme.of(context).primary),
                  SizedBox(width: 8),
                  Text('Configurações'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Auto-save
                    Row(
                      children: [
                        Icon(Icons.cloud_sync, size: 20),
                        SizedBox(width: 8),
                        Text('Auto-save',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),

                    SwitchListTile(
                      title: Text('Ativar auto-save'),
                      subtitle: Text('Salva automaticamente suas alterações'),
                      value: autoSaveEnabled,
                      onChanged: (value) {
                        setDialogState(() {
                          autoSaveEnabled = value;
                        });
                        setState(() {
                          autoSaveEnabled = value;
                        });

                        if (value) {
                          _startAutoSave();
                        } else {
                          autoSaveTimer?.cancel();
                        }
                      },
                    ),

                    if (autoSaveEnabled) ...[
                      SizedBox(height: 8),
                      Text('Intervalo: ${autoSaveInterval}s'),
                      Slider(
                        value: autoSaveInterval.toDouble(),
                        min: 10,
                        max: 120,
                        divisions: 11,
                        label: '${autoSaveInterval}s',
                        onChanged: (value) {
                          setDialogState(() {
                            autoSaveInterval = value.toInt();
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            autoSaveInterval = value.toInt();
                          });

                          // Reiniciar auto-save com novo intervalo
                          autoSaveTimer?.cancel();
                          _startAutoSave();
                        },
                      ),
                    ],

                    SizedBox(height: 16),

                    // Status
                    Row(
                      children: [
                        Icon(Icons.info, size: 20),
                        SizedBox(width: 8),
                        Text('Status',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),

                    if (lastSaved != null)
                      Text('Último save: ${_formatTime(lastSaved!)}'),
                    if (lastAutoSave != null)
                      Text('Último auto-save: ${_formatTime(lastAutoSave!)}'),
                    if (currentDrawingId != null)
                      Text('ID: ${currentDrawingId!.substring(0, 8)}...'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Fechar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Dialog de confirmação ao sair
  Future<bool> _showExitConfirmDialog() async {
    if (!hasUnsavedChanges) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Alterações não salvas'),
                ],
              ),
              content: Text(
                'Você tem alterações não salvas. Deseja sair sem salvar?',
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: Text('Salvar e Sair'),
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await _saveDrawing();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Sair sem Salvar',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'agora mesmo';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h atrás';
    } else {
      return '${time.day}/${time.month} às ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showExitConfirmDialog,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                final canExit = await _showExitConfirmDialog();
                if (canExit) {
                  context.pop();
                }
              },
            ),
            title: GestureDetector(
              onTap: _showEditTitleDialog,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentTitle,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (lastSaved != null || lastAutoSave != null)
                          Text(
                            lastAutoSave != null
                                ? 'Auto-save: ${_formatTime(lastAutoSave!)}'
                                : 'Salvo: ${_formatTime(lastSaved!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.edit, color: Colors.white70, size: 16),
                ],
              ),
            ),
            actions: [
              // Indicador de status
              if (hasUnsavedChanges)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Não salvo',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
              else if (autoSaveEnabled && autoSaveTimer?.isActive == true)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_done, size: 16, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Auto-save',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),

              // Indicador de salvamento
              if (isSaving)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),

              // Botão de salvar
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: isSaving ? null : _saveDrawing,
              ),

              // Menu de opções
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 20),
                        SizedBox(width: 8),
                        Text('Configurações'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'force_save',
                    child: Row(
                      children: [
                        Icon(Icons.save_alt, size: 20),
                        SizedBox(width: 8),
                        Text('Forçar Salvamento'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.clear_all, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Limpar Tudo',
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) async {
                  switch (value) {
                    case 'settings':
                      await _showSettingsDialog();
                      break;
                    case 'force_save':
                      await _saveDrawing();
                      break;
                    case 'clear':
                      _showClearConfirmDialog();
                      break;
                  }
                },
              ),
            ],
            centerTitle: false,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Carregando desenho...'),
                      ],
                    ),
                  )
                : DiziDrawingBoardWidget(
                    pageType: currentPageType,
                    backgroundColor: Colors.white,
                    initialDrawingData: currentDrawingData,
                    allowTextInput: true,
                    allowDrawing: true,
                    onSave: _onDrawingChanged,
                  ),
          ),
        ),
      ),
    );
  }

  // Dialog de confirmação para limpar tudo
  Future<void> _showClearConfirmDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Limpar Tudo'),
            ],
          ),
          content: Text(
            'Tem certeza de que deseja limpar todo o desenho? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Limpar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentDrawingData = {
                    'drawingStrokes': [],
                    'textElements': [],
                    'pageType': currentPageType,
                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                  };
                  hasUnsavedChanges = true;
                });
                _showSuccessMessage('Desenho limpo!');
              },
            ),
          ],
        );
      },
    );
  }
}
