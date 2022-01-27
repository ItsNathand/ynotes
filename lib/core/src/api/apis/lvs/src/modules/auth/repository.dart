part of lvs;

class _AuthRepository extends AuthRepository {
  _AuthRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> login(
      {required String username,
      required String password,
      Map<String, dynamic>? parameters}) async {
    var url = '';
    Map<String, dynamic> credentials = {
      'url': Uri.parse(url),
      'username': username,
      'password': password
    };
    List authRes = await client.start(credentials);
    if (authRes[0] == 1) {
      var accountInfos =
          await client.get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));
      Map<String, dynamic> rawInfos = jsonDecode(accountInfos.body)["infoUser"];

      final AppAccount appAccount = AppAccount(
          firstName: rawInfos['userPrenom'], lastName: rawInfos['userNom']);
      final Map<String, dynamic> map = {
        "appAccount": appAccount,
        "schoolAccount": SchoolAccount(
            firstName: appAccount.firstName,
            lastName: appAccount.lastName,
            profilePicture: rawInfos["logo"],
            school: rawInfos["etabName"],
            className: 'none',
            id: appAccount.id)
      };
      api.modulesAvailability.grades = true;
      api.modulesAvailability.schoolLife = false;
      api.modulesAvailability.emails = false;
      api.modulesAvailability.homework = false;
      await api.modulesAvailability.save();
      api.refreshModules();
      return Response(data: map);
    }
    return const Response(error: 'Connection failed');
  }
}
