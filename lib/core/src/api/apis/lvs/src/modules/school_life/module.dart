part of lvs;

class _SchoolLifeModule extends SchoolLifeModule<_SchoolLifeRepository> {
  _SchoolLifeModule(SchoolApi api)
      : super(repository: _SchoolLifeRepository(api), api: api);
}
