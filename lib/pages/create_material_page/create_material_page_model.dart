import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'create_material_page_widget.dart' show CreateMaterialPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateMaterialPageModel
    extends FlutterFlowModel<CreateMaterialPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nomeMaterial widget.
  FocusNode? nomeMaterialFocusNode;
  TextEditingController? nomeMaterialTextController;
  String? Function(BuildContext, String?)? nomeMaterialTextControllerValidator;
  String? _nomeMaterialTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for descricaoMaterial widget.
  FocusNode? descricaoMaterialFocusNode;
  TextEditingController? descricaoMaterialTextController;
  String? Function(BuildContext, String?)?
      descricaoMaterialTextControllerValidator;
  // State field(s) for Cadernos widget.
  String? cadernosValue;
  FormFieldController<String>? cadernosValueController;
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
  bool isDataUploading_uploadDataLoi = false;
  FFUploadedFile uploadedLocalFile_uploadDataLoi =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_uploadDataLui = false;
  FFUploadedFile uploadedLocalFile_uploadDataLui =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataLui = '';

  @override
  void initState(BuildContext context) {
    nomeMaterialTextControllerValidator = _nomeMaterialTextControllerValidator;
  }

  @override
  void dispose() {
    nomeMaterialFocusNode?.dispose();
    nomeMaterialTextController?.dispose();

    descricaoMaterialFocusNode?.dispose();
    descricaoMaterialTextController?.dispose();
  }
}
