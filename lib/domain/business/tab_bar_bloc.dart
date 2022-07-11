import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

enum TabOption { all, complete, incomplete }

abstract class TabBarEvent {
  TabOption tabOption = TabOption.all;
}

class SwitchTabEvent extends TabBarEvent {
  final TabOption option;
  SwitchTabEvent({required this.option}) {
    tabOption = option;
  }

  @override
  String toString() {
    return "SwitchTabEvent(option: ${option.name})";
  }
}

class TabBarCubit extends Cubit<TabBarEvent> {
  TabBarCubit() : super(SwitchTabEvent(option: TabOption.all));

  void switchTab(int index) {
    final TabBarEvent event;
    switch (index) {
      case 1:
        {
          event = SwitchTabEvent(option: TabOption.complete);
          break;
        }
      case 2:
        {
          event = SwitchTabEvent(option: TabOption.incomplete);
          break;
        }
      default:
        {
          event = SwitchTabEvent(option: TabOption.all);
          break;
        }
    }
    emit(event);
  }

  @override
  void onChange(Change<TabBarEvent> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('$error, $stackTrace');
    }
    super.onError(error, stackTrace);
  }
}
