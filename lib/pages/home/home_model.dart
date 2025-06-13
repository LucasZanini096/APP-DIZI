import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/card_ansioso/card_ansioso_widget.dart';
import '/components/card_empolgado/card_empolgado_widget.dart';
import '/components/card_feliz/card_feliz_widget.dart';
import '/components/card_materia/card_materia_widget.dart';
import '/components/card_neutro/card_neutro_widget.dart';
import '/components/card_task/card_task_widget.dart';
import '/components/card_triste/card_triste_widget.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBar component.
  late NavBarModel navBarModel;
  // Model for CardFeliz component.
  late CardFelizModel cardFelizModel;
  // Model for CardAnsioso component.
  late CardAnsiosoModel cardAnsiosoModel;
  // Model for CardNeutro component.
  late CardNeutroModel cardNeutroModel;
  // Model for CardEmpolgado component.
  late CardEmpolgadoModel cardEmpolgadoModel;
  // Model for CardTriste component.
  late CardTristeModel cardTristeModel;
  // Model for FooterBar component.
  late FooterBarModel footerBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
    cardFelizModel = createModel(context, () => CardFelizModel());
    cardAnsiosoModel = createModel(context, () => CardAnsiosoModel());
    cardNeutroModel = createModel(context, () => CardNeutroModel());
    cardEmpolgadoModel = createModel(context, () => CardEmpolgadoModel());
    cardTristeModel = createModel(context, () => CardTristeModel());
    footerBarModel = createModel(context, () => FooterBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
    cardFelizModel.dispose();
    cardAnsiosoModel.dispose();
    cardNeutroModel.dispose();
    cardEmpolgadoModel.dispose();
    cardTristeModel.dispose();
    footerBarModel.dispose();
  }
}
