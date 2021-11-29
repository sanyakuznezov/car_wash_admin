

  import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocTableOrder{

    StreamController<int> _streamController=StreamController<int>();
    StreamController<int> _streamControllerEdit=StreamController<int>();
    StreamController<double> _streamControllerScroll=StreamController<double>();
    StreamController<double> _streamControllerOffsetFeedback=StreamController<double>();
   StreamController<Map> _streamControllerDrag=StreamController<Map>();
    StreamController<String> _streamControllerTimer=StreamController<String>();
    StreamSink get streamSinkTime=>_streamControllerTimer.sink;
    StreamSink get streamSinkDrag=>_streamControllerDrag.sink;
    StreamSink get streamSinkFeedback=>_streamControllerOffsetFeedback.sink;
    StreamSink get streamSinkScroll=> _streamControllerScroll.sink;
    StreamSink get streamSinkEdit=> _streamControllerEdit.sink;
    StreamSink get streamSink => _streamController.sink;
    final _dyx=BehaviorSubject<DragTargetDetails>();
    final _timeSteram=BehaviorSubject<String>();
    final _dragStrem=BehaviorSubject<Map>();
    final _counterStream = BehaviorSubject<int>();
    final _editStream = BehaviorSubject<int>();
    final _dyStream = BehaviorSubject<double>();
    final _feedBack= BehaviorSubject<double>();
    Sink get _getDYX=>_dyx.sink;
    Sink get _timeSink=>_timeSteram.sink;
    Sink get _dragSink=>_dragStrem.sink;
    Sink get _sendXYFeedback=>_feedBack.sink;
    Sink get _stateEditSink=>_editStream.sink;
    Sink get _addDY => _dyStream.sink;
    Sink get _addValue => _counterStream.sink;
    Stream get getDYXScroll=>_dyx.stream;
    Stream get streamTimer=>_timeSteram.stream;
    Stream get dragS=>_dragStrem.stream;
    Stream get stateDYFeedback=>_feedBack.stream;
    Stream get editState=>_editStream.stream;
    Stream get stateDY => _dyStream.stream;
    Stream get stateTime => _counterStream.stream;



    BlocTableOrder(){
    _streamController.stream.listen(_stateTime);
    _streamControllerEdit.stream.listen(_stateEdit);
    _streamControllerScroll.stream.listen(_addScrollDy);
    _streamControllerOffsetFeedback.stream.listen(_getDYFeedBack);
    _streamControllerDrag.stream.listen(_sendMapDrag);
     _streamControllerTimer.stream.listen(_fromTimer);
    }

    void sendDYX(offset){
      _getDYX.add(offset);
    }

    void _sendMapDrag(map){
      _dragSink.add(map);
    }

    void _fromTimer(value){
      _timeSink.add(value);
    }

    void _addScrollDy(y){
      _addDY.add(y);
    }

    void _stateEdit(state){
      _stateEditSink.add(state);
    }

    void _stateTime(state){
      _addValue.add(state);
    }

    void _getDYFeedBack(value){
      _sendXYFeedback.add(value);
    }


    void diponseScrollStream(){
     _streamControllerScroll.close();
     _dyStream.close();
   }
    void diponseEditStream(){
      _streamControllerEdit.close();
      _editStream.close();
    }
   void disponse(){
       _streamController.close();
       _counterStream.close();

    }
    void disponseFeedBackStream(){
      _streamControllerOffsetFeedback.close();
      _feedBack.close();
    }

    void disponseDragStream(){
      _streamControllerDrag.close();
      _dragStrem.close();
    }
    void disponseTimerStream(){
      _streamControllerTimer.close();
      _timeSteram.close();
    }


}