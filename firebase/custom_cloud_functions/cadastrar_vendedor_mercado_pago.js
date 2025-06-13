// Funções para integração com Mercado Pago Marketplace
// Implementação para Firebase Cloud Functions

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const mercadopago = require("mercadopago");
const cors = require("cors")({ origin: true });

// Inicializar Firebase Admin (se ainda não inicializado)
if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

exports.cadastrarVendedorMercadoPago = functions.https.onCall(
  async (data, context) => {
    // Verificar autenticação
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "É necessário estar autenticado para realizar esta operação.",
      );
    }

    try {
      // Configurar o SDK do Mercado Pago com o Access Token da plataforma
      mercadopago.configure({
        access_token: process.env.MERCADO_PAGO_ACCESS_TOKEN,
      });

      // Dados do vendedor
      const { userId, email, nome, sobrenome, tipo, cpfCnpj, telefone } = data;

      // Verificar se os dados necessários foram fornecidos
      if (!userId || !email || !nome || !cpfCnpj) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "Dados obrigatórios não fornecidos.",
        );
      }

      // Verificar se o vendedor já existe
      const vendorRef = db.collection("vendedores").doc(userId);
      const vendorDoc = await vendorRef.get();

      if (vendorDoc.exists && vendorDoc.data().mercadoPagoUserId) {
        return {
          success: true,
          userId: vendorDoc.data().mercadoPagoUserId,
          message: "Vendedor já cadastrado no Mercado Pago",
          isExistingAccount: true,
        };
      }

      // Criar usuário no Mercado Pago
      const userData = {
        email: email,
        first_name: nome,
        last_name: sobrenome || "",
        identification: {
          type: tipo === "fisica" ? "CPF" : "CNPJ",
          number: cpfCnpj.replace(/[^0-9]/g, ""), // Remove caracteres não numéricos
        },
        phone: {
          area_code: telefone.substring(0, 2),
          number: telefone.substring(2).replace(/[^0-9]/g, ""),
        },
      };

      // Chamada à API do Mercado Pago para criar o usuário
      const response = await mercadopago.users.create(userData);

      if (!response || !response.id) {
        throw new functions.https.HttpsError(
          "internal",
          "Erro ao criar usuário no Mercado Pago.",
        );
      }

      // Salvar informações no Firestore
      await vendorRef.set(
        {
          userId: userId,
          email: email,
          nome: nome,
          sobrenome: sobrenome,
          cpfCnpj: cpfCnpj,
          telefone: telefone,
          mercadoPagoUserId: response.id,
          status: "pendente",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

      // Gerar link de onboarding para credenciais de vendedor (OAuth)
      const authUrl = `https://auth.mercadopago.com.br/authorization?client_id=${process.env.MERCADO_PAGO_CLIENT_ID}&response_type=code&platform_id=mp&redirect_uri=${encodeURIComponent(process.env.MERCADO_PAGO_REDIRECT_URI)}`;

      return {
        success: true,
        userId: response.id,
        authorizationUrl: authUrl,
        message:
          "Vendedor cadastrado com sucesso. Complete o processo de autorização.",
      };
    } catch (error) {
      console.error("Erro ao cadastrar vendedor no Mercado Pago:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Erro ao cadastrar vendedor: ${error.message}`,
      );
    }
  },
);
