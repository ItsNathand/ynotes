import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ynotes/core/apis/lvs/lvs_client.dart';
import 'package:ynotes/core/logic/models_exporter.dart';
import 'package:ynotes/core/offline/data/homework/homework.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'converters/disciplines.dart';
import 'converters/homework.dart';

Future<dynamic> fetch(Function onlineFetch, Function offlineFetch,
    {bool forceFetch = false}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return await offlineFetch();
  } else if (forceFetch) {
    try {
      await onlineFetch();
      return await offlineFetch();
    } catch (e) {
      print("Error " + e.toString());
      return await offlineFetch();
    }
  }
}

class LvsMethods {
  LvsClient client;
  final Offline _offlineController;

  LvsMethods(this.client, this._offlineController);

  Future<List<Discipline>?> grades() async {
    List<Discipline> disciplines = [];
    //  var periodsData = ['44', '43', '42'];
    var periodsData = LvsDisciplineConverter.getPeriods('me');

    periodsData.forEach((periodId) {
      var url = periodId.toString();
      print(url);
      //var content = {};
      //disciplines.add(LvsDisciplineConverter.disciplines(content));
    });
    print(LvsDisciplineConverter.getPeriod('me'));
    print(LvsDisciplineConverter.grades('me'));
    return disciplines;
  }

  Future<List<Homework>?> homeworkFor(DateTime date) async {
    HwClient hwClient = await this.client.getHwClient();
    var search = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body: "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A-1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%22" +
            date.day.toString() +
            "%2F" +
            date.month.toString() +
            "%2F" +
            date.year.toString() +
            "%22%2C%22dateFin%22%3A%22" +
            date.day.toString() +
            "%2F" +
            date.month.toString() +
            "%2F" +
            date.year.toString() +
            "%22%2C%22actionRecherche%22%3Atrue%2C%22activeTab%22%3A%22idlisteTab%22%7D&xaction=read");

    Map searched = json.decode(search.body);
    List searchIds = [];
    searched['activites'].forEach((element) {
      searchIds.add(element['activiteId'].toString());
    });
    var req = await hwClient.get(Uri.parse('/vueCalendaire/eleve'),
        params: '?timeshift=-120&from=' +
            date.year.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.day.toString() +
            '&to=' +
            date.year.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.day.toString());

    List<Homework>? hw = LvsHomeworkConverter.homework(req.body);

    (hw).removeWhere((element) => !searchIds.contains(element.id));
    print(hw);
    if (hw != []) {
      await HomeworkOffline(_offlineController).updateHomework(hw);
      print("Updated hw");
    }
    return hw;
  }

  nextHomework() async {
    var date = new DateTime.now();
    var end_date = date.add(Duration(days: 14, hours: 0));
    HwClient hwClient = await this.client.getHwClient();
    var search = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body: "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A-1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%22" +
            date.day.toString() +
            "%2F" +
            date.month.toString() +
            "%2F" +
            date.year.toString() +
            "%22%2C%22dateFin%22%3A%22" +
            end_date.day.toString() +
            "%2F" +
            end_date.month.toString() +
            "%2F" +
            end_date.year.toString() +
            "%22%2C%22actionRecherche%22%3Atrue%2C%22activeTab%22%3A%22idlisteTab%22%7D&xaction=read");

    Map searched = json.decode(search.body);
    List searchIds = [];
    searched['activites'].forEach((element) {
      searchIds.add(element['activiteId'].toString());
    });
    var req = await hwClient.get(Uri.parse('/vueCalendaire/eleve'),
        params: '?timeshift=-120&from=' +
            date.year.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.day.toString() +
            '&to=' +
            end_date.year.toString() +
            '-' +
            end_date.month.toString() +
            '-' +
            end_date.day.toString());

    List<Homework>? hw = LvsHomeworkConverter.homework(req.body);

    (hw).removeWhere((element) => !searchIds.contains(element.id));

    var ids = [];
    hw.reversed.toList().forEach((element) {
      if (ids.contains(element.id)) {
        hw.remove(element);
      } else {
        ids.add(element.id);
      }
    });
    if (hw != []) {
      await HomeworkOffline(_offlineController).updateHomework(hw);
      print("Updated hw");
    }

    print(hw);
    return hw.reversed.toList();
  }

  searchHw(HwClient hwClient, List<DateTime> period) async {
    var search = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body: "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A-1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%22" +
            period[0].day.toString() +
            "%2F" +
            period[0].month.toString() +
            "%2F" +
            period[0].year.toString() +
            "%22%2C%22dateFin%22%3A%22" +
            period[1].day.toString() +
            "%2F" +
            period[1].month.toString() +
            "%2F" +
            period[1].year.toString() +
            "%22%2C%22actionRecherche%22%3Atrue%2C%22activeTab%22%3A%22idlisteTab%22%7D&xaction=read");
    return json.decode(search.body);
  }
}
