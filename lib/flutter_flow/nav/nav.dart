import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? HomeWidget() : WelcomeWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? HomeWidget() : WelcomeWidget(),
        ),
        FFRoute(
          name: WelcomeWidget.routeName,
          path: WelcomeWidget.routePath,
          builder: (context, params) => WelcomeWidget(),
        ),
        FFRoute(
          name: AutenticationWidget.routeName,
          path: AutenticationWidget.routePath,
          builder: (context, params) => AutenticationWidget(),
        ),
        FFRoute(
          name: ForgotPasswordWidget.routeName,
          path: ForgotPasswordWidget.routePath,
          builder: (context, params) => ForgotPasswordWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => HomeWidget(),
        ),
        FFRoute(
          name: MarketplaceWidget.routeName,
          path: MarketplaceWidget.routePath,
          builder: (context, params) => MarketplaceWidget(),
        ),
        FFRoute(
          name: LibraryWidget.routeName,
          path: LibraryWidget.routePath,
          builder: (context, params) => LibraryWidget(),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => ProfileWidget(),
        ),
        FFRoute(
          name: MaterialsWidget.routeName,
          path: MaterialsWidget.routePath,
          builder: (context, params) => MaterialsWidget(
            idCaderno: params.getParam(
              'idCaderno',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['cadernos'],
            ),
          ),
        ),
        FFRoute(
          name: UserProfileWidget.routeName,
          path: UserProfileWidget.routePath,
          builder: (context, params) => UserProfileWidget(
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['usuarios'],
            ),
          ),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) => ChatWidget(
            userName: params.getParam(
              'userName',
              ParamType.String,
            ),
            chatUser: params.getParam(
              'chatUser',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chats'],
            ),
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['usuarios'],
            ),
            userProfile: params.getParam(
              'userProfile',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CommunityWidget.routeName,
          path: CommunityWidget.routePath,
          builder: (context, params) => CommunityWidget(),
        ),
        FFRoute(
          name: ChatsWidget.routeName,
          path: ChatsWidget.routePath,
          builder: (context, params) => ChatsWidget(),
        ),
        FFRoute(
          name: MaterialWidget.routeName,
          path: MaterialWidget.routePath,
          builder: (context, params) => MaterialWidget(),
        ),
        FFRoute(
          name: FinancesWidget.routeName,
          path: FinancesWidget.routePath,
          builder: (context, params) => FinancesWidget(),
        ),
        FFRoute(
          name: MarketplaceMaterialWidget.routeName,
          path: MarketplaceMaterialWidget.routePath,
          builder: (context, params) => MarketplaceMaterialWidget(
            product: params.getParam(
              'product',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['products'],
            ),
          ),
        ),
        FFRoute(
          name: ActionsFooterWidget.routeName,
          path: ActionsFooterWidget.routePath,
          builder: (context, params) => ActionsFooterWidget(),
        ),
        FFRoute(
          name: TasksWidget.routeName,
          path: TasksWidget.routePath,
          builder: (context, params) => TasksWidget(),
        ),
        FFRoute(
          name: CreateTaskWidget.routeName,
          path: CreateTaskWidget.routePath,
          builder: (context, params) => CreateTaskWidget(),
        ),
        FFRoute(
          name: EditDeleteTaskWidget.routeName,
          path: EditDeleteTaskWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditDeleteTaskWidget(
            taskReference: params.getParam(
              'taskReference',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['agenda'],
            ),
          ),
        ),
        FFRoute(
          name: AreaOfInterestWidget.routeName,
          path: AreaOfInterestWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AreaOfInterestWidget(),
        ),
        FFRoute(
          name: TypeTeachWidget.routeName,
          path: TypeTeachWidget.routePath,
          builder: (context, params) => TypeTeachWidget(),
        ),
        FFRoute(
          name: PersonPhotoWidget.routeName,
          path: PersonPhotoWidget.routePath,
          builder: (context, params) => PersonPhotoWidget(),
        ),
        FFRoute(
          name: CreateNotebookPageWidget.routeName,
          path: CreateNotebookPageWidget.routePath,
          builder: (context, params) => CreateNotebookPageWidget(),
        ),
        FFRoute(
          name: CreateMaterialPageWidget.routeName,
          path: CreateMaterialPageWidget.routePath,
          builder: (context, params) => CreateMaterialPageWidget(),
        ),
        FFRoute(
          name: CreatePostWidget.routeName,
          path: CreatePostWidget.routePath,
          builder: (context, params) => CreatePostWidget(),
        ),
        FFRoute(
          name: PostUserWidget.routeName,
          path: PostUserWidget.routePath,
          builder: (context, params) => PostUserWidget(
            postRef: params.getParam(
              'postRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['posts'],
            ),
          ),
        ),
        FFRoute(
          name: PostCommentPostWidget.routeName,
          path: PostCommentPostWidget.routePath,
          builder: (context, params) => PostCommentPostWidget(
            postRef: params.getParam(
              'postRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['posts'],
            ),
          ),
        ),
        FFRoute(
          name: ListLikesPostWidget.routeName,
          path: ListLikesPostWidget.routePath,
          builder: (context, params) => ListLikesPostWidget(
            postRef: params.getParam(
              'postRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['posts'],
            ),
          ),
        ),
        FFRoute(
          name: UserPostsWidget.routeName,
          path: UserPostsWidget.routePath,
          builder: (context, params) => UserPostsWidget(),
        ),
        FFRoute(
          name: DescriptionUserWidget.routeName,
          path: DescriptionUserWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DescriptionUserWidget(),
        ),
        FFRoute(
          name: NotificationsWidget.routeName,
          path: NotificationsWidget.routePath,
          builder: (context, params) => NotificationsWidget(),
        ),
        FFRoute(
          name: EditUserWidget.routeName,
          path: EditUserWidget.routePath,
          builder: (context, params) => EditUserWidget(),
        ),
        FFRoute(
          name: FollowingPageWidget.routeName,
          path: FollowingPageWidget.routePath,
          builder: (context, params) => FollowingPageWidget(),
        ),
        FFRoute(
          name: UserSettingsWidget.routeName,
          path: UserSettingsWidget.routePath,
          builder: (context, params) => UserSettingsWidget(),
        ),
        FFRoute(
          name: EditPasswordWidget.routeName,
          path: EditPasswordWidget.routePath,
          builder: (context, params) => EditPasswordWidget(),
        ),
        FFRoute(
          name: StreakWidget.routeName,
          path: StreakWidget.routePath,
          builder: (context, params) => StreakWidget(
            usuario: params.getParam(
              'usuario',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['usuarios'],
            ),
          ),
        ),
        FFRoute(
          name: HomeCopyWidget.routeName,
          path: HomeCopyWidget.routePath,
          builder: (context, params) => HomeCopyWidget(),
        ),
        FFRoute(
          name: ConfirmationPaymentWidget.routeName,
          path: ConfirmationPaymentWidget.routePath,
          builder: (context, params) => ConfirmationPaymentWidget(),
        ),
        FFRoute(
          name: StatusStripeAccountWidget.routeName,
          path: StatusStripeAccountWidget.routePath,
          builder: (context, params) => StatusStripeAccountWidget(
            statusAccount: params.getParam(
              'statusAccount',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: AllMaterialsWidget.routeName,
          path: AllMaterialsWidget.routePath,
          builder: (context, params) => AllMaterialsWidget(),
        ),
        FFRoute(
          name: CreateProductPageWidget.routeName,
          path: CreateProductPageWidget.routePath,
          builder: (context, params) => CreateProductPageWidget(),
        ),
        FFRoute(
          name: ProductCommentPostWidget.routeName,
          path: ProductCommentPostWidget.routePath,
          builder: (context, params) => ProductCommentPostWidget(
            productRef: params.getParam(
              'productRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['products'],
            ),
          ),
        ),
        FFRoute(
          name: AllMyProductsWidget.routeName,
          path: AllMyProductsWidget.routePath,
          builder: (context, params) => AllMyProductsWidget(),
        ),
        FFRoute(
          name: AllMyOrdersWidget.routeName,
          path: AllMyOrdersWidget.routePath,
          builder: (context, params) => AllMyOrdersWidget(),
        ),
        FFRoute(
          name: CancelPaymentWidget.routeName,
          path: CancelPaymentWidget.routePath,
          builder: (context, params) => CancelPaymentWidget(),
        ),
        FFRoute(
          name: TesteWidget.routeName,
          path: TesteWidget.routePath,
          builder: (context, params) => TesteWidget(),
        ),
        FFRoute(
          name: DrawingListPagWidget.routeName,
          path: DrawingListPagWidget.routePath,
          builder: (context, params) => DrawingListPagWidget(),
        ),
        FFRoute(
          name: EditorDesenhoWidget.routeName,
          path: EditorDesenhoWidget.routePath,
          builder: (context, params) => EditorDesenhoWidget(),
        ),
        FFRoute(
          name: ListaDesenhosWidget.routeName,
          path: ListaDesenhosWidget.routePath,
          builder: (context, params) => ListaDesenhosWidget(),
        ),
        FFRoute(
          name: DrawingEditorPagWidget.routeName,
          path: DrawingEditorPagWidget.routePath,
          builder: (context, params) => DrawingEditorPagWidget(
            drawingId: params.getParam(
              'drawingId',
              ParamType.String,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            pageType: params.getParam(
              'pageType',
              ParamType.String,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/welcome';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Imagem_do_WhatsApp_de_2025-04-07_(s)_20.30.31_60c3b942.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
