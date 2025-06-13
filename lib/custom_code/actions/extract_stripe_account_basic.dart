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
//

Future<dynamic> extractStripeAccountBasic(
  BuildContext context,
  dynamic apiResult,
) async {
  try {
    if (apiResult == null) {
      return {
        'success': false,
        'message': 'Resposta da API vazia',
      };
    }

    // Atribui o valor da referência do onboarding ao App State
    FFAppState().onboardingUrl = apiResult['onboardingUrl'];

    // Atribui o valor da referência do onboarding ao App State
    FFAppState().idAccountStripe = apiResult['accountId'];

    // Extrair apenas os campos principais
    return {
      'success': apiResult['success'] ?? false,
      'accountId': apiResult['accountId'] ?? '',
      'onboardingUrl': apiResult['onboardingUrl'] ?? '',
      'message':
          'Conta criada com sucesso! ID: ${apiResult['accountId'] ?? 'N/A'}',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Erro: ${e.toString()}',
    };
  }
}
