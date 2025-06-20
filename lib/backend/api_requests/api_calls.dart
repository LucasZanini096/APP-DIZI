import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class CreateAccountCall {
  static Future<ApiCallResponse> call({
    String? email = 'user@example.com',
    String? uid = 'string',
    String? name = 'string',
    String? phone = 'string',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "country": "BR",
  "business_type": "individual",
  "uid": "${escapeStringForJson(uid)}",
  "name": "${escapeStringForJson(name)}",
  "phone": "${escapeStringForJson(phone)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createAccount',
      apiUrl:
          'https://api-stripe-delta.vercel.app/api/stripe/connect/create-account',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ConnectAccountStripeCall {
  static Future<ApiCallResponse> call({
    String? stripeAccountId = 'acct_',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'connectAccountStripe',
      apiUrl: 'https://api-stripe-delta.vercel.app/api/stripe/connect/status',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'stripeAccountId': stripeAccountId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateCheckoutSessionCall {
  static Future<ApiCallResponse> call({
    String? productId = '',
    String? stripeAccountId = '',
    String? name = '',
    double? price = 0.0,
    String? description = '',
    String? image = '',
    int? quantity = 1,
  }) async {
    final ffApiRequestBody = '''
{
  "productId": "${escapeStringForJson(productId)}",
  "stripeAccountId": "${escapeStringForJson(stripeAccountId)}",
  "name": "${escapeStringForJson(name)}",
  "price": "${price}",
  "description": "${escapeStringForJson(description)}",
  "image": "${escapeStringForJson(image)}",
  "quantity": 1
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createCheckoutSession',
      apiUrl:
          'https://api-stripe-delta.vercel.app/api/payments/create-checkout-session',
      callType: ApiCallType.POST,
      headers: {
        'Content-type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
