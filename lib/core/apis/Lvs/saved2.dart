import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'SessionClient.dart';

class LVSClient extends SessionClient {
  HwClient? hw_client;

  init(credentials) async {
    if (credentials['username'] is String ||
        !credentials['password'] is String) {
      // throw ('Lvs credentials must be string');
    }
    var map = {'login': 'ndemers', 'password': 'Matcha27@'};
    map['login'] = 'ndemers';
    map['password'] = 'Matcha27@';
    map = {'login': 'ndemers', 'password': 'Matcha27@'};
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

  getHwClient() {
    if (this.hw_client == null || !this.hw_client!.started) {
      var theclient = new HwClient();
      theclient.start({'method': this.get, 'pos': 'url', 'named': {}});
      this.hw_client = theclient;
    }
    return this.hw_client;
  }
}

class HwClient extends SessionClient {
  HwClient() : super();
  init(credentials) async {
    String entry_url = await Function.apply(
            credentials['method'], [credentials['pos']], credentials['named'])
        .data
        .location;
    Response redirect = await this.get(Uri.parse(entry_url));
    String raw_token = redirect.headers['location']!;
    //exemple of token: https://ent05.la-vie-scolaire.fr/eliot-textes/;jsessionid=562ECA43A24163DB05C49275126B7D86?extautolog=VS0bXcJU24VwfZe42ocMpyUuwBH5IhAEt%2FUTgbT%2BQ7hiRCKJlogcFLzuxzXRiXAIk09xNxrgJyr5%0AvvRoHZQZUTe6NnH6kG0a%2BU43wQgg8dxLpcM8BhoUP9MvFbCtleLNVgmgRqLet1%2F5mTrg2L8SkZty%0AdnnRfwcPLRFFWwE7wH%2FUfvX5NCSd9tPAlEubeTQEAWC%2F%2FXHqeGQCRMX%2BxNwgRdD%2BejfG6W6t90Ad%0A81w4pmivo9OV2X43%2Fi2dB6TheWIDyrywepUUrUTP3rNO8YE4B9IvQdRnIT0SVCXExS9lxCrB3kau%0AOgGnW%2FuIVGhN%2Fb%2Fy0HFgynrQ%2B3UsP%2BnJipJOjQ%3D%3D
    var debut = raw_token.indexOf(';');
    var end = raw_token.indexOf('?');
    this.token = raw_token.substring(debut, end);
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
      String requrl = url.toString();
      url = Uri.parse(requrl + thetoken);
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
    Map<String, String>? headers = {};
    if (token) {
      var thetoken = await this.getToken();
      if (thetoken == '') {
        return http.Response('', 401);
      }
      String requrl = url.toString();
      url = Uri.parse(requrl + thetoken);
    }
    return super.post(url, body: body, headers: headers, baseUrl: baseUrl);
  }
}
