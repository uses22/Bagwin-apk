// lib/services/mobile_money/bagwin_money_service.dart

import 'package:bagwin/services/mobile_money/bagwin_crypto_util.dart';

class BagWinMoneyService {
  static const String _baseUrl = String.fromEnvironment('BAGWIN_MM_API_URL');
  static const String _encKey = String.fromEnvironment('BAGWIN_ENC_KEY');

  Future<bool> requestWithdrawal(double amount) async {
    try {
      final securePayload = BagWinCrypto.encrypt({
        'amount': amount,
        'currency': 'XAF',
        'timestamp': DateTime.now().toIso8601String(),
        'clientId': 'BAGWIN-${_generateSessionId()}'
      });

      final response = await BagWinApiClient.post(
        endpoint: '/withdraw',
        payload: securePayload,
        headers: _buildAuthHeaders()
      );

      return _processResponse(response);
    } catch (e, stack) {
      BagWinLogger.error('Withdrawal Failed', e, stack);
      rethrow;
    }
  }

  Map<String, String> _buildAuthHeaders() => {
    'X-BagWin-Version': '2025-1.0',
    'X-Request-Signature': BagWinCrypto.signRequest(_encKey),
    'Content-Type': 'application/bagwin-encrypted'
  };
}
