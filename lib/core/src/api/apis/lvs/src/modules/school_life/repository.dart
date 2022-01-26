part of lvs;

class _SchoolLifeRepository extends Repository {
  @protected
  _SchoolLifeRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    return Response(data: {});
  }
}
