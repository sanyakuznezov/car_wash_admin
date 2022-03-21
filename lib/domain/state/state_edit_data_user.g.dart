// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_edit_data_user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateEditDataUser on StateEditDataUserBase, Store {
  final _$userDataAtom = Atom(name: 'StateEditDataUserBase.userData');

  @override
  UserData? get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(UserData? value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  final _$isLoadAtom = Atom(name: 'StateEditDataUserBase.isLoad');

  @override
  bool get isLoad {
    _$isLoadAtom.reportRead();
    return super.isLoad;
  }

  @override
  set isLoad(bool value) {
    _$isLoadAtom.reportWrite(value, super.isLoad, () {
      super.isLoad = value;
    });
  }

  final _$isErrorAtom = Atom(name: 'StateEditDataUserBase.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$getDataUserLocalAsyncAction =
      AsyncAction('StateEditDataUserBase.getDataUserLocal');

  @override
  Future<void> getDataUserLocal() {
    return _$getDataUserLocalAsyncAction.run(() => super.getDataUserLocal());
  }

  @override
  String toString() {
    return '''
userData: ${userData},
isLoad: ${isLoad},
isError: ${isError}
    ''';
  }
}
