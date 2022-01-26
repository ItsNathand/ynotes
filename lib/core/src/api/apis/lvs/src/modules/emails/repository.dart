part of lvs;

class _EmailsRepository extends EmailsRepository {
  _EmailsRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async {
    return Response(data: {});
  }

  @override
  Future<Response<String>> getEmailContent(Email email, bool received) {
    // TODO: implement getEmailContent
    throw UnimplementedError();
  }

  @override
  Future<Response<void>> sendEmail(Email email) {
    // TODO: implement sendEmail
    throw UnimplementedError();
  }
}
