import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/card_carderno/card_carderno_widget.dart';
import '/components/create_notebook/create_notebook_widget.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'library_model.dart';
export 'library_model.dart';

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
class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  static String routeName = 'Library';
  static String routePath = '/library';

  @override
  State<LibraryWidget> createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> {
  late LibraryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LibraryModel());

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
        List<UsuariosRecord> libraryUsuariosRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final libraryUsuariosRecord = libraryUsuariosRecordList.isNotEmpty
            ? libraryUsuariosRecordList.first
            : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: wrapWithModel(
                          model: _model.navBarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavBarWidget(
                            photoUrl: libraryUsuariosRecord!.photoUrl,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
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
                                      'Meus cadernos ',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily:
                                                'Glacial Indifference Regular',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Builder(
                                      builder: (context) =>
                                          FlutterFlowIconButton(
                                        borderRadius: 16.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 16.0,
                                        ),
                                        onPressed: () async {
                                          await showDialog(
                                            barrierColor: Color(0xB0000000),
                                            context: context,
                                            builder: (dialogContext) {
                                              return Dialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment: AlignmentDirectional(
                                                        0.0, 0.0)
                                                    .resolve(Directionality.of(
                                                        context)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(dialogContext)
                                                        .unfocus();
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                  child: Container(
                                                    height: 440.0,
                                                    width: 300.0,
                                                    child:
                                                        CreateNotebookWidget(),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: StreamBuilder<List<CadernosRecord>>(
                                  stream: queryCadernosRecord(
                                    queryBuilder: (cadernosRecord) =>
                                        cadernosRecord.where(
                                      'usuario',
                                      isEqualTo:
                                          libraryUsuariosRecord?.reference,
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
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<CadernosRecord>
                                        gridViewCadernosRecordList =
                                        snapshot.data!;

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16.0,
                                        mainAxisSpacing: 16.0,
                                        childAspectRatio: 0.85,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          gridViewCadernosRecordList.length,
                                      itemBuilder: (context, gridViewIndex) {
                                        final gridViewCadernosRecord =
                                            gridViewCadernosRecordList[
                                                gridViewIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            FFAppState().IdCadeno =
                                                gridViewCadernosRecord
                                                    .idCaderno;
                                            safeSetState(() {});

                                            context.pushNamed(
                                              MaterialsWidget.routeName,
                                              queryParameters: {
                                                'idCaderno': serializeParam(
                                                  gridViewCadernosRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration: Duration(
                                                      milliseconds: 400),
                                                ),
                                              },
                                            );
                                          },
                                          child: CardCardernoWidget(
                                            key: Key(
                                                'Keykq8_${gridViewIndex}_of_${gridViewCadernosRecordList.length}'),
                                            capa: gridViewCadernosRecord.capa,
                                            nomeMateria:
                                                gridViewCadernosRecord.nome,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
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
          ),
        );
      },
    );
  }
}
