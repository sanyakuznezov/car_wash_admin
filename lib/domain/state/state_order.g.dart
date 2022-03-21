// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_order.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StateOrder on StateOrderBase, Store {
  final _$modelOrderShowAtom = Atom(name: 'StateOrderBase.modelOrderShow');

  @override
  ModelOrderShow? get modelOrderShow {
    _$modelOrderShowAtom.reportRead();
    return super.modelOrderShow;
  }

  @override
  set modelOrderShow(ModelOrderShow? value) {
    _$modelOrderShowAtom.reportWrite(value, super.modelOrderShow, () {
      super.modelOrderShow = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'StateOrderBase.isLoading');

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

  final _$isErrorAtom = Atom(name: 'StateOrderBase.isError');

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

  final _$isInitDataAtom = Atom(name: 'StateOrderBase.isInitData');

  @override
  bool get isInitData {
    _$isInitDataAtom.reportRead();
    return super.isInitData;
  }

  @override
  set isInitData(bool value) {
    _$isInitDataAtom.reportWrite(value, super.isInitData, () {
      super.isInitData = value;
    });
  }

  final _$isLoadPriceAtom = Atom(name: 'StateOrderBase.isLoadPrice');

  @override
  bool get isLoadPrice {
    _$isLoadPriceAtom.reportRead();
    return super.isLoadPrice;
  }

  @override
  set isLoadPrice(bool value) {
    _$isLoadPriceAtom.reportWrite(value, super.isLoadPrice, () {
      super.isLoadPrice = value;
    });
  }

  final _$modelCalculatePriceAtom =
      Atom(name: 'StateOrderBase.modelCalculatePrice');

  @override
  ModelCalculatePrice? get modelCalculatePrice {
    _$modelCalculatePriceAtom.reportRead();
    return super.modelCalculatePrice;
  }

  @override
  set modelCalculatePrice(ModelCalculatePrice? value) {
    _$modelCalculatePriceAtom.reportWrite(value, super.modelCalculatePrice, () {
      super.modelCalculatePrice = value;
    });
  }

  final _$getPriceAsyncAction = AsyncAction('StateOrderBase.getPrice');

  @override
  Future<void> getPrice(
      {required dynamic context,
      required int carType,
      required List<int> idServiceList,
      required List<int> idComplexList}) {
    return _$getPriceAsyncAction.run(() => super.getPrice(
        context: context,
        carType: carType,
        idServiceList: idServiceList,
        idComplexList: idComplexList));
  }

  final _$getOrderShowAsyncAction = AsyncAction('StateOrderBase.getOrderShow');

  @override
  Future<void> getOrderShow({required BuildContext context, required int id}) {
    return _$getOrderShowAsyncAction
        .run(() => super.getOrderShow(context: context, id: id));
  }

  final _$StateOrderBaseActionController =
      ActionController(name: 'StateOrderBase');

  @override
  dynamic dispose() {
    final _$actionInfo = _$StateOrderBaseActionController.startAction(
        name: 'StateOrderBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$StateOrderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
modelOrderShow: ${modelOrderShow},
isLoading: ${isLoading},
isError: ${isError},
isInitData: ${isInitData},
isLoadPrice: ${isLoadPrice},
modelCalculatePrice: ${modelCalculatePrice}
    ''';
  }
}
