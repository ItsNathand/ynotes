//HomeWork connector
//create a new client on the server where the homeworks are hosted.
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'SessionClient.dart';

class HwConnector {
  static HwClient? client;
  static getClient(Uri url) {
    if (client == null) {
      //create client with url
    }
    return client;
  }
}

class HwClient extends SessionClient {
  HwClient() : super(Map);
  init() {
    //print(this.get(Uri.parse('https://www.google.com/')));
    this.token = 'TokEN';
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? custom_headers,
      bool token = true,
      baseUrl = true}) async {
    Map<String, String>? headers = {};
//use a function to do the tricky thing to insert token
    return super.get(url, custom_headers: headers, baseUrl: baseUrl);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
      bool token = true,
      baseUrl = true}) async {
    Map<String, String>? headers = {};
//use a function to do the tricky thing to insert token
    return super.post(url, body: body, headers: headers, baseUrl: baseUrl);
  }
}
