// ignore_for_file: avoid_print

import 'tests/ecole_directe/ecole_directe.dart';

const String username = 'aaa';
const String password = 'aaa';

Future<void> main() async {
  final api = EcoleDirecteApi();
  print(api.metadata.name);
  final res0 = await api.authModule.login(username: username, password: password);
  print("Error: ${res0.error}");
  print(api.authModule.account);
  final res1 = await api.schoolLifeModule.fetch(online: true);
  print("Error: ${res1.error}");
  print(api.schoolLifeModule.tickets);
  for (var t in api.schoolLifeModule.tickets) {
    print("${t.reason} ${t.date}");
  }
  await api.schoolLifeModule.reset(offline: true);
  print(api.schoolLifeModule.tickets);
  await api.schoolLifeModule.fetch();
  print(api.schoolLifeModule.tickets);
  // print("----------------------------------------");
  // final res2 = await api.schoolLifeModule.fetch(online: false);
  // print("Error: ${res2.error}");
  // print(api.schoolLifeModule.tickets);
  // for (var t in api.schoolLifeModule.tickets) {
  //   print("${t.reason} ${t.date}");
  // }
}
