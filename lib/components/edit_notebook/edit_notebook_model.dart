import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'edit_notebook_widget.dart' show EditNotebookWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditNotebookModel extends FlutterFlowModel<EditNotebookWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for NameNotebbok widget.
  FocusNode? nameNotebbokFocusNode;
  TextEditingController? nameNotebbokTextController;
  String? Function(BuildContext, String?)? nameNotebbokTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameNotebbokFocusNode?.dispose();
    nameNotebbokTextController?.dispose();
  }
}
