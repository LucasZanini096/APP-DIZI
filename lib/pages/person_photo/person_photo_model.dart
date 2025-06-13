import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'person_photo_widget.dart' show PersonPhotoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PersonPhotoModel extends FlutterFlowModel<PersonPhotoWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadData5ej = false;
  FFUploadedFile uploadedLocalFile_uploadData5ej =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_uploadDataX07 = false;
  FFUploadedFile uploadedLocalFile_uploadDataX07 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataX07 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
