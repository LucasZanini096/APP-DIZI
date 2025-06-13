import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _feelingToday = prefs.getString('ff_feelingToday') ?? _feelingToday;
    });
    _safeInit(() {
      _numberNotifications =
          prefs.getInt('ff_numberNotifications') ?? _numberNotifications;
    });
    _safeInit(() {
      _lastDayUpdateFellingToday =
          prefs.containsKey('ff_lastDayUpdateFellingToday')
              ? DateTime.fromMillisecondsSinceEpoch(
                  prefs.getInt('ff_lastDayUpdateFellingToday')!)
              : _lastDayUpdateFellingToday;
    });
    _safeInit(() {
      _idAccountStripe =
          prefs.getString('ff_idAccountStripe') ?? _idAccountStripe;
    });
    _safeInit(() {
      _onboardingUrl = prefs.getString('ff_onboardingUrl') ?? _onboardingUrl;
    });
    _safeInit(() {
      _paymentEnable = prefs.getBool('ff_paymentEnable') ?? _paymentEnable;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _CoverImageNotebookUrl = '';
  String get CoverImageNotebookUrl => _CoverImageNotebookUrl;
  set CoverImageNotebookUrl(String value) {
    _CoverImageNotebookUrl = value;
  }

  String _IdCadeno = '';
  String get IdCadeno => _IdCadeno;
  set IdCadeno(String value) {
    _IdCadeno = value;
  }

  DocumentReference? _CadernoReference;
  DocumentReference? get CadernoReference => _CadernoReference;
  set CadernoReference(DocumentReference? value) {
    _CadernoReference = value;
  }

  String _UpdateImageCover = '';
  String get UpdateImageCover => _UpdateImageCover;
  set UpdateImageCover(String value) {
    _UpdateImageCover = value;
  }

  String _CoverImageMaterialUrl = '';
  String get CoverImageMaterialUrl => _CoverImageMaterialUrl;
  set CoverImageMaterialUrl(String value) {
    _CoverImageMaterialUrl = value;
  }

  DocumentReference? _material;
  DocumentReference? get material => _material;
  set material(DocumentReference? value) {
    _material = value;
  }

  DocumentReference? _userDocument;
  DocumentReference? get userDocument => _userDocument;
  set userDocument(DocumentReference? value) {
    _userDocument = value;
  }

  String _feelingToday = '';
  String get feelingToday => _feelingToday;
  set feelingToday(String value) {
    _feelingToday = value;
    prefs.setString('ff_feelingToday', value);
  }

  int _numberNotifications = 0;
  int get numberNotifications => _numberNotifications;
  set numberNotifications(int value) {
    _numberNotifications = value;
    prefs.setInt('ff_numberNotifications', value);
  }

  DateTime? _lastDayUpdateFellingToday;
  DateTime? get lastDayUpdateFellingToday => _lastDayUpdateFellingToday;
  set lastDayUpdateFellingToday(DateTime? value) {
    _lastDayUpdateFellingToday = value;
    value != null
        ? prefs.setInt(
            'ff_lastDayUpdateFellingToday', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastDayUpdateFellingToday');
  }

  DocumentReference? _setMaterialProductRef;
  DocumentReference? get setMaterialProductRef => _setMaterialProductRef;
  set setMaterialProductRef(DocumentReference? value) {
    _setMaterialProductRef = value;
  }

  String _idAccountStripe = '';
  String get idAccountStripe => _idAccountStripe;
  set idAccountStripe(String value) {
    _idAccountStripe = value;
    prefs.setString('ff_idAccountStripe', value);
  }

  String _onboardingUrl = '';
  String get onboardingUrl => _onboardingUrl;
  set onboardingUrl(String value) {
    _onboardingUrl = value;
    prefs.setString('ff_onboardingUrl', value);
  }

  bool _paymentEnable = false;
  bool get paymentEnable => _paymentEnable;
  set paymentEnable(bool value) {
    _paymentEnable = value;
    prefs.setBool('ff_paymentEnable', value);
  }

  String _checkoutUrl = '';
  String get checkoutUrl => _checkoutUrl;
  set checkoutUrl(String value) {
    _checkoutUrl = value;
  }

  String _currentDrawingId = '';
  String get currentDrawingId => _currentDrawingId;
  set currentDrawingId(String value) {
    _currentDrawingId = value;
  }

  String _currentDrawingTitle = '';
  String get currentDrawingTitle => _currentDrawingTitle;
  set currentDrawingTitle(String value) {
    _currentDrawingTitle = value;
  }

  List<String> _currentDrawingData = [];
  List<String> get currentDrawingData => _currentDrawingData;
  set currentDrawingData(List<String> value) {
    _currentDrawingData = value;
  }

  void addToCurrentDrawingData(String value) {
    currentDrawingData.add(value);
  }

  void removeFromCurrentDrawingData(String value) {
    currentDrawingData.remove(value);
  }

  void removeAtIndexFromCurrentDrawingData(int index) {
    currentDrawingData.removeAt(index);
  }

  void updateCurrentDrawingDataAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    currentDrawingData[index] = updateFn(_currentDrawingData[index]);
  }

  void insertAtIndexInCurrentDrawingData(int index, String value) {
    currentDrawingData.insert(index, value);
  }

  bool _hasUnsavedChanges = false;
  bool get hasUnsavedChanges => _hasUnsavedChanges;
  set hasUnsavedChanges(bool value) {
    _hasUnsavedChanges = value;
  }

  bool _autoSaveEnabled = false;
  bool get autoSaveEnabled => _autoSaveEnabled;
  set autoSaveEnabled(bool value) {
    _autoSaveEnabled = value;
  }

  int _autoSaveInterval = 0;
  int get autoSaveInterval => _autoSaveInterval;
  set autoSaveInterval(int value) {
    _autoSaveInterval = value;
  }

  DateTime? _lastSaved;
  DateTime? get lastSaved => _lastSaved;
  set lastSaved(DateTime? value) {
    _lastSaved = value;
  }

  DateTime? _lastAutoSave;
  DateTime? get lastAutoSave => _lastAutoSave;
  set lastAutoSave(DateTime? value) {
    _lastAutoSave = value;
  }

  List<String> _drawingCache = [];
  List<String> get drawingCache => _drawingCache;
  set drawingCache(List<String> value) {
    _drawingCache = value;
  }

  void addToDrawingCache(String value) {
    drawingCache.add(value);
  }

  void removeFromDrawingCache(String value) {
    drawingCache.remove(value);
  }

  void removeAtIndexFromDrawingCache(int index) {
    drawingCache.removeAt(index);
  }

  void updateDrawingCacheAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    drawingCache[index] = updateFn(_drawingCache[index]);
  }

  void insertAtIndexInDrawingCache(int index, String value) {
    drawingCache.insert(index, value);
  }

  DateTime? _lastCacheUpdate;
  DateTime? get lastCacheUpdate => _lastCacheUpdate;
  set lastCacheUpdate(DateTime? value) {
    _lastCacheUpdate = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
