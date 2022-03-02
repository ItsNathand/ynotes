part of app;

late SchoolApi schoolApi;

SchoolApi schoolApiManager(Apis api) {
  late SchoolApi _api;
  switch (api) {
    case Apis.ecoleDirecte:
      _api = EcoleDirecteApi();
      break;
    case Apis.lvs:
      _api = LvsApi();
  }
  Logger.log("SCHOOL API MANAGER", "Selected: ${_api.metadata.name}");
  return LvsApi(); // hard coded
}

final List<SchoolApi> schoolApis = [EcoleDirecteApi(), LvsApi()];
