import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'create_material_widget.dart' show CreateMaterialWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateMaterialModel extends FlutterFlowModel<CreateMaterialWidget> {
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
  bool isDataUploading_uploadDataS4w = false;
  FFUploadedFile uploadedLocalFile_uploadDataS4w =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_uploadDataXtn = false;
  FFUploadedFile uploadedLocalFile_uploadDataXtn =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataXtn = '';

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
