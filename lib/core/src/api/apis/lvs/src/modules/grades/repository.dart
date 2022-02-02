part of lvs;

class _GradesRepository extends Repository {
  @protected
  _GradesRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    List disciplines = [];
    var req = await client.get(Uri.parse('/vsn.main/releveNote/releveNotes'));
    List periods = ['1er Trimestre', '2nd Trimestre', '3ème Trimestre'];
    var periodsData = LvsDisciplineConverter.getPeriods(req.body);
    periodsData.forEach((name, url) {
      /* var resp =
          await this.client.get(Uri.parse(url.toString()));
      var dis = LvsDisciplineConverter.get_disciplines(resp.body);
      dis.forEach((element) {
        element.periodName = name
        element.periodCode = name
      });
      disciplines.addAll(dis); */
    });

    return const Response(data: {});
  }
}
