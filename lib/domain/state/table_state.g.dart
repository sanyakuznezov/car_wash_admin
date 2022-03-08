// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TableState on TableStateBase, Store {
  final _$modelDataTableAtom = Atom(name: 'TableStateBase.modelDataTable');

  @override
  ModelDataTable? get modelDataTable {
    _$modelDataTableAtom.reportRead();
    return super.modelDataTable;
  }

  @override
  set modelDataTable(ModelDataTable? value) {
    _$modelDataTableAtom.reportWrite(value, super.modelDataTable, () {
      super.modelDataTable = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'TableStateBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isErrorAtom = Atom(name: 'TableStateBase.isError');

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

  final _$msgErrorAtom = Atom(name: 'TableStateBase.msgError');

  @override
  String get msgError {
    _$msgErrorAtom.reportRead();
    return super.msgError;
  }

  @override
  set msgError(String value) {
    _$msgErrorAtom.reportWrite(value, super.msgError, () {
      super.msgError = value;
    });
  }

  final _$editOrderJournalAsyncAction =
      AsyncAction('TableStateBase.editOrderJournal');

  @override
  Future<void> editOrderJournal(
      {required String endAt,
      required String startAt,
      required BuildContext context,
      required int idOrder,
      required int post}) {
    return _$editOrderJournalAsyncAction.run(() => super.editOrderJournal(
        endAt: endAt,
        startAt: startAt,
        context: context,
        idOrder: idOrder,
        post: post));
  }

  final _$TableStateBaseActionController =
      ActionController(name: 'TableStateBase');

  @override
  dynamic settingsRequest(
      {required BuildContext context, required String date}) {
    final _$actionInfo = _$TableStateBaseActionController.startAction(
        name: 'TableStateBase.settingsRequest');
    try {
      return super.settingsRequest(context: context, date: date);
    } finally {
      _$TableStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$TableStateBaseActionController.startAction(
        name: 'TableStateBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$TableStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
modelDataTable: ${modelDataTable},
isLoading: ${isLoading},
isError: ${isError},
msgError: ${msgError}
    ''';
  }
}
