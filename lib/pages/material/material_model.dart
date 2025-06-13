import '/backend/backend.dart';
import '/components/edit_material/edit_material_widget.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'material_widget.dart' show MaterialWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MaterialModel extends FlutterFlowModel<MaterialWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for amentities widget.
  FormFieldController<List<String>>? amentitiesValueController;
  String? get amentitiesValue => amentitiesValueController?.value?.firstOrNull;
  set amentitiesValue(String? val) =>
      amentitiesValueController?.value = val != null ? [val] : [];
  // Model for FooterBar component.
  late FooterBarModel footerBarModel;

  @override
  void initState(BuildContext context) {
    footerBarModel = createModel(context, () => FooterBarModel());
  }

  @override
  void dispose() {
    footerBarModel.dispose();
  }
}
