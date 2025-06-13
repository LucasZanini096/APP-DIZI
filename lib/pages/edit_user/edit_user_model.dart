import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_user_widget.dart' show EditUserWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditUserModel extends FlutterFlowModel<EditUserWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Nome widget.
  FocusNode? nomeFocusNode1;
  TextEditingController? nomeTextController1;
  String? Function(BuildContext, String?)? nomeTextController1Validator;
  // State field(s) for Nome widget.
  FocusNode? nomeFocusNode2;
  TextEditingController? nomeTextController2;
  String? Function(BuildContext, String?)? nomeTextController2Validator;
  // State field(s) for postagem widget.
  FocusNode? postagemFocusNode;
  TextEditingController? postagemTextController;
  String? Function(BuildContext, String?)? postagemTextControllerValidator;
  // State field(s) for TipoEnsino widget.
  String? tipoEnsinoValue;
  FormFieldController<String>? tipoEnsinoValueController;
  // State field(s) for AreaInterese widget.
  FormFieldController<List<String>>? areaIntereseValueController;
  String? get areaIntereseValue =>
      areaIntereseValueController?.value?.firstOrNull;
  set areaIntereseValue(String? val) =>
      areaIntereseValueController?.value = val != null ? [val] : [];
  bool isDataUploading_uploadData4jj = false;
  FFUploadedFile uploadedLocalFile_uploadData4jj =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData4jj = '';

  bool isDataUploading_uploadDataU0u = false;
  FFUploadedFile uploadedLocalFile_uploadDataU0u =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataU0u = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeFocusNode1?.dispose();
    nomeTextController1?.dispose();

    nomeFocusNode2?.dispose();
    nomeTextController2?.dispose();

    postagemFocusNode?.dispose();
    postagemTextController?.dispose();
  }
}
