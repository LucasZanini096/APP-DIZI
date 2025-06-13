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

// Custom Component: DiziDrawingBoard - VERSÃO CORRIGIDA
// Corrigido problema de congelamento + borracha funcional

import 'package:flutter/services.dart';

class DiziDrawingBoardWidget extends StatefulWidget {
  const DiziDrawingBoardWidget({
    super.key,
    this.width,
    this.height,
    required this.pageType,
    this.backgroundColor,
    this.onSave,
    this.initialDrawingData,
    this.allowTextInput = true,
    this.allowDrawing = true,
  });

  final double? width;
  final double? height;
  final String pageType;
  final Color? backgroundColor;
  final Function(Map<String, dynamic>)? onSave;
  final Map<String, dynamic>? initialDrawingData;
  final bool allowTextInput;
  final bool allowDrawing;

  @override
  State<DiziDrawingBoardWidget> createState() => _DiziDrawingBoardWidgetState();
}

class _DiziDrawingBoardWidgetState extends State<DiziDrawingBoardWidget> {
  // Estados do componente
  List<List<DrawingPoint>> drawingStrokes =
      []; // Mudança: lista de strokes ao invés de pontos
  List<TextElementData> textElements = [];

  // Configurações de desenho
  Color currentColor = Colors.black;
  double strokeWidth = 2.0;
  DrawingTool currentTool = DrawingTool.pen;

  // Configurações de texto
  String selectedFont = 'Inter';
  double fontSize = 16.0;
  Color textColor = Colors.black;

