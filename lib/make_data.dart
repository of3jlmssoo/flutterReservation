import 'dart:math' as math;

import 'package:logging/logging.dart';

import 'consts.dart';

final log = Logger('make_data');

List<List<int>> makeData() {
  final List<int> originalData = makeFirstData(numRecords);

  final futureData = <List<int>>[
    [...originalData],
    [...originalData],
    [...originalData]
  ];

  return futureData;
}

List<List<int>> makeTentatives(List<List<int>> lst) {
  final len = lst[0].length;
  final numTentatives = len / 10;
  for (int i = 0; i < numTentatives; i++) {
    var pos1 = math.Random().nextInt(len); // position of lst[0][pos1]
    final userA = math.Random().nextInt(numUsers);
    var userB = math.Random().nextInt(numUsers);
    log.info('makeTentatives(1) i $i  pos1 $pos1 userA $userA userB $userB');
    while (userA == userB) {
      userB = math.Random().nextInt(numUsers);
    }
    while (lst[userA][pos1] == numFacilities) {
      pos1 = math.Random().nextInt(len);
    }

    log.info('makeTentatives(2) i $i  pos1 $pos1 userA $userA userB $userB');
    lst[userB][pos1] = lst[userA][pos1];
  }
  return lst;
}

List<int> makeFirstData(int x) {
  // var result = List<int>.empty();
  final result = List.filled(x, 0);
  for (int i = 0; i < x; i++) {
    result[i] = math.Random().nextInt(numFacilities + 1);
  }
  return result;
}

List<List<int>> updateData(List<List<int>> lst) {
  for (int i = 0; i < lst[0].length; i++) {
    log.info('updateData loop $i');
    while (lst[0][i] != 3 && (lst[0][i] == lst[1][i] || lst[0][i] == lst[2][i] || lst[1][i] == lst[2][i])) {
      log.info('updateData while $i ${lst[0][i]} ${lst[1][i]} ${lst[2][i]}');
      if (lst[0][i] == lst[1][i]) {
        lst[1][i] = updateNumber(lst[0][i], numFacilities);
      }
      if (lst[0][i] == lst[2][i]) {
        lst[2][i] = updateNumber(lst[0][i], numFacilities);
      }
      if (lst[1][i] == lst[2][i]) {
        lst[2][i] = updateNumber(lst[1][i], numFacilities);
      }
    }
  }
  return lst;
}

int updateNumber(int i, int numEle) {
  int result = i + math.Random().nextInt(2) + 1;
  if (result >= numFacilities) {
    result = result - 3;
  }
  return result;
}
