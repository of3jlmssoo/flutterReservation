import 'package:flutter/material.dart';

const Color commonBackgroundColor = Color(0xFF2E4F4F);
const Color brightFontColor = Color(0xFFF0F4C3);

const colDivider = SizedBox(height: 10);

// for making test data
const numFacilities = 3;
const numUsers = 3;
const numRecords = 10;
const reservablePeriod = numRecords;

// // テストデータ
// // (テストデータ作成コード修正に伴い無効)9/23から9/27
// final DateTime testDataInitialDate = DateTime(2024, 9, 22, 0, 0);
// // final DateTime testDataInitialDate = DateTime.now();
// final DateTime testDataFirstDate = testDataInitialDate;
// final DateTime testDataLastDate = testDataFirstDate.add(const Duration(days: 6));
// // initialDate: DateTime.now(),
// // firstDate: DateTime.now(),
// // lastDate: DateTime.now().add(const Duration(days: 20)),

// enum Facility implements Comparable<Facility> {
const String k = "台所";
const String m1 = "会議室1";
const String m2 = "会議室2";

enum Facility {
  kitchen(displayName: k, capacity: 5, description: "IH。ただし給電無し。発電機持ち込み必要\n水道無し。外に井戸あり\nイス無し"),
  mtgR1(displayName: m1, capacity: 50, description: "畳部屋(1畳)。窓無し、冷暖房無し"),
  mtgR2(displayName: m2, capacity: 1, description: "2500平米。床抜けあり注意");

  const Facility({
    required this.displayName,
    required this.capacity,
    required this.description,
  });

  final String displayName;
  final int capacity;
  final String description;

  Facility getF(String f) {
    switch (f) {
      case "kitchen":
        return Facility.kitchen;
      case "mtgR1":
        return Facility.mtgR1;
      case "mtgR2":
        return Facility.mtgR2;
      default:
        return Facility.kitchen;
    }
  }

  String getFname(Facility facility) {
    switch (facility) {
      case Facility.kitchen:
        return "kitchen";
      case Facility.mtgR1:
        return "mtgR1";
      case Facility.mtgR2:
        return "mtgR2";
    }
  }

  // int get carbonFootprint => (description / capacity).round();
  // bool get isTwoWheeled => this == Facility.bicycle;
  // @override
  // int compareTo(Facility other) => carbonFootprint - other.carbonFootprint;
}

Facility getFacilitybyDisplayName(String f) {
  switch (f) {
    case k:
      return Facility.kitchen;
    case m1:
      return Facility.mtgR1;
    case m2:
      return Facility.mtgR2;
    default:
      return Facility.kitchen;
  }
}
