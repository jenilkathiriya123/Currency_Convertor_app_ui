import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Currency.dart';

class CurrencyHelper {
  CurrencyHelper._();

  static final CurrencyHelper currencyHelper = CurrencyHelper._();

  Future<Currency?> CurrencyData(
      {required String from, required String to, required int amount}) async {
    String api =
        "https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount";

    http.Response response = await http.get(
      Uri.parse(api),
    );
    if (response.statusCode == 200) {
      Map decodeddata = jsonDecode(response.body);
      Currency currency = Currency.fromMap(data: decodeddata);

      return currency;
    }
    return null;
  }
}
