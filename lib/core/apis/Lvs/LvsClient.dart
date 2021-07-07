import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SessionClient.dart';

class LVSClient extends SessionClient {
  //get devoir client{
  //if not started start it}

  init(credentials) async {
    var map = new Map<String, dynamic>();
    map['login'] = 'ndemers';
    map['password'] = 'Matcha27@';
    map['institut'] =
        'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr';
    var rep = await this.post(
        Uri.parse(
            'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/WSAuth/connexion'),
        body: json.encode(map),
        headers: {"Content-Type": "application/json"},
        token: false,
        baseUrl: false);
    print(rep.body);
    if (rep.statusCode == 200) {
      print('successful authentication for Lvs');
      this.token = rep.headers['set-cookie'].toString();
      this.base_url =
          'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr';
      return [1, "success"];
    }
    return [0, "error"];
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? headers, bool token = true, baseUrl = true}) async {
    Map<String, String>? theheaders = {};

    if (token) {
      var thetoken = await this.getToken();
      if (thetoken == '') {
        return http.Response('', 401);
      }
      thetoken = thetoken.replaceAll(RegExp(r','), ';');
      theheaders["Cookie"] = thetoken;
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
      var thetoken = await this.getToken();
      if (thetoken == '') {
        return http.Response('', 401);
      }
      thetoken = thetoken.replaceAll(RegExp(r','), ';');
      theheaders["Cookie"] = thetoken;
    }

    if (headers == Map) {
      theheaders.addAll(headers!);
    }
    return super.post(url, body: body, headers: theheaders, baseUrl: baseUrl);
  }
}