  // Estados da interface
  bool isDrawing = false;
  bool isAddingText = false;
  int? selectedTextIndex;
  List<DrawingPoint> currentStroke = []; // Stroke atual sendo desenhado

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    if (widget.initialDrawingData != null) {
      try {
        final data = widget.initialDrawingData!;
        if (data['drawingStrokes'] != null) {
          drawingStrokes = (data['drawingStrokes'] as List)
              .map((stroke) => (stroke as List)
                  .map((point) =>
                      DrawingPoint.fromMap(point as Map<String, dynamic>))
                  .toList())
              .toList();
        }
        if (data['textElements'] != null) {
          textElements = (data['textElements'] as List)
              .map((element) =>
                  TextElementData.fromMap(element as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        debugPrint('Erro ao carregar dados: $e');
      }
    }
  }

  void _saveData() {
    if (widget.onSave != null) {
      final data = {
        'drawingStrokes': drawingStrokes
            .map((stroke) => stroke.map((point) => point.toMap()).toList())
            .toList(),
        'textElements': textElements.map((element) => element.toMap()).toList(),
        'pageType': widget.pageType,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      widget.onSave!(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? 600,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Barra de ferramentas
          _buildToolbar(),

          // Área de desenho principal
          Expanded(
            child: Stack(
              children: [
                // Background com padrão
                _buildPageBackground(),

                // Canvas de desenho
                if (widget.allowDrawing) _buildDrawingCanvas(),

                // Elementos de texto
                if (widget.allowTextInput) ..._buildTextElements(),

                // Overlay para adicionar texto
                if (isAddingText) _buildTextInputOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Ferramentas de desenho
            if (widget.allowDrawing) ...[
              _buildToolButton(
                icon: Icons.edit,
                isSelected: currentTool == DrawingTool.pen,
                onTap: () => setState(() {
                  currentTool = DrawingTool.pen;
                  isAddingText = false;
                  selectedTextIndex = null;
                }),
              ),
              _buildToolButton(
                icon: Icons.brush,
                isSelected: currentTool == DrawingTool.brush,
                onTap: () => setState(() {
                  currentTool = DrawingTool.brush;
                  isAddingText = false;
                  selectedTextIndex = null;
                }),
              ),
              _buildToolButton(
                icon: Icons.auto_fix_high,
                isSelected: currentTool == DrawingTool.eraser,
                onTap: () => setState(() {
                  currentTool = DrawingTool.eraser;
                  isAddingText = false;
                  selectedTextIndex = null;
                }),
              ),

              // Seletor de cor (apenas para pen e brush)
              if (currentTool != DrawingTool.eraser) _buildColorPicker(),

              // Seletor de espessura
              _buildStrokeWidthSelector(),

              const SizedBox(width: 16),
            ],

            // Ferramentas de texto
            if (widget.allowTextInput) ...[
              _buildToolButton(
                icon: Icons.text_fields,
                isSelected: isAddingText,
                onTap: () => setState(() {
                  isAddingText = !isAddingText;
                  selectedTextIndex = null;
                  if (isAddingText)
                    currentTool =
                        DrawingTool.pen; // Reset para pen quando ativando texto
                }),
              ),

              // Seletor de fonte
              _buildFontSelector(),

              // Seletor de tamanho
              _buildFontSizeSelector(),

              const SizedBox(width: 16),
            ],

            // Ações gerais
            _buildToolButton(
              icon: Icons.clear_all,
              onTap: _clearAll,
            ),
            _buildToolButton(
              icon: Icons.undo,
              onTap: _undo,
            ),
            _buildToolButton(
              icon: Icons.save,
              onTap: _saveData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? FlutterFlowTheme.of(context).primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? Colors.white
                : FlutterFlowTheme.of(context).primaryText,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      Colors.black,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.pink,
    ];

    return PopupMenuButton<Color>(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: currentColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
      itemBuilder: (context) => colors
          .map((color) => PopupMenuItem<Color>(
                value: color,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ))
          .toList(),
      onSelected: (color) => setState(() => currentColor = color),
    );
  }

  Widget _buildStrokeWidthSelector() {
    final widths = [1.0, 2.0, 4.0, 6.0, 8.0, 12.0];

    return PopupMenuButton<double>(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: strokeWidth.clamp(1.0, 8.0),
              decoration: BoxDecoration(
                color: currentTool == DrawingTool.eraser
                    ? Colors.red
                    : currentColor,
                borderRadius: BorderRadius.circular(strokeWidth / 2),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
      itemBuilder: (context) => widths
          .map((width) => PopupMenuItem<double>(
                value: width,
                child: Container(
                  width: 40,
                  height: width.clamp(2.0, 12.0),
                  decoration: BoxDecoration(
                    color: currentTool == DrawingTool.eraser
                        ? Colors.red
                        : Colors.black,
                    borderRadius: BorderRadius.circular(width / 2),
                  ),
                ),
              ))
          .toList(),
      onSelected: (width) => setState(() => strokeWidth = width),
    );
  }

  Widget _buildFontSelector() {
    final fonts = ['Inter', 'Readex Pro', 'Outfit', 'Plus Jakarta Sans'];

    return PopupMenuButton<String>(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedFont, style: const TextStyle(fontSize: 12)),
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
      itemBuilder: (context) => fonts
          .map((font) => PopupMenuItem<String>(
                value: font,
                child: Text(font),
              ))
          .toList(),
      onSelected: (font) => setState(() => selectedFont = font ?? 'Inter'),
    );
  }

  Widget _buildFontSizeSelector() {
    final sizes = [10.0, 12.0, 14.0, 16.0, 18.0, 20.0, 24.0, 28.0];

    return PopupMenuButton<double>(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${fontSize.toInt()}', style: const TextStyle(fontSize: 12)),
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
      itemBuilder: (context) => sizes
          .map((size) => PopupMenuItem<double>(
                value: size,
                child: Text('${size.toInt()}pt'),
              ))
          .toList(),
      onSelected: (size) => setState(() => fontSize = size),
    );
  }

  Widget _buildPageBackground() {
    return CustomPaint(
      size: Size.infinite,
      painter: PageBackgroundPainter(
        pageType: widget.pageType,
        backgroundColor: widget.backgroundColor ?? Colors.white,
      ),
    );
  }

  Widget _buildDrawingCanvas() {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: CustomPaint(
        size: Size.infinite,
        painter: DrawingPainter(
          strokes: drawingStrokes,
          currentStroke: currentStroke,
        ),
      ),
    );
  }

  List<Widget> _buildTextElements() {
    return textElements.asMap().entries.map((entry) {
      final index = entry.key;
      final element = entry.value;

      return Positioned(
        left: element.position.dx,
        top: element.position.dy,
        child: GestureDetector(
          onTap: () {
            if (!isAddingText && currentTool == DrawingTool.pen) {
              _selectTextElement(index);
            }
          },
          onPanUpdate: (details) {
            if (selectedTextIndex == index) {
              _moveTextElement(index, details.delta);
            }
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: selectedTextIndex == index
                  ? Border.all(
                      color: FlutterFlowTheme.of(context).primary, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(4),
              color: selectedTextIndex == index
                  ? FlutterFlowTheme.of(context)
                      .primaryBackground
                      .withOpacity(0.8)
                  : Colors.transparent,
            ),
            child: selectedTextIndex == index
                ? TextField(
                    controller: TextEditingController(text: element.text),
                    style: TextStyle(
                      fontFamily: element.fontFamily,
                      fontSize: element.fontSize,
                      color: element.color,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) => _updateTextElement(index, value),
                    onSubmitted: (_) => _deselectTextElement(),
                    autofocus: true,
                  )
                : Text(
                    element.text,
                    style: TextStyle(
                      fontFamily: element.fontFamily,
                      fontSize: element.fontSize,
                      color: element.color,
                    ),
                  ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTextInputOverlay() {
    return GestureDetector(
      onTapDown: (details) {
        _addTextElement(details.localPosition);
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context)
                  .primaryBackground
                  .withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Toque onde deseja adicionar texto',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ),
        ),
      ),
    );
  }

  // Métodos de desenho CORRIGIDOS
  void _onPanStart(DragStartDetails details) {
    if (!widget.allowDrawing || isAddingText) return;

    setState(() {
      isDrawing = true;
      selectedTextIndex = null; // Desmarcar texto selecionado
      currentStroke = []; // Limpar stroke atual

      if (currentTool == DrawingTool.eraser) {
        // Para borracha, verificar se estamos sobre algum stroke
        _eraseAtPosition(details.localPosition);
      } else {
        // Para pen e brush, iniciar novo stroke
        currentStroke.add(DrawingPoint(
          offset: details.localPosition,
          paint: Paint()
            ..color = currentColor
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round,
          tool: currentTool,
        ));
      }
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!isDrawing) return;

    setState(() {
      if (currentTool == DrawingTool.eraser) {
        // Continuar apagando
        _eraseAtPosition(details.localPosition);
      } else {
        // Continuar desenhando
        currentStroke.add(DrawingPoint(
          offset: details.localPosition,
          paint: Paint()
            ..color = currentColor
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round,
          tool: currentTool,
        ));
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      isDrawing = false;

      if (currentTool != DrawingTool.eraser && currentStroke.isNotEmpty) {
        // Adicionar stroke completo à lista
        drawingStrokes.add(List.from(currentStroke));
      }

      currentStroke.clear();
    });
  }

  // Nova função para apagar
  void _eraseAtPosition(Offset position) {
    const double eraseRadius = 15.0; // Raio da borracha

    drawingStrokes.removeWhere((stroke) {
      return stroke.any((point) {
        if (point.offset == null) return false;
        final distance = (point.offset! - position).distance;
        return distance <= eraseRadius;
      });
    });
  }

  // Métodos de texto CORRIGIDOS
  void _addTextElement(Offset position) {
    if (!isAddingText) return;

    setState(() {
      final newElement = TextElementData(
        text: 'Novo texto',
        position: position,
        fontFamily: selectedFont,
        fontSize: fontSize,
        color: textColor,
      );
      textElements.add(newElement);
      selectedTextIndex = textElements.length - 1;
      isAddingText = false;
    });
  }

  void _selectTextElement(int index) {
    setState(() {
      selectedTextIndex = selectedTextIndex == index ? null : index;
    });
  }

  void _deselectTextElement() {
    setState(() {
      selectedTextIndex = null;
    });
  }

  void _moveTextElement(int index, Offset delta) {
    setState(() {
      textElements[index] = textElements[index].copyWith(
        position: textElements[index].position + delta,
      );
    });
  }

  void _updateTextElement(int index, String newText) {
    setState(() {
      textElements[index] = textElements[index].copyWith(text: newText);
    });
  }

  // Ações gerais
  void _clearAll() {
    setState(() {
      drawingStrokes.clear();
      currentStroke.clear();
      textElements.clear();
      selectedTextIndex = null;
      isAddingText = false;
    });
  }

  void _undo() {
    setState(() {
      if (drawingStrokes.isNotEmpty) {
        drawingStrokes.removeLast();
      } else if (textElements.isNotEmpty) {
        textElements.removeLast();
        selectedTextIndex = null;
      }
    });
  }
}

// Classes auxiliares
enum DrawingTool { pen, brush, eraser }

class DrawingPoint {
  final Offset? offset;
  final Paint paint;
  final DrawingTool tool;

  DrawingPoint({
    this.offset,
    required this.paint,
    required this.tool,
  });

  Map<String, dynamic> toMap() {
    return {
      'offset': offset != null ? {'dx': offset!.dx, 'dy': offset!.dy} : null,
      'color': paint.color.value,
      'strokeWidth': paint.strokeWidth,
      'tool': tool.index,
    };
  }

  static DrawingPoint fromMap(Map<String, dynamic> map) {
    return DrawingPoint(
      offset: map['offset'] != null
          ? Offset((map['offset']['dx'] as num).toDouble(),
              (map['offset']['dy'] as num).toDouble())
          : null,
      paint: Paint()
        ..color = Color(map['color'] as int)
        ..strokeWidth = (map['strokeWidth'] as num).toDouble()
        ..strokeCap = StrokeCap.round,
      tool: DrawingTool.values[map['tool'] as int],
    );
  }
}

class TextElementData {
  final String text;
  final Offset position;
  final String fontFamily;
  final double fontSize;
  final Color color;

  TextElementData({
    required this.text,
    required this.position,
    required this.fontFamily,
    required this.fontSize,
    required this.color,
  });

  TextElementData copyWith({
    String? text,
    Offset? position,
    String? fontFamily,
    double? fontSize,
    Color? color,
  }) {
    return TextElementData(
      text: text ?? this.text,
      position: position ?? this.position,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'position': {'dx': position.dx, 'dy': position.dy},
      'fontFamily': fontFamily,
      'fontSize': fontSize,
      'color': color.value,
    };
  }

  static TextElementData fromMap(Map<String, dynamic> map) {
    return TextElementData(
      text: map['text'] as String,
      position: Offset((map['position']['dx'] as num).toDouble(),
          (map['position']['dy'] as num).toDouble()),
      fontFamily: map['fontFamily'] as String,
      fontSize: (map['fontSize'] as num).toDouble(),
      color: Color(map['color'] as int),
    );
  }
}

class PageBackgroundPainter extends CustomPainter {
  final String pageType;
  final Color backgroundColor;

  PageBackgroundPainter({
    required this.pageType,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    switch (pageType) {
      case 'lined':
        for (double y = 30; y < size.height; y += 25) {
          canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), paint);
        }
        break;

      case 'grid':
        for (double y = 20; y < size.height; y += 20) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        }
        for (double x = 20; x < size.width; x += 20) {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
        }
        break;

      default:
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawingPainter extends CustomPainter {
  final List<List<DrawingPoint>> strokes;
  final List<DrawingPoint> currentStroke;

  DrawingPainter({
    required this.strokes,
    required this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Desenhar strokes completos
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    // Desenhar stroke atual
    if (currentStroke.isNotEmpty) {
      _drawStroke(canvas, currentStroke);
    }
  }

  void _drawStroke(Canvas canvas, List<DrawingPoint> stroke) {
    for (int i = 0; i < stroke.length - 1; i++) {
      if (stroke[i].offset != null && stroke[i + 1].offset != null) {
        canvas.drawLine(
          stroke[i].offset!,
          stroke[i + 1].offset!,
          stroke[i].paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
