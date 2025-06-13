import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/card_materia2/card_materia2_widget.dart';
import '/components/footer_bar/footer_bar_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'all_materials_model.dart';
export 'all_materials_model.dart';

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
class AllMaterialsWidget extends StatefulWidget {
  const AllMaterialsWidget({super.key});

  static String routeName = 'AllMaterials';
  static String routePath = '/allMaterials';

  @override
  State<AllMaterialsWidget> createState() => _AllMaterialsWidgetState();
}

class _AllMaterialsWidgetState extends State<AllMaterialsWidget> {
  late AllMaterialsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllMaterialsModel());

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
        List<UsuariosRecord> allMaterialsUsuariosRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final allMaterialsUsuariosRecord =
            allMaterialsUsuariosRecordList.isNotEmpty
                ? allMaterialsUsuariosRecordList.first
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
                          photoUrl: allMaterialsUsuariosRecord!.photoUrl,
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
                                    'Selecione um material',
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: StreamBuilder<List<MateriaisNovoRecord>>(
                                stream: queryMateriaisNovoRecord(
                                  queryBuilder: (materiaisNovoRecord) =>
                                      materiaisNovoRecord.where(
                                    'criador',
                                    isEqualTo:
                                        allMaterialsUsuariosRecord?.reference,
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
                                  List<MateriaisNovoRecord>
                                      gridViewMateriaisNovoRecordList =
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
                                        gridViewMateriaisNovoRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewMateriaisNovoRecord =
                                          gridViewMateriaisNovoRecordList[
                                              gridViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          FFAppState().setMaterialProductRef =
                                              gridViewMateriaisNovoRecord
                                                  .reference;
                                          safeSetState(() {});

                                          context.pushNamed(
                                              CreateProductPageWidget
                                                  .routeName);
                                        },
                                        child: CardMateria2Widget(
                                          key: Key(
                                              'Keylmt_${gridViewIndex}_of_${gridViewMateriaisNovoRecordList.length}'),
                                          capaMaterial:
                                              gridViewMateriaisNovoRecord
                                                  .capaMaterial,
                                          nomeMaterial:
                                              gridViewMateriaisNovoRecord.nome,
                                          caderno: gridViewMateriaisNovoRecord
                                              .caderno!,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
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
