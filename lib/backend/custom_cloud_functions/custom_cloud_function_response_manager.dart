import '/backend/schema/structs/index.dart';

class CadastrarVendedorMercadoPagoCloudFunctionCallResponse {
  CadastrarVendedorMercadoPagoCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
