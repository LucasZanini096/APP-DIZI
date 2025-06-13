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

// VERSÃO CORRIGIDA: DrawingListPageWidget para FlutterFlow
// Remove dependências de Custom Actions que podem não estar disponíveis

import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:convert';

class DrawingListPageWidget extends StatefulWidget {
  const DrawingListPageWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<DrawingListPageWidget> createState() => _DrawingListPageWidgetState();
}

class _DrawingListPageWidgetState extends State<DrawingListPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Estados da tela
  List<dynamic> drawings = [];
  bool isLoading = true;
  bool isRefreshing = false;
  String searchQuery = '';
  String selectedCategory = 'all';

  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController newDrawingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDrawings();
  }

  @override
  void dispose() {
    searchController.dispose();
    newDrawingController.dispose();
    super.dispose();
  }

  // IMPLEMENTAÇÃO DIRETA: Carregar desenhos do Firebase
  Future<void> _loadDrawings() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      print('🔄 Carregando desenhos...');

      // Query simples que funciona sem índices customizados
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('drawings')
          .where('userId', isEqualTo: currentUserUid)
          .orderBy('lastModified',
              descending: true) // Este índice já existe por padrão
          .limit(100)
          .get();

      print('📊 Documentos encontrados: ${querySnapshot.docs.length}');

      // Processar e filtrar localmente
      final List<dynamic> userDrawings = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'title': data['title'] ?? 'Sem título',
              'pageType': data['pageType'] ?? 'blank',
              'createdAt': data['createdAt'],
              'lastModified': data['lastModified'],
              'version': data['version'] ?? 1,
              'hasDrawingData': data['drawingData'] != null,
              'isDeleted': data['isDeleted'] ?? false,
            };
          })
          .where((drawing) => drawing['isDeleted'] != true) // Filtrar deletados
          .take(50) // Limitar resultado
          .toList();

      print('✅ Desenhos ativos carregados: ${userDrawings.length}');

      if (mounted) {
        setState(() {
          drawings = userDrawings;
          isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Erro ao carregar desenhos: $e');

      // Se der erro, tentar query ainda mais simples
      try {
        print('🔄 Tentando query alternativa...');

        final QuerySnapshot fallbackQuery = await FirebaseFirestore.instance
            .collection('drawings')
            .where('userId', isEqualTo: currentUserUid)
            .limit(50)
            .get();

        final List<dynamic> fallbackDrawings = fallbackQuery.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return {
                'id': doc.id,
                'title': data['title'] ?? 'Sem título',
                'pageType': data['pageType'] ?? 'blank',
                'createdAt': data['createdAt'],
                'lastModified': data['lastModified'],
                'version': data['version'] ?? 1,
                'hasDrawingData': data['drawingData'] != null,
                'isDeleted': data['isDeleted'] ?? false,
              };
            })
            .where((drawing) => drawing['isDeleted'] != true)
            .toList();

        // Ordenar localmente
        fallbackDrawings.sort((a, b) {
          final aTime = a['lastModified'] as Timestamp?;
          final bTime = b['lastModified'] as Timestamp?;

          if (aTime == null && bTime == null) return 0;
          if (aTime == null) return 1;
          if (bTime == null) return -1;

          return bTime.compareTo(aTime);
        });

        if (mounted) {
          setState(() {
            drawings = fallbackDrawings;
            isLoading = false;
          });
        }

        print(
            '✅ Query alternativa funcionou: ${fallbackDrawings.length} desenhos');
      } catch (fallbackError) {
        print('❌ Erro crítico: $fallbackError');
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          _showErrorMessage('Erro ao carregar desenhos: $fallbackError');
        }
      }
    }
  }

  // Refresh da lista
  Future<void> _refreshDrawings() async {
    setState(() {
      isRefreshing = true;
    });

    await _loadDrawings();

    if (mounted) {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  // Filtrar desenhos
  List<dynamic> get filteredDrawings {
    var filtered = drawings.where((drawing) {
      final title = (drawing['title'] ?? '').toString().toLowerCase();
      final matchesSearch =
          searchQuery.isEmpty || title.contains(searchQuery.toLowerCase());

      bool matchesCategory = true;
      if (selectedCategory != 'all') {
        matchesCategory = (drawing['pageType'] ?? 'blank') == selectedCategory;
      }

      return matchesSearch && matchesCategory;
    }).toList();

    return filtered;
  }

  // Navegar para tela de desenho
  void _openDrawing(String drawingId, String title) {
    _navigateToEditor(
      drawingId: drawingId,
      title: title,
    );
  }

  // Criar novo desenho
  void _createNewDrawing() {
    _showNewDrawingDialog();
  }

  // Dialog para novo desenho
  Future<void> _showNewDrawingDialog() async {
    newDrawingController.clear();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String selectedPageType = 'blank';

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.add_circle,
                      color: FlutterFlowTheme.of(context).primary),
                  SizedBox(width: 8),
                  Text('Novo Desenho'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo de título
                    TextField(
                      controller: newDrawingController,
                      decoration: InputDecoration(
                        labelText: 'Título do desenho',
                        hintText: 'Ex: Meu desenho incrível',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 50,
                    ),

                    SizedBox(height: 16),

                    // Seletor de tipo de página
                    Text(
                      'Tipo de página:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 8),

                    // Cards de seleção de tipo
                    Column(
                      children: [
                        _buildPageTypeCard(
                          'blank',
                          'Página em Branco',
                          'Ideal para desenhos livres',
                          Icons.crop_portrait,
                          selectedPageType,
                          (type) =>
                              setDialogState(() => selectedPageType = type),
                        ),
                        SizedBox(height: 8),
                        _buildPageTypeCard(
                          'lined',
                          'Página Pautada',
                          'Perfeita para anotações',
                          Icons.format_line_spacing,
                          selectedPageType,
                          (type) =>
                              setDialogState(() => selectedPageType = type),
                        ),
                        SizedBox(height: 8),
                        _buildPageTypeCard(
                          'grid',
                          'Página Quadriculada',
                          'Ótima para desenhos técnicos',
                          Icons.grid_4x4,
                          selectedPageType,
                          (type) =>
                              setDialogState(() => selectedPageType = type),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.create, size: 18),
                  label: Text('Criar Desenho'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    final title = newDrawingController.text.trim();
                    if (title.isEmpty) {
                      _showErrorMessage('Por favor, digite um título');
                      return;
                    }

                    Navigator.of(context).pop();

                    // Navegar para tela de desenho com parâmetros
                    _navigateToEditor(
                      title: title,
                      pageType: selectedPageType,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Método para navegar para o editor
  void _navigateToEditor({
    String? drawingId,
    String? title,
    String? pageType,
  }) {
    final queryParams = <String, String>{};

    if (drawingId != null) {
      queryParams['drawingId'] = drawingId;
    }
    if (title != null) {
      queryParams['title'] = title;
    }
    if (pageType != null) {
      queryParams['pageType'] = pageType;
    }

    // IMPORTANTE: Ajuste o nome da rota conforme configurado no FlutterFlow
    context.pushNamed(
      'DrawingEditorPag', // Certifique-se de que esta rota existe
      queryParameters: queryParams,
    );
  }

  // Widget para card de tipo de página
  Widget _buildPageTypeCard(
    String type,
    String title,
    String description,
    IconData icon,
    String selectedType,
    Function(String) onTap,
  ) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => onTap(type),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? FlutterFlowTheme.of(context).primary.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).secondaryText,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: FlutterFlowTheme.of(context).primary,
              ),
          ],
        ),
      ),
    );
  }

  // IMPLEMENTAÇÃO DIRETA: Deletar desenho
  Future<void> _deleteDrawing(String drawingId, String title) async {
    final confirmed = await _showDeleteConfirmDialog(title);
    if (!confirmed) return;

    try {
      // Implementação direta da deleção
      await FirebaseFirestore.instance
          .collection('drawings')
          .doc(drawingId)
          .update({'isDeleted': true}); // Soft delete

      _showSuccessMessage('Desenho deletado com sucesso');
      await _loadDrawings(); // Recarregar lista
    } catch (e) {
      _showErrorMessage('Erro ao deletar: $e');
    }
  }

  // Dialog de confirmação de exclusão
  Future<bool> _showDeleteConfirmDialog(String title) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Confirmar Exclusão'),
                ],
              ),
              content: Text(
                'Tem certeza de que deseja excluir o desenho "$title"?\n\nEsta ação não pode ser desfeita.',
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Excluir', style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // IMPLEMENTAÇÃO DIRETA: Duplicar desenho
  Future<void> _duplicateDrawing(String drawingId, String originalTitle) async {
    try {
      // Carregar desenho original
      final docSnapshot = await FirebaseFirestore.instance
          .collection('drawings')
          .doc(drawingId)
          .get();

      if (!docSnapshot.exists) {
        _showErrorMessage('Desenho não encontrado');
        return;
      }

      final originalData = docSnapshot.data() as Map<String, dynamic>;
      final newTitle = '$originalTitle (Cópia)';

      // Criar cópia
      await FirebaseFirestore.instance.collection('drawings').add({
        'title': newTitle,
        'userId': currentUserUid,
        'drawingData': originalData['drawingData'],
        'createdAt': FieldValue.serverTimestamp(),
        'lastModified': FieldValue.serverTimestamp(),
        'pageType': originalData['pageType'] ?? 'blank',
        'version': 1,
        'isPublic': false,
        'tags': <String>[],
      });

      _showSuccessMessage('Desenho duplicado com sucesso');
      await _loadDrawings();
    } catch (e) {
      _showErrorMessage('Erro ao duplicar: $e');
    }
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

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Data desconhecida';

    try {
      DateTime date;
      if (timestamp is Timestamp) {
        date = timestamp.toDate();
      } else if (timestamp is int) {
        date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else if (timestamp is String) {
        date = DateTime.parse(timestamp);
      } else {
        return 'Data inválida';
      }

      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} dia${difference.inDays > 1 ? 's' : ''} atrás';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''} atrás';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} min atrás';
      } else {
        return 'Agora mesmo';
      }
    } catch (e) {
      return 'Data inválida';
    }
  }

  String _getPageTypeDisplayName(String pageType) {
    switch (pageType) {
      case 'lined':
        return 'Pautada';
      case 'grid':
        return 'Quadriculada';
      case 'blank':
      default:
        return 'Branca';
    }
  }

  IconData _getPageTypeIcon(String pageType) {
    switch (pageType) {
      case 'lined':
        return Icons.format_line_spacing;
      case 'grid':
        return Icons.grid_4x4;
      case 'blank':
      default:
        return Icons.crop_portrait;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filteredDrawings;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Meus Desenhos',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 24,
              ),
              onPressed: _refreshDrawings,
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              // Botão de Criar Novo Desenho (Destacado)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x1A000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: FFButtonWidget(
                  onPressed: _createNewDrawing,
                  text: 'Criar Novo Desenho',
                  icon: Icon(Icons.add_circle, size: 20),
                  options: FFButtonOptions(
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 2,
                  ),
                ),
              ),

              // Barra de pesquisa e filtros
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  children: [
                    // Campo de pesquisa
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar desenhos...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),

                    SizedBox(height: 12),

                    // Filtros de categoria
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('all', 'Todos'),
                          SizedBox(width: 8),
                          _buildFilterChip('blank', 'Branca'),
                          SizedBox(width: 8),
                          _buildFilterChip('lined', 'Pautada'),
                          SizedBox(width: 8),
                          _buildFilterChip('grid', 'Quadriculada'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de desenhos
              Expanded(
                child: isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Carregando desenhos...'),
                          ],
                        ),
                      )
                    : filteredList.isEmpty
                        ? _buildEmptyState()
                        : RefreshIndicator(
                            onRefresh: _refreshDrawings,
                            child: ListView.builder(
                              padding: EdgeInsets.all(16),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                final drawing = filteredList[index];
                                return _buildDrawingCard(drawing);
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = selectedCategory == value;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedCategory = value;
        });
      },
      selectedColor: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
      checkmarkColor: FlutterFlowTheme.of(context).primary,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.draw,
            size: 80,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
          SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? 'Nenhum desenho encontrado'
                : 'Nenhum desenho criado ainda',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
          ),
          SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty
                ? 'Tente pesquisar com outros termos'
                : 'Crie seu primeiro desenho tocando no botão acima',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          if (searchQuery.isEmpty)
            FFButtonWidget(
              onPressed: _createNewDrawing,
              text: 'Criar Primeiro Desenho',
              icon: Icon(Icons.add, size: 15),
              options: FFButtonOptions(
                width: 200,
                height: 44,
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                borderRadius: BorderRadius.circular(22),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDrawingCard(Map<String, dynamic> drawing) {
    final title = drawing['title'] ?? 'Sem título';
    final pageType = drawing['pageType'] ?? 'blank';
    final version = drawing['version'] ?? 1;
    final lastModified = drawing['lastModified'];

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        splashColor: FlutterFlowTheme.of(context).primary.withAlpha(30),
        onTap: () => _openDrawing(drawing['id'], title),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícone do tipo de página
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getPageTypeIcon(pageType),
                  color: FlutterFlowTheme.of(context).primary,
                  size: 24,
                ),
              ),

              SizedBox(width: 16),

              // Informações do desenho
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 16,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        SizedBox(width: 4),
                        Text(
                          _getPageTypeDisplayName(pageType),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                        SizedBox(width: 16),
                        Icon(
                          Icons.update,
                          size: 16,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'v$version',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Readex Pro',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatDate(lastModified),
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),

              // Menu de ações
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'open',
                    child: Row(
                      children: [
                        Icon(Icons.open_in_new, size: 20),
                        SizedBox(width: 8),
                        Text('Abrir'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'duplicate',
                    child: Row(
                      children: [
                        Icon(Icons.copy, size: 20),
                        SizedBox(width: 8),
                        Text('Duplicar'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Excluir', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) async {
                  switch (value) {
                    case 'open':
                      _openDrawing(drawing['id'], title);
                      break;
                    case 'duplicate':
                      await _duplicateDrawing(drawing['id'], title);
                      break;
                    case 'delete':
                      await _deleteDrawing(drawing['id'], title);
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
