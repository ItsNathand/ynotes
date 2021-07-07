import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SessionClient.dart';

class LVSClient extends SessionClient {
  //get devoir client{
  //if not started start it}

  init(credentials) async {
    http.get(
        Uri.parse(
            'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/WSAccueil/loadNotifications'),
        headers: {
          "Cookie":
              'JSESSIONID=8218FBB1F364EE6126A16CF78269B940-m1; _ga=GA1.2.2118368367.1592639563; JWT-LVS=eyJhbGciOiJIUzUxMiJ9.eyJ1aWQiOjY4MTIsInBpaSI6NiwicmdoIjpbIjEtMSIsIjMtMSIsIjYtMCIsIjgtMSIsIjEyLTAiLCIxMy0wIiwiMjItMSIsIjI2LTAiLCIzMC0wIiwiMzEtMCIsIjE0LTAiLCIzOS0wIiwiMjAtMSIsIjI0LTEiLCIyMy0xIiwiMTktMSIsIjM1LTAiLCIyNS0wIiwiNDUtMCIsIjQ2LTAiLCI0Ny0wIiwiNDMtMCIsIjQ0LTEiXSwiZXRhIjoiMTI2NDYiLCJpc3MiOiJsdnMzaXNzdWVyIiwiaXRmIjoiIiwicGlkIjoyNzUyLCJwaWMiOiJFTEVWRSIsImV4cCI6MTYyNTY0ODA3NCwicHJvIjoxLCJpYXQiOjE2MjU2NDQ0NzQsImVwaiI6IjEyNjQ2MDE2ODEyIn0.ZY06LyKNwdCt2zrEmAdbcSj34ExvgLDYMioqkPm1jZnY9Jk_RDyKS0KOEFiiBLZREztx639CuQEHHUa7zUl3vw',
          "Content-Type": "application/json"
        }).then((rep) {
      print('meee');
      print(rep.statusCode);
      print(rep.request);
      print(rep.body);
      print(rep.request?.headers);
      print(rep.headers);
    });

    /*   var re = await this.get(Uri.parse('https://www.google.com/'));
    print(re.statusCode);
    print(re.body);

    print('starttt');
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
        token: false);
    print(rep.body);
    if (rep.statusCode == 200) {
      print('successful authentication for Lvs');
      this.token = rep.headers['set-cookie'].toString();
      this.base_url = 'https://institut.la-vie-scolaire.fr';
      //  return [1, "success"];
    }
    Map<String, String> headers = {};
    headers["Cookie"] = "JSESSIONID=2F78F20A7696ECED7E87FCD280088C17-m3";
    var repp = await this.get(
        Uri.parse(
            'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/WSAccueil/loadNotifications'),
        headers: headers);
    print(repp.statusCode);
    print(repp.body);
    //  print('failed authentication for Lvs');
    //  return [0, "failed"];

    return [1, "success"]; */
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? headers, bool token = true, baseUrl = true}) async {
    Map<String, String>? theheaders = {};
    if (token) {
      var thetoken = await this.getToken();
      if (thetoken == '') {
        //  return http.Response('', 401);
      }
      // theheaders = {'Cookie': thetoken};
    }
    //if (headers == Map) {
    //  theheaders.addAll(headers!);
    // }
    return super.get(url, headers: headers, baseUrl: baseUrl);
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
        //return http.Response('', 401);
      }
      //theheaders = {'JWT': thetoken};
    }
    if (headers == Map) {
      theheaders.addAll(headers!);
    }
    return super.post(url, body: body, headers: headers, baseUrl: baseUrl);
  }
}
