part of lvs;

class _AuthRepository extends AuthRepository {
  _AuthRepository(SchoolApi api) : super(api);

  @override
  Future<Response<Map<String, dynamic>>> login(
      {required String username,
      required String password,
      Map<String, dynamic>? parameters}) async {
    print('trying to log');
    var url = '';

    Map<String, dynamic> credentials = {
      'url': Uri.parse(url),
      'username': username,
      'password': password
    };

    List res = await client.start(credentials);
    print(credentials);
    if (res[0] == 1) {
      print('logged!!');
      var req_infos =
          await client.get(Uri.parse('/vsn.main/WSMenu/infosPortailUser'));

      Map<String, dynamic> raw_infos = jsonDecode(req_infos.body);
      print(raw_infos);
      /*  raw_infos = {
          "infoUser": {
            "logo": "https://institut.la-vie-scolaire.fr/vsn.main/WSMenu/logo",
            "etabName": "Intitut",
            "userPrenom": "Inom",
            "userNom": "Iom",
            "profil": "Elève"
          },
          "plateform": ""
        }; */
      // appSys.account = LvsAccountConverter.account(raw_infos);
    }
    return Response(data: {}, error: '');
  }
}
