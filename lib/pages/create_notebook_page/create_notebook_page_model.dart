import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'create_notebook_page_widget.dart' show CreateNotebookPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNotebookPageModel
    extends FlutterFlowModel<CreateNotebookPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nomeCaderno widget.
  FocusNode? nomeCadernoFocusNode;
  TextEditingController? nomeCadernoTextController;
  String? Function(BuildContext, String?)? nomeCadernoTextControllerValidator;
  String? _nomeCadernoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    nomeCadernoTextControllerValidator = _nomeCadernoTextControllerValidator;
  }

  @override
  void dispose() {
    nomeCadernoFocusNode?.dispose();
    nomeCadernoTextController?.dispose();
  }
}
