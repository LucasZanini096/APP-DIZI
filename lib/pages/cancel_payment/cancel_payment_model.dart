import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'cancel_payment_widget.dart' show CancelPaymentWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CancelPaymentModel extends FlutterFlowModel<CancelPaymentWidget> {
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
