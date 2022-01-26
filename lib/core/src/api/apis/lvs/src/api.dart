part of lvs;

LvsClient client = LvsClient();

final Metadata metadata = Metadata(
    name: "La-vie-scolaire",
    imagePath: "assets/images/icons/laviescolaire/LVSIcon.png",
    color: AppColors.blue,
    beta: true,
    api: Apis.lvs,
    coloredLogo: true,
    loginRoute: "/login/lvs");

const ModulesSupport modulesSupport = ModulesSupport(
    grades: true,
    schoolLife: false,
    emails: false,
    homework: false,
    documents: false);

class LvsApi extends SchoolApi implements SchoolApiModules {
  LvsApi() : super(metadata: metadata, modulesSupport: modulesSupport);

  @override
  late AuthModule authModule = _AuthModule(this);

  @override
  late GradesModule gradesModule = _GradesModule(this);

  @override
  late SchoolLifeModule schoolLifeModule = _SchoolLifeModule(this);

  @override
  late EmailsModule emailsModule = _EmailsModule(this);

  @override
  late HomeworkModule homeworkModule = _HomeworkModule(this);

  @override
  late DocumentsModule documentsModule = _DocumentsModule(this);
}
