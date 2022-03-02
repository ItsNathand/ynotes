part of lvs;

class _GradesRepository extends Repository {
  @protected
  _GradesRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    print(' called');
    var periods = [];
    var subjects = [];
    var grades = [];
    //testing without account:
    /* return Response(data: {
      "periods": periods,
      "subjects": subjects,
      "grades": grades,
    }); */
    var req = await client.get(Uri.parse('/vsn.main/releveNote/releveNotes'));
    var periodsData = LvsMethods.getPeriods(req.body);
    var reqAverage =
        client.get(Uri.parse('/vsn.main/dossierRecapEleve/afficheDetailNotes'));
    var averages = reqAverage;
    await periodsData.forEach((name, url) async {
      periods.add(Period(
          entityId: name,
          name: name,
          startDate: DateTime.parse(''), // no way
          endDate: DateTime.parse(''), // no way
          headTeacher: '', // no way
          overallAverage: double.nan, // soon with an additional request
          classAverage: double.nan, // soon with an additional request
          maxAverage: double.nan, // no way
          minAverage: double.nan)); // no way

      var rawSubjects = await client.get(Uri.parse(url.toString()));
      var dis = LvsMethods.get_disciplines(rawSubjects.body);
      final colors = List.from(AppColors.colors);
      final Random random = Random();
      dis.forEach((sbjct) {
        late YTColor color;
        color = colors[random.nextInt(colors.length)];
        colors.remove(color);
        subjects.add(Subject(
            entityId: '',
            name: '',
            classAverage: double.nan, // no way
            maxAverage: double.nan, // no way
            minAverage: double.nan, // no way
            coefficient: double.nan, // no way
            teachers: '',
            average: double.nan,
            color: color));
        sbjct['grades'].forEach((grade) {
          grades.add(Grade(
            name: '',
            type: '',
            coefficient: 1,
            outOf: double.nan,
            value: double.nan,
            significant: true,
            date: DateTime.parse('0'),
            entryDate: DateTime.parse('0'),
            classAverage: double.nan,
            classMax: double.nan,
            classMin: double.nan,
          ));
        });
      });
    });
    periods.sort((a, b) => a.startDate.compareTo(b.startDate));
    return Response(data: {
      "periods": periods,
      "subjects": subjects,
      "grades": grades,
    });
  }
}
