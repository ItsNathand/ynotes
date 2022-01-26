part of lvs;

class _EmailsModule extends EmailsModule<_EmailsRepository> {
  _EmailsModule(SchoolApi api)
      : super(repository: _EmailsRepository(api), api: api);
}
