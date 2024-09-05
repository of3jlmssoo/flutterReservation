import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpods.g.dart';

final log = Logger('riverpods');

@Riverpod(keepAlive: true)
class Example extends _$Example {
  @override
  int build() {
    return 0;
  }

  // Add methods to mutate the state
  int setToOne() {
    state = 1;
    log.info(state);
    return state;
  }

  int setToZero() {
    state = 0;
    log.info(state);
    return state;
  }
}
