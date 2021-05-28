import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ynotes/core/apis/EcoleDirecte.dart';
import 'package:ynotes/core/apis/model.dart';
import 'package:ynotes/core/apis/utils.dart';
import 'package:ynotes/core/logic/appConfig/controller.dart';
import 'package:ynotes/core/logic/modelsExporter.dart';
import 'package:ynotes/core/services/notifications.dart';
import 'package:ynotes/globals.dart';
import 'package:ynotes/ui/screens/settings/sub_pages/logsPage.dart';
import 'package:ynotes/usefulMethods.dart';

//The main class for everything done in background
class BackgroundService {
//Background task when when app is closed
  static Future<void> backgroundFetchHeadlessTask(String a, {bool headless = false}) async {
    //await LocalNotification.showDebugNotification();
    try {
      print("Starting the headless closed bakground task");
      await AppNotification.showLoadingNotification(a.hashCode);
      if (headless) {
        appSys = ApplicationSystem();
        await appSys.initApp();
      }
      await logFile("Init appSys");
      if (!readLastFetchStatus(appSys)) {
        //we don't write the fetch status (because no one fetch has been executed)
        await logFile("Cancel background fetch.");
        return;
      }
      await writeLastFetchStatus(appSys);
//Ensure that grades notification are enabled and battery saver disabled
      if (appSys.settings!["user"]["global"]["notificationNewGrade"] &&
          !appSys.settings!["user"]["global"]["batterySaver"]) {
        await logFile("New grade test triggered");
        if (await testNewGrades()) {
          await AppNotification.showNewGradeNotification();
        } else {
          print("Nothing updated");
        }
      } else {
        print("New grade notification disabled");
      }
      if (appSys.settings!["user"]["global"]["notificationNewMail"] &&
          !appSys.settings!["user"]["global"]["batterySaver"]) {
        await logFile("New mail test triggered");

        Mail? mail = await testNewMails();
        if (mail != null) {
          String content = (await readMail(mail.id, mail.read, true)) ?? "";
          await AppNotification.showNewMailNotification(mail, content);
        } else {
          print("Nothing updated");
        }
      } else {
        print("New mail notification disabled");
      }
      if (appSys.settings!["user"]["agendaPage"]["agendaOnGoingNotification"]) {
        print("Setting On going notification");
        await AppNotification.setOnGoingNotification(dontShowActual: true);
      } else {
        print("On going notification disabled");
      }
      await logFile("Background fetch occured.");
      await AppNotification.cancelNotification(a.hashCode);
    } catch (e) {
      await AppNotification.cancelNotification(a.hashCode);
      await logFile("An error occured during the background fetch : " + e.toString());
    }
  }

  ///Allows fetch only if time delay since last fetch is greater or equal to 5 minutes
  static bool readLastFetchStatus(ApplicationSystem _appSys) {
    try {
      if (_appSys.settings?["system"]["lastFetchDate"] != null) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(_appSys.settings?["system"]["lastFetchDate"]);
        if (DateTime.now().difference(date).inMinutes >= 5) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      print("Error while reading fetch status " + e.toString());
      return false;
    }
  }

  ///Returns true if there are new grades
  static testNewGrades() async {
    try {
      //Get the old number of mails
      var oldGradesLength = appSys.settings!["system"]["lastGradeCount"];
      //Getting the offline count of grades
      //instanciate an offline controller read only
      await appSys.offline.init();
      API backgroundFetchApi = apiManager(appSys.offline);

      print("Old grades length is ${oldGradesLength}");
      //Getting the online count of grades

      List<Grade>? listOnlineGrades = [];
      //Login creds
      String? u = await readStorage("username");
      String? p = await readStorage("password");
      String? url = await readStorage("pronoteurl");
      String? cas = await readStorage("pronotecas");
      await backgroundFetchApi.login(u, p, url: url, cas: cas);
      listOnlineGrades = getAllGrades(await backgroundFetchApi.getGrades(forceReload: true), overrideLimit: true);

      print("Online grade length is ${listOnlineGrades!.length}");
      if (oldGradesLength != null && oldGradesLength != 0 && oldGradesLength < listOnlineGrades.length) {
        final prefs = await (SharedPreferences.getInstance());
        await prefs.setInt("gradesNumber", listOnlineGrades.length);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      await logFile("An error occured during the new grades test : " + e.toString());
      return false;
    }
  }

  ///Returns true if there are new mails
  static testNewMails() async {
    try {
      //Get the old number of mails
      var oldMailLength = appSys.settings!["system"]["lastMailCount"];
      print("Old length is $oldMailLength");
      //Get new mails
      List<Mail>? mails = await getMails();
      //filter mails by type
      (mails ?? []).retainWhere((element) => element.mtype == "received");
      (mails ?? []).sort((a, b) {
        DateTime datea = DateTime.parse(a.date!);
        DateTime dateb = DateTime.parse(b.date!);
        return datea.compareTo(dateb);
      });
      var newMailLength = appSys.settings!["system"]["lastMailCount"];

      await logFile("Mails checking triggered");
      print("New length is ${newMailLength}");
      if (oldMailLength != 0) {
        if (oldMailLength < (newMailLength ?? 0)) {
          //Manually set the new mail number
          final prefs = await (SharedPreferences.getInstance());
          appSys.updateSetting(appSys.settings!["system"], "lastMailCount", newMailLength);

          return (mails ?? []).last;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur dans la verification de nouveaux mails hors ligne " + e.toString());
      return null;
    }
  }

  //write last fetch in milliseconds since epoch
  static writeLastFetchStatus(ApplicationSystem _appSys) async {
    int date = DateTime.now().millisecondsSinceEpoch;
    await _appSys.updateSetting(_appSys.settings?["system"], "lastFetchDate", date);
    print("Written last fetch status " + date.toString());
  }
}
