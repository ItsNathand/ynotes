import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'SessionClient.dart';

class LVSClient extends SessionClient {
  HwClient? hw_client;

  Future<List> init(credentials) async {
    if (credentials['username'] is! String ||
        credentials['password'] is! String) {
      throw ('Lvs credentials username and password must be string');
    }
    if (credentials['url'] is! Uri) {
      throw ('Lvs credentials url must be Uri');
    }
    var data = {
      'login': credentials['username'],
      'password': credentials['password']
    };

    var rep = await this.post(
        Uri.parse(credentials['url'].toString() + '/vsn.main/WSAuth/connexion'),
        body: json.encode(data),
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

    return await super.get(url, headers: theheaders, baseUrl: baseUrl);
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
    return await super
        .post(url, body: body, headers: theheaders, baseUrl: baseUrl);
  }

  getHwClient() async {
//    if (this.hw_client == null || !this.hw_client!.started) {
    var theclient = new HwClient();
    await theclient.start({
      'method': this.get,
      'args': Uri.parse(
          '/vsn.main/WSMenu/getModuleUrl?mod=CDT&minuteEcartGMTClient=-120&add=123'),
      'named': {}
    });
    this.hw_client = theclient;
    // }
    return this.hw_client;
  }

  gett(uri) {
    super.get(Uri.parse('https://www.google.com/')).then((res) {
      print(res.body);
    });
  }
}

class HwClient extends SessionClient {
  HwClient() : super();
  Future<List> init(Map<String, dynamic> credentials) async {
    var entry_url =
        await Function.apply(credentials['method'], [credentials['args']]);

    print(jsonDecode(entry_url.body)['location']);
    Response redirect =
        await this.get(Uri.parse(jsonDecode(entry_url.body)['location']));
    print(redirect.statusCode);
    print(redirect.body);

    /* if (redirect.statusCode == 301 && redirect.headers['location'] != null) {
      String raw_token = redirect.headers['location']!;
      //exemple of raw_token: https://ent05.la-vie-scolaire.fr/eliot-textes/;jsessionid=562ECA43A24163DB05C49275126B7D86?extautolog=VS0bXcJU24VwfZe42ocMpyUuwBH5IhAEt%2FUTgbT%2BQ7hiRCKJlogcFLzuxzXRiXAIk09xNxrgJyr5%0AvvRoHZQZUTe6NnH6kG0a%2BU43wQgg8dxLpcM8BhoUP9MvFbCtleLNVgmgRqLet1%2F5mTrg2L8SkZty%0AdnnRfwcPLRFFWwE7wH%2FUfvX5NCSd9tPAlEubeTQEAWC%2F%2FXHqeGQCRMX%2BxNwgRdD%2BejfG6W6t90Ad%0A81w4pmivo9OV2X43%2Fi2dB6TheWIDyrywepUUrUTP3rNO8YE4B9IvQdRnIT0SVCXExS9lxCrB3kau%0AOgGnW%2FuIVGhN%2Fb%2Fy0HFgynrQ%2B3UsP%2BnJipJOjQ%3D%3D
      var debut = raw_token.indexOf(';');
      var end = raw_token.indexOf('?');
      var token = raw_token.substring(debut, end); */
    var token = 'mee';
    if (token != '') {
      this.token = token;
      print('successful authentication for Lvs Hw');
      return [1, "success"];
    }
    return [0, "invalid token for Lvs Hw"];
    // }
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
