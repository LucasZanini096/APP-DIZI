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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> updateSteakUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final userRef =
      FirebaseFirestore.instance.collection('usuarios').doc(user.uid);
  final userSnapshot = await userRef.get();

  if (!userSnapshot.exists) return;

  final data = userSnapshot.data()!;
  final int streakAtual = data['actual_streak'] ?? 0;
  final Timestamp? ultimaAtividade = data['last_time_activity'];

  final DateTime hoje = DateTime.now();
  final DateTime hojeZerado = DateTime(hoje.year, hoje.month, hoje.day);

  int novaStreak = 1;
  bool atualizar = true;

  if (ultimaAtividade != null) {
    final DateTime ultima = ultimaAtividade.toDate();
    final DateTime ultimaZerada =
        DateTime(ultima.year, ultima.month, ultima.day);

    final int diffDias = hojeZerado.difference(ultimaZerada).inDays;

    if (diffDias == 0) {
      atualizar = false; // já atualizou hoje
      novaStreak = streakAtual;
    } else if (diffDias == 1) {
      novaStreak = streakAtual + 1;
    } else {
      novaStreak = 1;
    }
  }

  if (atualizar) {
    await userRef.update({
      'actual_streak': novaStreak,
      'last_time_activity': Timestamp.fromDate(hojeZerado),
    });
  }
}
