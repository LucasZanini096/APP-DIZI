import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FooterBar component.
  late FooterBarModel footerBarModel;

  @override
  void initState(BuildContext context) {
    footerBarModel = createModel(context, () => FooterBarModel());
  }

  @override
  void dispose() {
    footerBarModel.dispose();
  }
}
