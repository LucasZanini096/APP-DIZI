import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'area_of_interest_widget.dart' show AreaOfInterestWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class AreaOfInterestModel extends FlutterFlowModel<AreaOfInterestWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for AreaInterese widget.
  FormFieldController<List<String>>? areaIntereseValueController;
  String? get areaIntereseValue =>
      areaIntereseValueController?.value?.firstOrNull;
  set areaIntereseValue(String? val) =>
      areaIntereseValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
