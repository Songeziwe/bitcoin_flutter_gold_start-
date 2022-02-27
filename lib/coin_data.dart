import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'api_key';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<dynamic, dynamic> result = {
      cryptoList[0]: '?',
      cryptoList[1]: '?',
      cryptoList[2]: '?',
    };

    String requestURL;
    http.Response response;

    for (String crypto in cryptoList) {
      requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      response = await http.get(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        result[crypto] = lastPrice.round();
      } else {
        print('StatusCode: ${response.statusCode}');
        throw 'Problem with the get request';
      }
    }
    return result;
  }
}
