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

Future<dynamic> extractAccountStripeInfo(
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

    // Extrair apenas os campos principais
    return {
      'success': true,
      'statusCode': apiResult.statusCode,
      'accountId': apiResult['accountId'],
      'email': apiResult['email'],
      'country': apiResult['country'],
      'businessType': apiResult['business_type'],
      'accountType': apiResult['account_type'],
      'created': apiResult['created'],
      'canReceivePayments': apiResult['canReceivePayments'],
      'dashboardUrl': apiResult['dashboardUrl'],
      // Status detalhado
      'chargesEnabled': apiResult['status']['charges_enabled'],
      'detailsSubmitted': apiResult['status']['details_submitted'],
      'payoutsEnabled': apiResult['status']['payouts_enabled'],
      // Todo o objeto de resposta para casos de uso avançados
      'rawResponse': apiResult,

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
