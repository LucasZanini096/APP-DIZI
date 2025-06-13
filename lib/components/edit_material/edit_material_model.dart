import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'edit_material_widget.dart' show EditMaterialWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditMaterialModel extends FlutterFlowModel<EditMaterialWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for NameMaterial widget.
  FocusNode? nameMaterialFocusNode;
  TextEditingController? nameMaterialTextController;
  String? Function(BuildContext, String?)? nameMaterialTextControllerValidator;
  // State field(s) for Describe widget.
  FocusNode? describeFocusNode;
  TextEditingController? describeTextController;
  String? Function(BuildContext, String?)? describeTextControllerValidator;
  // State field(s) for ModelType widget.
  FormFieldController<List<String>>? modelTypeValueController;
  String? get modelTypeValue => modelTypeValueController?.value?.firstOrNull;
  set modelTypeValue(String? val) =>
      modelTypeValueController?.value = val != null ? [val] : [];
  // State field(s) for PageType widget.
  FormFieldController<List<String>>? pageTypeValueController;
  String? get pageTypeValue => pageTypeValueController?.value?.firstOrNull;
  set pageTypeValue(String? val) =>
      pageTypeValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameMaterialFocusNode?.dispose();
    nameMaterialTextController?.dispose();

    describeFocusNode?.dispose();
    describeTextController?.dispose();
  }
}
