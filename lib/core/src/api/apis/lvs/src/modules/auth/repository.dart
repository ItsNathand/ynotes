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
    List res = await client.start(credentials);
    if (res[0] == 1) {
      var req_infos =
          await client.get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));
      Map<String, dynamic> raw_infos = jsonDecode(req_infos.body)["infoUser"];

      final AppAccount appAccount = AppAccount(
          firstName: raw_infos['userPrenom'], lastName: raw_infos['userNom']);
      final Map<String, dynamic> map = {
        "appAccount": appAccount,
        "schoolAccount": SchoolAccount(
            firstName: appAccount.firstName,
            lastName: appAccount.lastName,
            profilePicture: raw_infos["logo"],
            school: raw_infos["etabName"],
            className: '',
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
