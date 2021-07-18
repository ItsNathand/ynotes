import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:ynotes/core/apis/Lvs/LvsClient.dart';
import 'package:ynotes/core/logic/modelsExporter.dart';
import 'package:ynotes/core/offline/data/homework/homework.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'converters/homework.dart';

Future<dynamic> fetch(Function onlineFetch, Function offlineFetch,
    {bool forceFetch = true}) async {
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

  Future<List<Homework>?> homeworkFor(DateTime date) async {
    HwClient hwClient = await this.client.getHwClient();
    var search = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body:
            "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%2207%2F06%2F2021%22%2C%22dateFin%22%3A%2207%2F06%2F2021%22%2C%22activeTab%22%3A%22idJournalierTab%22%2C%22actionRecherche%22%3Atrue%7D&xaction=read");

    Map searched = json.decode(search.body);
    List searchIds = [];
    searched['activites'].forEach((element) {
      searchIds.add(element['activiteId'].toString());
    });
    var req = await hwClient.get(Uri.parse('/vueCalendaire/eleve'),
        params: '?timeshift=-120&from=2021-06-07&to=2021-06-09');

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
    DateTime now = DateTime.now();
    List<Homework> listHW = [];
    final f = new DateFormat('dd/MM/yyyy');
    HwClient hwClient = await this.client.getHwClient();
    var search = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body:
            "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%2207%2F06%2F2021%22%2C%22dateFin%22%3A%2207%2F06%2F2021%22%2C%22activeTab%22%3A%22idJournalierTab%22%2C%22actionRecherche%22%3Atrue%7D&xaction=read");

    Map searched = json.decode(search.body);
    List searchIds = [];
    searched['activites'].forEach((element) {
      searchIds.add(element['activiteId'].toString());
    });
    var req = await hwClient.get(Uri.parse('/vueCalendaire/eleve'),
        params: '?timeshift=-120&from=2021-06-07&to=2021-06-09');

    List<Homework>? hw = LvsHomeworkConverter.homework(req.body);

    (hw).removeWhere((element) => !searchIds.contains(element.id));
    print(hw);
    if (hw != null) {
      await HomeworkOffline(_offlineController).updateHomework(hw);
      print("Updated hw");
    }
    return hw;
  }
}
