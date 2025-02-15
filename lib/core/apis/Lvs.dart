import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ynotes/core/apis/Lvs/LvsMethods.dart';
import 'package:ynotes/core/logic/shared/models.dart';

import 'package:ynotes/core/logic/schoolLife/models.dart';

import 'package:ynotes/core/logic/homework/models.dart';

import 'package:ynotes/core/logic/grades/models.dart';

import 'package:ynotes/core/logic/cloud/models.dart';

import 'package:ynotes/core/logic/agenda/models.dart';

import 'package:http/src/request.dart';
import 'package:ynotes/core/offline/data/homework/homework.dart';
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
  LvsClient client = LvsClient();
  APILVS(Offline offlineController) : super(offlineController);

  @override
  Future<List> login(username, password, {url, cas, mobileCasLogin}) async {
    if (username == null) {
      username = "";
    }
    if (password == null) {
      password = "";
    }
    if (url == null) {
      url = "";
    }

    url = 'https://ajouterinstitut.la-vie-scolaire.fr';

    Map<String, dynamic> credentials = {
      'url': Uri.parse(url),
      'username': username,
      'password': password
    };

    List res = await this.client.start(credentials);

    if (res[0] == 1) {
      try {
        var req_infos = await this
            .client
            .get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));

        Map<String, dynamic> raw_infos = jsonDecode(req_infos.body);

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
        return ([1, "Bienvenue ${appSys.account?.name ?? "Invité"}!"]);
      } catch (e) {
        print(
            'An error occured while registering the account: ' + e.toString());
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
  Future<List<Homework>?> getHomeworkFor(DateTime? dateHomework,
      {bool? forceReload}) async {
    return await fetch(
        () async => LvsMethods(await this.getClient(), this.offlineController)
            .homeworkFor(DateTime(2005)),
        () async =>
            HomeworkOffline(offlineController).getHomeworkFor(dateHomework!),
        forceFetch: forceReload ?? false);
  }

  @override
  Future<List<Homework>?> getNextHomework({bool? forceReload}) async {
    return await fetch(
        () async => LvsMethods(await this.getClient(), this.offlineController)
            .nextHomework(),
        () => HomeworkOffline(offlineController).getAllHomework(),
        forceFetch: forceReload ?? false);
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

  getClient() async {
    if (!this.client.started) {
      throw ('Client is called but not started.');
    }
    return this.client;
  }
  //the under is not bad but it's not working as it should be, we'll see that later
  /* if (!this.client.started) {
      appSys.api!.loggedIn == false;
      await appSys.loginController.init();
    }
    return this.client; 
  } */
}
