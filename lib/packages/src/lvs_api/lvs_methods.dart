part of lvs_api;

class LvsMethods {
  // Grades

  static getPeriods(html) {
    Map<String, String> periods = {};
    html = parse(html);
    html
        .querySelector("ul.periodes")!
        .querySelectorAll('li.periode')
        .forEach((period) {
      var url = period.querySelector('a')!.attributes['href'].toString();
      var period_name =
          period.querySelector('a')!.attributes['href'].toString();
      periods[period_name] = url;
    });
    return periods;
  }

  static getAverage(html) {
    var averages = {};
    averages['year'];
    averages['current_class'];
    averages['year_class'];
    html = parse(html);
    var table = html.querySelector("table.tableNotes").querySelector("tr");
    var i = 0;
    table.forEach((period) {
      i++;
      if (period.lenght - i == 0) {
        averages['current'] = period.querySelector("span");
        averages['year_class'] = period.querySelector("td").last;
        return averages;
      }
      averages['current'] = period.querySelector("span");
      averages['current_class'] = period.querySelector("td").last;
    });
  }

  static get_disciplines(String body) {
    return [];
  }
  // Hw
}
