import 'package:flutter/material.dart';

const Color commonBackgroundColor = Color(0xFF2E4F4F);
const Color brightFontColor = Color(0xFFF0F4C3);

const colDivider = SizedBox(height: 10);

// for making test data
const numFacilities = 3;
const numUsers = 3;
const numRecords = 5;

// enum Facility implements Comparable<Facility> {
enum Facility {
  kitchen(displayName: "台所", capacity: 5, description: "IH。ただし給電無し。発電機持ち込み必要\n水道無し。外に井戸あり\nイス無し"),
  mtgR1(displayName: "会議室1", capacity: 50, description: "畳部屋(1畳)。窓無し、冷暖房無し"),
  mtgR2(displayName: "会議室2", capacity: 1, description: "2500平米。床抜けあり注意");

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

  // int get carbonFootprint => (description / capacity).round();
  // bool get isTwoWheeled => this == Facility.bicycle;
  // @override
  // int compareTo(Facility other) => carbonFootprint - other.carbonFootprint;
}
