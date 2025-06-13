const admin = require("firebase-admin/app");
admin.initializeApp();

const cadastrarVendedorMercadoPago = require("./cadastrar_vendedor_mercado_pago.js");
exports.cadastrarVendedorMercadoPago =
  cadastrarVendedorMercadoPago.cadastrarVendedorMercadoPago;
