import 'package:test/test.dart';
import 'package:todo_list_project/domain/business/tab_bar_bloc.dart';

void main() {
  TabBarCubit? tabBarCubit;
  group('Tab Bar Testing', () {
    setUp(() {
      tabBarCubit = TabBarCubit();
    });
    tearDown(() {
      tabBarCubit?.close();
    });
    test(
        'the initial state for the Tab Bar Cubit is Tab Bar State SwitchTabEvent(option: TabOption.all)',
        () {
      expect(tabBarCubit?.state.tabOption, TabOption.all);
    });

    test('emit state tab bar cubit to Complete Tab', () {
      tabBarCubit?.emit(SwitchTabEvent(option: TabOption.complete));
      expect(tabBarCubit?.state.tabOption, TabOption.complete);
    });
  });
}
