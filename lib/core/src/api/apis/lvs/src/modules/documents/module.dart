part of lvs;

class _DocumentsModule extends DocumentsModule<_DocumentsRepository> {
  _DocumentsModule(SchoolApi api)
      : super(repository: _DocumentsRepository(api), api: api);
}

// future support is planned
