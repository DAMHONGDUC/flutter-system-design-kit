import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../index.dart';

class SdBlocObserverV5 extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      SdLogV5.printWarning(
        '[BLOC] ==> ${bloc.runtimeType} created',
        showMsgWrap: false,
      );
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      SdLogV5.printWarning(
        '[BLOC] ==> ${bloc.runtimeType}: [${change.currentState.runtimeType}] --> [${change.nextState.runtimeType}]',
        showMsgWrap: false,
      );
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      SdLogV5.printWarning(
        '[BLOC] ==> $event is added to ${bloc.runtimeType}',
        showMsgWrap: false,
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      SdLogV5.printWarning(
        '[BLOC] ==> ${bloc.runtimeType} has errors. $error',
        showMsgWrap: false,
      );
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      SdLogV5.printWarning(
        '[BLOC] ==> ${bloc.runtimeType} is closed',
        showMsgWrap: false,
      );
    }
  }
}
