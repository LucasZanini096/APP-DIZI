import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'edit_password_widget.dart' show EditPasswordWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPasswordModel extends FlutterFlowModel<EditPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Senha widget.
  FocusNode? senhaFocusNode;
  TextEditingController? senhaTextController;
  late bool senhaVisibility;
  String? Function(BuildContext, String?)? senhaTextControllerValidator;
  // State field(s) for ConfirmacaoSenha widget.
  FocusNode? confirmacaoSenhaFocusNode;
  TextEditingController? confirmacaoSenhaTextController;
  late bool confirmacaoSenhaVisibility;
  String? Function(BuildContext, String?)?
      confirmacaoSenhaTextControllerValidator;

  @override
  void initState(BuildContext context) {
    senhaVisibility = false;
    confirmacaoSenhaVisibility = false;
  }

  @override
  void dispose() {
    senhaFocusNode?.dispose();
    senhaTextController?.dispose();

    confirmacaoSenhaFocusNode?.dispose();
    confirmacaoSenhaTextController?.dispose();
  }
}
