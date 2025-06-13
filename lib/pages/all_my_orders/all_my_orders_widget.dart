import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/components/order_card/order_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_my_orders_model.dart';
export 'all_my_orders_model.dart';

/// Crie uma página no estilo "Marketplace" com os seguintes componentes e
/// estrutura:
///
/// Topo da página:
///
/// No canto superior esquerdo, exiba um círculo representando o avatar do
/// usuário.
///
/// À direita, adicione uma caixa de seleção/ícone que represente filtros de
/// pesquisa.
/// No canto superior direito, adicione um ícone de perfil/configurações.
/// Seção de busca:
///
/// Logo abaixo, inclua uma barra de pesquisa com um ícone de lupa à esquerda,
/// permitindo que o usuário digite palavras-chave.
/// Ao lado da barra de pesquisa, inclua um ícone de "filtros", possibilitando
/// que o usuário refine sua busca.
/// Seção "Materiais mais engajados":
///
/// Adicione um título com o texto "Materiais mais engajados" à esquerda.
/// À direita do título, adicione um link de texto "Veja todos" para
/// redirecionar o usuário a uma página com todos os materiais.
/// Abaixo do título, exiba uma grade de 2x2 com cartões representando
/// materiais engajados. Cada cartão deve conter:
/// Uma imagem/ícone de conteúdo.
/// Um título curto como "Material".
/// Uma pequena descrição ou identificação de quem criou o material.
/// Seção de "Categorias":
///
/// Adicione um título "Categorias".
/// Abaixo, exiba uma linha de ícones ou pequenos blocos representando as
/// categorias disponíveis, com ícones ou imagens de cada categoria.
/// Seção de "Matérias":
///
/// Adicione um título "Matérias".
/// Abaixo, exiba outra linha com pequenos blocos ou ícones, semelhantes à
/// seção de Categorias, mas representando diferentes matérias disponíveis no
/// marketplace.
class AllMyOrdersWidget extends StatefulWidget {
  const AllMyOrdersWidget({super.key});

  static String routeName = 'AllMyOrders';
  static String routePath = '/allMyOrders';

  @override
  State<AllMyOrdersWidget> createState() => _AllMyOrdersWidgetState();
}

class _AllMyOrdersWidgetState extends State<AllMyOrdersWidget> {
  late AllMyOrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllMyOrdersModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsuariosRecord>>(
      stream: queryUsuariosRecord(
        queryBuilder: (usuariosRecord) => usuariosRecord.where(
          'id_usuario',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<UsuariosRecord> allMyOrdersUsuariosRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final allMyOrdersUsuariosRecord =
            allMyOrdersUsuariosRecordList.isNotEmpty
                ? allMyOrdersUsuariosRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 32.0, 24.0, 24.0),
                      child: wrapWithModel(
                        model: _model.navBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: NavBarWidget(
                          photoUrl: allMyOrdersUsuariosRecord!.photoUrl,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Todos os meus pedidos',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily:
                                              'Glacial Indifference Regular',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<List<OrdersRecord>>(
                              stream: queryOrdersRecord(
                                queryBuilder: (ordersRecord) =>
                                    ordersRecord.where(
                                  'comprador',
                                  isEqualTo:
                                      allMyOrdersUsuariosRecord?.reference,
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<OrdersRecord> listViewOrdersRecordList =
                                    snapshot.data!;

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewOrdersRecordList.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 30.0),
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewOrdersRecord =
                                        listViewOrdersRecordList[listViewIndex];
                                    return OrderCardWidget(
                                      key: Key(
                                          'Keygke_${listViewIndex}_of_${listViewOrdersRecordList.length}'),
                                      order: listViewOrdersRecord.reference,
                                    );
                                  },
                                );
                              },
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.footerBarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: FooterBarWidget(),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
