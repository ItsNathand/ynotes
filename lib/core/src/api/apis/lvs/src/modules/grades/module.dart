part of lvs;

class _GradesModule extends GradesModule<_GradesRepository> {
  _GradesModule(SchoolApi api)
      : super(repository: _GradesRepository(api), api: api);
}
