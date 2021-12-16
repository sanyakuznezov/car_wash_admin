// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDataDao? _userataDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserData` (`id` INTEGER, `guid` TEXT, `token` TEXT, `valid` INTEGER, `firstname` TEXT NOT NULL, `lastname` TEXT NOT NULL, `patronymic` TEXT NOT NULL, `avatar` TEXT NOT NULL, `phone` TEXT NOT NULL, `phone_verified` INTEGER NOT NULL, `email` TEXT NOT NULL, `lang_id` INTEGER NOT NULL, `personals_id` INTEGER NOT NULL, `personals_carwash_id` INTEGER NOT NULL, `personals_carwash_name` TEXT NOT NULL, `personals_carwash_avatar` TEXT NOT NULL, `personals_carwash_address` TEXT NOT NULL, `personals_carwash_timezone` INTEGER NOT NULL, `personals_post` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDataDao get userataDao {
    return _userataDaoInstance ??= _$UserDataDao(database, changeListener);
  }
}

class _$UserDataDao extends UserDataDao {
  _$UserDataDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userDataInsertionAdapter = InsertionAdapter(
            database,
            'UserData',
            (UserData item) => <String, Object?>{
                  'id': item.id,
                  'guid': item.guid,
                  'token': item.token,
                  'valid': item.valid == null ? null : (item.valid! ? 1 : 0),
                  'firstname': item.firstname,
                  'lastname': item.lastname,
                  'patronymic': item.patronymic,
                  'avatar': item.avatar,
                  'phone': item.phone,
                  'phone_verified': item.phone_verified ? 1 : 0,
                  'email': item.email,
                  'lang_id': item.lang_id,
                  'personals_id': item.personals_id,
                  'personals_carwash_id': item.personals_carwash_id,
                  'personals_carwash_name': item.personals_carwash_name,
                  'personals_carwash_avatar': item.personals_carwash_avatar,
                  'personals_carwash_address': item.personals_carwash_address,
                  'personals_carwash_timezone': item.personals_carwash_timezone,
                  'personals_post': item.personals_post
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserData> _userDataInsertionAdapter;

  @override
  Future<UserData?> getDataUser() async {
    return _queryAdapter.query('SELECT * FROM UserData',
        mapper: (Map<String, Object?> row) => UserData(
            id: row['id'] as int?,
            valid: row['valid'] == null ? null : (row['valid'] as int) != 0,
            guid: row['guid'] as String?,
            token: row['token'] as String?,
            firstname: row['firstname'] as String,
            lastname: row['lastname'] as String,
            patronymic: row['patronymic'] as String,
            avatar: row['avatar'] as String,
            phone: row['phone'] as String,
            phone_verified: (row['phone_verified'] as int) != 0,
            email: row['email'] as String,
            lang_id: row['lang_id'] as int,
            personals_id: row['personals_id'] as int,
            personals_carwash_id: row['personals_carwash_id'] as int,
            personals_carwash_name: row['personals_carwash_name'] as String,
            personals_carwash_avatar: row['personals_carwash_avatar'] as String,
            personals_carwash_address:
                row['personals_carwash_address'] as String,
            personals_carwash_timezone:
                row['personals_carwash_timezone'] as int,
            personals_post: row['personals_post'] as String));
  }

  @override
  Future<void> updateAvatar(String ava) async {
    await _queryAdapter
        .queryNoReturn('UPDATE UserData SET avatar=?1', arguments: [ava]);
  }

  @override
  Future<void> updateName(String p1, String p2, String p3,String p4) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE UserData SET firstname=?1, lastname=?2, patronymic=?3, phone=?4',
        arguments: [p1, p2, p3,p4]);
  }

  @override
  Future<void> updateLangId(int id) async {
    await _queryAdapter
        .queryNoReturn('UPDATE UserData SET lang_id=?1', arguments: [id]);
  }

  @override
  Future<void> insertDataUser(UserData userData) async {
    await _userDataInsertionAdapter.insert(userData, OnConflictStrategy.abort);
  }
}
