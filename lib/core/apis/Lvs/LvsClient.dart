import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SessionClient.dart';

class LVSClient extends SessionClient {
  LVSClient(crendentials) : super(crendentials);
  init() async {
    var map = new Map<String, dynamic>();
    map['login'] = '';
    map['password'] = '';
    map['institut'] = 'https://institut.la-vie-scolaire.fr';
    var rep = await this.post(
        Uri.parse(
            'https://institut.la-vie-scolaire.fr/vsn.main/WSAuth/connexion'),
        body: json.encode(map),
        headers: {"Content-Type": "application/json"},
        token: false);
    if (rep.statusCode == 200) {
      print('successful authentication for Lvs');
      this.token = rep.headers['set-cookie'].toString();
      this.base_url = 'https://institut.la-vie-scolaire.fr';
      return [1, "success"];
    }
    print('failed authentication for Lvs');
    return [0, "failed"];
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? headers, bool token = true, baseUrl = true}) async {
    Map<String, String>? theheaders = {};
    if (token) {
      theheaders = {'JWT': await this.getToken()};
    }
    if (headers == Map) {
      theheaders.addAll(headers!);
    }
    return super.get(url, headers: theheaders, baseUrl: baseUrl);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
      bool token = true,
      baseUrl = true}) async {
    Map<String, String>? theheaders = {};
    if (token) {
      theheaders = {'JWT': await this.getToken()};
    }
    if (headers == Map) {
      theheaders.addAll(headers!);
    }
    return super.post(url, body: body, headers: headers, baseUrl: baseUrl);
  }
}
