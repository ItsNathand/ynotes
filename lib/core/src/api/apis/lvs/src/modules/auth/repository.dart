part of lvs;

class _AuthRepository extends AuthRepository {
  _AuthRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> get() async =>
      const Response(error: "Not implemented");

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
      try {
        var rawInfos =
            await client.get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));

        Map<String, dynamic> accountInfos =
            jsonDecode(rawInfos.body)["infoUser"];
        //testing without account:
        /*Map<String, dynamic> accountInfos = {
          "logo": "https://institut.la-vie-scolaire.fr/vsn.main/WSMenu/logo",
          "etabName": "Intitut",
          "userPrenom": "Inom",
          "userNom": "Iom",
          "profil": "Elève" 
        }; */
        if (accountInfos["profil"] != 'Elève') {
          throw ('Account type must be "Elève"');
        }
        final AppAccount appAccount = AppAccount(
            entityId: Uuid().v4(),
            firstName: accountInfos['userPrenom'],
            lastName: accountInfos['userNom']);

        final Map<String, dynamic> map = {
          "appAccount": appAccount,
          "schoolAccount": SchoolAccount(
              firstName: appAccount.firstName,
              lastName: appAccount.lastName,
              profilePicture: accountInfos["logo"],
              school: accountInfos["etabName"],
              className: 'none',
              entityId: appAccount.id.toString())
        };

        api.modulesAvailability.grades = true;
        api.modulesAvailability.schoolLife = false;
        api.modulesAvailability.emails = false;
        api.modulesAvailability.homework = false;
        await api.modulesAvailability.save();
        api.refreshModules();

        return Response(data: map);
      } catch (e) {
        return Response(error: "$e");
      }
    }
    return const Response(error: 'Connection failed');
  }
}
