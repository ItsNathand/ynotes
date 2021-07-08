import 'package:ynotes/core/logic/shared/models.dart';

import 'package:ynotes/core/logic/schoolLife/models.dart';

import 'package:ynotes/core/logic/homework/models.dart';

import 'package:ynotes/core/logic/grades/models.dart';

import 'package:ynotes/core/logic/cloud/models.dart';

import 'package:ynotes/core/logic/agenda/models.dart';

import 'package:http/src/request.dart';
import 'package:ynotes/core/offline/offline.dart';

import 'Lvs/LvsClient.dart';
import 'model.dart';

class APILVS extends API {
  LVSClient client = new LVSClient();
  APILVS(Offline offlineController) : super(offlineController);

//make a function getClient()
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

    Map<String, dynamic> credentials = {
      'url': Uri.parse(
          'https://institutsaintpierresaintpaul28.la-vie-scolaire.fr'),
      'username': 'ndemers',
      'password': 'Matcha27@'
    };

    var res = await this.client.start(credentials);
    if (res[0] == 1) {
      return ([1, "Bienvenue!" + username]);
    }
    return [0, "Erreur"];
    //var dateTimeFormat = DateFormat('MMMM d, yyyy', 'en_US').parse(date);
    //  dateTimeFormat.millisecondsSinceEpoch;

//  await storage.write(key: "appAccount", value: jsonEncode(appSys.account!.toJson()));
//debug S

    /*      final prefs = await SharedPreferences.getInstance();


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
    //return ([1, "Bienvenue!" + username]);
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
