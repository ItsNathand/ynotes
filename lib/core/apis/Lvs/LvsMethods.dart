import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:ynotes/core/apis/Lvs/LvsClient.dart';
import 'package:ynotes/core/logic/modelsExporter.dart';
import 'package:ynotes/core/offline/data/homework/homework.dart';
import 'package:ynotes/core/offline/offline.dart';
import 'converters/homework.dart';

Future<dynamic> fetch(Function onlineFetch, Function offlineFetch,
    {bool forceFetch = true}) async {
  var res = await offlineFetch();
  print(res);
  return res;
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
    //return [];
    var req;

    var debut = [];
    var fin = [];
    var params =
        "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A-1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%22" +
            date.day.toString() +
            "%2F" +
            date.month.toString() +
            "%2F" +
            date.year.toString() +
            "%22%2C%22dateFin%22%3A%22" +
            fin[0] +
            "%2F" +
            fin[1] +
            "%2F" +
            fin[2] +
            "%22%2C%22actionRecherche%22%3Atrue%2C%22activeTab%22%3A%22idlisteTab%22%7D&xaction=read";
    req = await hwClient.post(
        Uri.parse('/rechercheActivite/rechercheJournaliere'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body:
            "params=%7B%22start%22%3A0%2C%22limit%22%3A100%2C%22contexteId%22%3A-1%2C%22typeId%22%3A-1%2C%22cdtId%22%3A-1%2C%22matiereId%22%3A-1%2C%22groupeId%22%3A-1%2C%22dateDebut%22%3A%2208%2F06%2F2021%22%2C%22dateFin%22%3A%2208%2F06%2F2021%22%2C%22actionRecherche%22%3Atrue%2C%22activeTab%22%3A%22idlisteTab%22%7D&xaction=read");
    print(req.statusCode);
    print(req.body);
    List<Homework>? hw = LvsHomeworkConverter.homework(req.body);
    if (hw != null) {
      await HomeworkOffline(_offlineController).updateHomework(hw);
      print("Updated hw");
    }
    return hw;
  }

  nextHomework() async {
    DateTime now = DateTime.now();
    List<Homework> listHW = [];
    final f = new DateFormat('dd/MM/yyyy');

    List<Homework>? hws = null;

    listHW.addAll(hws ?? []);
    await HomeworkOffline(_offlineController).updateHomework(listHW);
//+ 1 month
    return listHW;
  }
}
