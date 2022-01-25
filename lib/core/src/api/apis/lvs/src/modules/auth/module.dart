part of lvs;

class _AuthModule extends AuthModule<_AuthRepository> {
  _AuthModule(SchoolApi api)
      : super(repository: _AuthRepository(api), api: api);
}
