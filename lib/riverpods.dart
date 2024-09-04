import 'package:reservations2/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpods.g.dart';

@Riverpod(keepAlive: true)
class Example extends _$Example {
  @override
  int build() {
    return 0;
  }

  // Add methods to mutate the state
  int setToOne() {
    state = 1;
    print(state);
    return state;
  }

  int setToZero() {
    state = 0;
    print(state);
    return state;
  }
}
