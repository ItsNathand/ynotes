import 'dart:convert';

import 'package:ynotes/core/logic/shared/models.dart';

import 'package:ynotes/core/logic/schoolLife/models.dart';

import 'package:ynotes/core/logic/homework/models.dart';

import 'package:ynotes/core/logic/grades/models.dart';

import 'package:ynotes/core/logic/cloud/models.dart';

import 'package:ynotes/core/logic/agenda/models.dart';

import 'package:http/http.dart' as http;
import 'package:http/src/request.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'package:ynotes/globals.dart';

import 'Lvs/SessionClient.dart';
import 'model.dart';

class APILVS extends API {
  APILVS(Offline offlineController) : super(offlineController);

  late LVSClient client;

  @override
  Future<List> login(username, password, {url, cas, mobileCasLogin}) async {
    var c = new LVSClient('me');
    c.init();
    //create appSys.account
    print(appSys.account);
//  await storage.write(key: "appAccount", value: jsonEncode(appSys.account!.toJson()));
//debug S

    // TODO: implement login
    /*      final prefs = await SharedPreferences.getInstance();
    if (username == null) {
      username = "";
    }
    if (password == null) {
      password = "";
    }

    var url = 'https://api.ecoledirecte.com/v3/login.awp';
    Map<String, String> headers = {"Content-type": "text/plain"};
    String data = 'data={"identifiant": "$username", "motdepasse": "$password"}';
    //encode Map to JSON
    var body = data;
    //var response = await http.post(Uri.parse(url), headers: headers, body: body).catchError((e) {
    // throw "Impossible de se connecter. Essayez de vérifier votre connexion à Internet ou réessayez plus tard.";
    //});
    response.statusCode = 200;
    if (response.statusCode == 200) {
      Map<String, dynamic> req = jsonDecode(response.body);
      if (req['code'] == 200) {
        try {
          //we register accounts
          //Put the value of the name in a variable
          //
          try {
            appSys.account = EcoleDirecteAccountConverter.account(req);
          } catch (e) {
            print("Impossible to get accounts " + e.toString());
            print(e);
          }

          if (appSys.account != null && appSys.account!.managableAccounts != null) {
            await storage.write(key: "appAccount", value: jsonEncode(appSys.account!.toJson()));
            appSys.currentSchoolAccount = appSys.account!.managableAccounts![0];
          } else {
            return [0, "Impossible de collecter les comptes."];
          }

          String userID = req['data']['accounts'][0]['id'].toString();
          String classe;
          try {
            classe = req['data']['accounts'][0]['profile']["classe"]["libelle"] ?? "";
          } catch (e) {
            classe = "";
          }
          //Store the token
          token = req['token'];
          //Create secure storage for credentials

          createStorage("password", password ?? "");
          createStorage("username", username ?? "");
          //IMPORTANT ! store the user ID
          createStorage("userID", userID);
          createStorage("classe", classe);
          //random date
          createStorage("startday", DateTime.parse("2020-02-02").toString());

          //Ensure that the user will not see the carousel anymore
          prefs.setBool('firstUse', false);
        } catch (e) {
          print("Error while getting user info " + e.toString());
          //log in file
          logFile(e.toString());
        }
        this.loggedIn = true;
        return [1, "Bienvenue ${appSys.account?.name ?? "Invité"} !"];
      }
      //Return an error
      else {
        String? message = req['message'];
        return [0, "Oups ! Une erreur a eu lieu :\n$message"];
      }
    } else {
      return [0, "Erreur"];
    } */
    return ([1, "Bienvenue!" + username]);
  }

  @override
  Future<List> apiStatus() async {
    return [1, "Pas de problème connu."];
  }

  @override
  app(String appname, {String? args, String? action, CloudItem? folder}) {
    switch (appname) {
    }
    ;
  }

  @override
  Future<Request> downloadRequest(Document document) async {
    //TODO: implement downloadRequest
    //I will take care of this function later on.
    return new Request('GET', Uri.parse(''));
  }

  @override
  Future<List<DateTime>?> getDatesNextHomework() async {
    // TODO: implement getDatesNextHomework
    throw UnimplementedError();
  }

  @override
  Future<List<Discipline>?> getGrades({bool? forceReload}) async {
    // TODO: implement getGrades
    print('oops');
    throw UnimplementedError();
  }

  @override
  Future<List<Homework>?> getHomeworkFor(DateTime? dateHomework,
      {bool? forceReload}) async {
    // TODO: implement getHomeworkFor
    print('oops');
    // throw UnimplementedError();
    return [];
  }

  @override
  Future<List<Homework>?> getNextHomework({bool? forceReload}) async {
    account().then((value) => {print(value)});
    // throw UnimplementedError();
    return [];
  }

  @override
  Future<List<Lesson>?> getNextLessons(DateTime from,
      {bool? forceReload}) async {
    // TODO: implement getNextLessons
    throw UnimplementedError();
  }

  @override
  Future<List<SchoolLifeTicket>?> getSchoolLife(
      {bool forceReload = false}) async {
    // TODO: implement getSchoolLife
    throw UnimplementedError();
  }

  @override
  Future<bool?> testNewGrades() async {
    // TODO: implement testNewGrades
    return (true);
  }

  @override
  Future uploadFile(String context, String id, String filepath) async {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }
}

class LVSClient extends SessionClient {
  LVSClient(crendentials) : super(crendentials);
  init() async {
    print('meee');
    var map = new Map<String, dynamic>();
    map['login'] = 'ndemers';
    map['password'] = 'Matcha27@';
    map['institut'] =
        'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr';
    http.post(
        Uri.parse(
            'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/WSAuth/connexion'),
        body: json.encode(map),
        headers: {
          // 'Cookie': 'JSESSIONID=26EE54DEAE11E85EC4535FDAA534ED83-m2',
          "Content-Type": "application/json"
        }).then((rep) {
      print(rep.statusCode);
      print(rep.request);
      print(rep.body);
      print(rep.request?.headers);
      print(rep.headers);
    });
    //  this.post(Uri.parse('/login'));
    this.token = 'define token';
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? custom_headers,
      bool token = true,
      baseUrl = true}) async {
    Map<String, String>? headers = {};
    if (token) {
      headers = {'JWT': this.getToken()};
    }
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
    if (token) {
      headers = {'JWT': this.getToken()};
    }
    return super.post(url, body: body, headers: headers, baseUrl: baseUrl);
  }
}
