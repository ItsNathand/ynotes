import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ynotes/core/logic/shared/models.dart';

import 'package:ynotes/core/logic/schoolLife/models.dart';

import 'package:ynotes/core/logic/homework/models.dart';

import 'package:ynotes/core/logic/grades/models.dart';

import 'package:ynotes/core/logic/cloud/models.dart';

import 'package:ynotes/core/logic/agenda/models.dart';

import 'package:http/src/request.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'package:ynotes/globals.dart';

import 'Lvs/LvsClient.dart';
import 'Lvs/converters/account.dart';
import 'model.dart';

final storage = new FlutterSecureStorage();

void createStorage(String key, String? data) async {
  await storage.write(key: key, value: data);
}

class APILVS extends API {
  LVSClient client = new LVSClient();
  APILVS(Offline offlineController) : super(offlineController);

//make a function getClient()
  @override
  Future<List> login(username, password, {url, cas, mobileCasLogin}) async {
    print(username);
    if (username == null) {
      username = "";
    }
    if (password == null) {
      password = "";
    }
    if (url == null) {
      url = "";
    }

    //TODO:Remove dev thing under
    //  username = 'ndemers';
    // password = 'Matcha27@';
    url = 'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr';

    Map<String, dynamic> credentials = {
      'url': Uri.parse(url),
      'username': username,
      'password': password
    };

    //TODO:Update dev thing under
    List res = await this.client.start(credentials);
    //List res = [1];

    if (res[0] == 1) {
      try {
        //TODO:Update dev thing under
        var req_infos = await this
            .client
            .get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));

        Map<String, dynamic> raw_infos = jsonDecode(req_infos.body);
        /* Map<String, dynamic> raw_infos = {
          "infoUser": {
            "logo":
                "https://institutsaintpierresaintpaul28.la-vie-scolaire.fr/vsn.main/WSMenu/logo",
            "etabName": "Institut Saint Pierre Saint Paul - Dreux (28100)",
            "userPrenom": "Nathan",
            "userNom": "DEMERS",
            "profil": "Elève"
          },
          "plateform": ""
        }; */

        var ress = LvsAccountConverter.account(raw_infos);
        print(ress.surname);
        print(ress.name);
        print(ress.managableAccounts![0].availableTabs);

        appSys.account = LvsAccountConverter.account(raw_infos);
        if (appSys.account != null &&
            appSys.account!.managableAccounts != null) {
          await storage.write(
              key: "appAccount", value: jsonEncode(appSys.account!.toJson()));
          appSys.currentSchoolAccount = appSys.account!.managableAccounts![0];
        } else {
          return [0, "Impossible de collecter les comptes."];
        }
        createStorage("password", password ?? "");
        createStorage("username", username ?? "");
        this.loggedIn = true;

        await this.client.getHwClient();
        return ([1, "Bienvenue ${appSys.account?.name ?? "Invité"}!"]);
      } catch (e) {
        print('An error occured while registering the account');
      }
      return [
        0,
        "Erreur à l'inscription du compte. Seuls les comptes élèves sont supportés."
      ];
    }
    return [0, "Erreur à la connection"];
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

    throw UnimplementedError();
  }

  @override
  Future<List<Homework>?> getHomeworkFor(DateTime? dateHomework,
      {bool? forceReload}) async {
    // TODO: implement getHomeworkFor

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
