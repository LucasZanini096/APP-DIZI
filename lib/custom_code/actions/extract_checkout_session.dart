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

Future<dynamic> extractCheckoutSession(
  BuildContext context,
  dynamic apiResult,
) async {
  try {
    // Verificar se o resultado da API não é nulo
    if (apiResult == null) {
      return {
        'success': false,
        'message': 'Resposta da API vazia',
        'error': 'NULL_RESPONSE',
      };
    }

    print('API Result recebido: $apiResult');
    print('Tipo do API Result: ${apiResult.runtimeType}');

    // Verificar se a operação foi bem-sucedida
    final bool success = apiResult['success'] ?? false;
    print('Success status: $success');

    if (success) {
      // Extrair dados da sessão de checkout
      final String sessionId = apiResult['sessionId'] ?? '';
      final String checkoutUrl = apiResult['checkoutUrl'] ?? '';
      final String expiresAt = apiResult['expiresAt'] ?? '';

      print('Session ID: $sessionId');
      print('Checkout URL: $checkoutUrl');
      print('Expires At: $expiresAt');

      // Validar se os campos essenciais estão presentes
      if (sessionId.isEmpty || checkoutUrl.isEmpty) {
        return {
          'success': false,
          'message': 'Dados da sessão incompletos',
          'error': 'INCOMPLETE_SESSION_DATA',
          'details': {
            'sessionId': sessionId,
            'checkoutUrl': checkoutUrl,
          },
        };
      }

      // Opcionalmente, salvar dados importantes no App State
      FFAppState().checkoutUrl = checkoutUrl;
      // FFAppState().lastSessionId = sessionId;

      // Retornar dados estruturados de sucesso
      return {
        'success': true,
        'sessionId': sessionId,
        'checkoutUrl': checkoutUrl,
        'expiresAt': expiresAt,
        'message': 'Sessão de checkout criada com sucesso! ID: $sessionId',
        'canProceedToCheckout': true,
        'rawResponse': apiResult,
      };
    } else {
      // Tratar erro retornado pela API
      final String errorMessage =
          apiResult['message'] ?? 'Erro desconhecido da API';
      final String errorType = apiResult['error'] ?? 'API_ERROR';
      final int statusCode = apiResult['statusCode'] ?? 0;

      print('Erro da API: $errorMessage');
      print('Tipo do erro: $errorType');
      print('Status Code: $statusCode');

      // Mapear mensagens de erro mais amigáveis
      String friendlyMessage = errorMessage;

      if (errorMessage
          .contains('Conta Stripe ainda não pode receber pagamentos')) {
        friendlyMessage =
            'O vendedor ainda não completou o cadastro no Stripe. Tente novamente mais tarde.';
      } else if (errorMessage.contains('Conta Stripe Connect não encontrada')) {
        friendlyMessage =
            'Vendedor não encontrado. Verifique se o link está correto.';
      } else if (errorMessage
          .contains('productId e stripeAccountId são obrigatórios')) {
        friendlyMessage = 'Erro interno: dados do produto incompletos.';
      }

      return {
        'success': false,
        'message': friendlyMessage,
        'originalMessage': errorMessage,
        'error': errorType,
        'statusCode': statusCode,
        'canProceedToCheckout': false,
        'rawResponse': apiResult,
      };
    }
  } catch (e) {
    // Tratar erros inesperados
    print('Erro inesperado ao processar resultado da API: $e');

    String errorMessage = 'Erro inesperado ao processar resposta';
    String errorType = 'PROCESSING_ERROR';

    // Identificar tipos de erro específicos
    final String errorString = e.toString().toLowerCase();

    if (errorString.contains('type') && errorString.contains('null')) {
      errorMessage = 'Formato de resposta inválido';
      errorType = 'INVALID_RESPONSE_FORMAT';
    } else if (errorString.contains('json')) {
      errorMessage = 'Erro ao processar dados da resposta';
      errorType = 'JSON_PROCESSING_ERROR';
    }

    return {
      'success': false,
      'message': errorMessage,
      'error': errorType,
      'details': e.toString(),
      'canProceedToCheckout': false,
    };
  }
}
