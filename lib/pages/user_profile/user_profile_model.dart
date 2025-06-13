import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/post_card/post_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'user_profile_widget.dart' show UserProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfileModel extends FlutterFlowModel<UserProfileWidget> {
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
