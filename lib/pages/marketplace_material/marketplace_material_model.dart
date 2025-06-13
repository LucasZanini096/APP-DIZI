import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/product_comment_cad/product_comment_cad_widget.dart';
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
import 'marketplace_material_widget.dart' show MarketplaceMaterialWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketplaceMaterialModel
    extends FlutterFlowModel<MarketplaceMaterialWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (createCheckoutSession)] action in Button widget.
  ApiCallResponse? resultApiCheckout;
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
