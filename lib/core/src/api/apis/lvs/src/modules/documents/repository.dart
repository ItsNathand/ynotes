part of lvs;

class _DocumentsRepository extends DocumentsRepository {
  _DocumentsRepository(SchoolApi api) : super(api);

  @override
  Response<http.Request> download(Document document) {
    throw ('hi');
  }

  @override
  Future<Response<http.Request>> upload(Document document) async {
    return const Response(error: "Not implemented");
  }
}
