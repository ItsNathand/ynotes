import 'package:intl/intl.dart';
import 'package:ynotes/core/apis/pronote/pronote_api.dart';
import 'package:ynotes/core/logic/models_exporter.dart';
import 'package:ynotes/core/utils/null_safe_map_getter.dart';

class LvsDisciplineConverter {
  static disciplines(d) {}

  static List<Grade> grades(PronoteClient client, List gradesData) {
    List<Grade> grades = [];
    gradesData.forEach((gradeData) {
      String value =
          client.utils.gradeTranslate(mapGet(gradeData, ["note", "V"]) ?? "");
      String testName = mapGet(gradeData, ["commentaire"]) ?? "";
      String periodCode = mapGet(gradeData, ["periode", "V", "N"]) ?? "";
      String periodName = mapGet(gradeData, ["periode", "V", "L"]) ?? "";
      String disciplineCode =
          (mapGet(gradeData, ["service", "V", "L"]) ?? "").hashCode.toString();
      String? subdisciplineCode;
      String disciplineName = mapGet(gradeData, ["service", "V", "L"]);
      bool letters = (mapGet(gradeData, ["note", "V"]) ?? "").contains("|");
      String weight = mapGet(gradeData, ["coefficient"]).toString();
      String scale = mapGet(gradeData, ["bareme", "V"]);
      String min = client.utils
          .gradeTranslate(mapGet(gradeData, ["noteMin", "V"]) ?? "");
      String max = client.utils
          .gradeTranslate(mapGet(gradeData, ["noteMax", "V"]) ?? "");
      String classAverage = client.utils
          .gradeTranslate(mapGet(gradeData, ["moyenne", "V"]) ?? "");
      DateTime? date = mapGet(gradeData, ["date", "V"]) != null
          ? DateFormat("dd/MM/yyyy").parse(mapGet(gradeData, ["date", "V"]))
          : null;
      bool notSignificant =
          client.utils.gradeTranslate(mapGet(gradeData, ["note", "V"]) ?? "") ==
              "NonNote";
      String testType = "Interrogation";
      DateTime? entryDate = mapGet(gradeData, ["date", "V"]) != null
          ? DateFormat("dd/MM/yyyy").parse(mapGet(gradeData, ["date", "V"]))
          : null;
      bool countAsZero = client.utils.shouldCountAsZero(
          client.utils.gradeTranslate(mapGet(gradeData, ["note", "V"]) ?? ""));

      grades.add(Grade(
          value: value,
          testName: testName,
          periodCode: periodCode,
          periodName: periodName,
          disciplineCode: disciplineCode,
          subdisciplineCode: subdisciplineCode,
          disciplineName: disciplineName,
          letters: letters,
          weight: weight,
          scale: scale,
          min: min,
          max: max,
          classAverage: classAverage,
          date: date,
          notSignificant: notSignificant,
          testType: testType,
          entryDate: entryDate,
          countAsZero: countAsZero));
    });
    return grades;
  }
}
