import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'type_teach_widget.dart' show TypeTeachWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TypeTeachModel extends FlutterFlowModel<TypeTeachWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TipoEnsino widget.
  String? tipoEnsinoValue;
  FormFieldController<String>? tipoEnsinoValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
