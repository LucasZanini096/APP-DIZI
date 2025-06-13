// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getDocReferenceNotebook(String docID) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String documentPath = "/cadernos/$docID"; // Caminho do documento
  DocumentReference documentReference = firestore.doc(documentPath);

  // Atribui o valor da referência de documento ao App State
  FFAppState().CadernoReference = documentReference;
}
