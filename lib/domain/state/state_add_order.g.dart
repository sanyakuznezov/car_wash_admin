// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_add_order.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateAddOrder on StateAddOrderBase, Store {
  final _$isLoadAtom = Atom(name: 'StateAddOrderBase.isLoad');

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

  final _$isErrorDayAtom = Atom(name: 'StateAddOrderBase.isErrorDay');

  @override
  bool get isErrorDay {
    _$isErrorDayAtom.reportRead();
    return super.isErrorDay;
  }

  @override
  set isErrorDay(bool value) {
    _$isErrorDayAtom.reportWrite(value, super.isErrorDay, () {
      super.isErrorDay = value;
    });
  }

  final _$successRequestAtom = Atom(name: 'StateAddOrderBase.successRequest');

  @override
  bool get successRequest {
    _$successRequestAtom.reportRead();
    return super.successRequest;
  }

  @override
  set successRequest(bool value) {
    _$successRequestAtom.reportWrite(value, super.successRequest, () {
      super.successRequest = value;
    });
  }

  final _$modelTimeFreeIntervalsAtom =
      Atom(name: 'StateAddOrderBase.modelTimeFreeIntervals');

  @override
  ModelTimeFreeIntervals? get modelTimeFreeIntervals {
    _$modelTimeFreeIntervalsAtom.reportRead();
    return super.modelTimeFreeIntervals;
  }

  @override
  set modelTimeFreeIntervals(ModelTimeFreeIntervals? value) {
    _$modelTimeFreeIntervalsAtom
        .reportWrite(value, super.modelTimeFreeIntervals, () {
      super.modelTimeFreeIntervals = value;
    });
  }

  final _$msgErrorAtom = Atom(name: 'StateAddOrderBase.msgError');

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

  @override
  String toString() {
    return '''
isLoad: ${isLoad},
isErrorDay: ${isErrorDay},
successRequest: ${successRequest},
modelTimeFreeIntervals: ${modelTimeFreeIntervals},
msgError: ${msgError}
    ''';
  }
}
