part of lvs;

class _GradesRepository extends Repository {
  @protected
  _GradesRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    return Response(data: {});
  }
}
