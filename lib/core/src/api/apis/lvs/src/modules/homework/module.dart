part of lvs;

class _HomeworkModule extends HomeworkModule<_HomeworkRepository> {
  _HomeworkModule(SchoolApi api)
      : super(repository: _HomeworkRepository(api), api: api);
}

// future support is planned
