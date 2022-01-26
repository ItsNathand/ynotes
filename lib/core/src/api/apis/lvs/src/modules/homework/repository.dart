part of lvs;

class _HomeworkRepository extends HomeworkRepository {
  _HomeworkRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    return Response(data: {});
  }

  @override
  Future<Response<List<Homework>>> getDay(DateTime date) {
    // TODO: implement getDay
    throw UnimplementedError();
  }
}
