import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'create_product_page_widget.dart' show CreateProductPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateProductPageModel extends FlutterFlowModel<CreateProductPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for amentities widget.
  FormFieldController<List<String>>? amentitiesValueController;
  String? get amentitiesValue => amentitiesValueController?.value?.firstOrNull;
  set amentitiesValue(String? val) =>
      amentitiesValueController?.value = val != null ? [val] : [];
  // State field(s) for precoProduto widget.
  FocusNode? precoProdutoFocusNode;
  TextEditingController? precoProdutoTextController;
  String? Function(BuildContext, String?)? precoProdutoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    precoProdutoFocusNode?.dispose();
    precoProdutoTextController?.dispose();
  }
}
