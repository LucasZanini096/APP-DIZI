import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'user_settings_widget.dart' show UserSettingsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserSettingsModel extends FlutterFlowModel<UserSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (connectAccountStripe)] action in contentView_1 widget.
  ApiCallResponse? apiResultxsh;
  // Stores action output result for [Backend Call - API (createAccount)] action in contentView_1 widget.
  ApiCallResponse? apiResultlf3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
