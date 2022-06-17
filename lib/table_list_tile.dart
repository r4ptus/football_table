import 'package:flutter/material.dart';

class TableListTile extends StatelessWidget {
  const TableListTile({Key? key, required this.place, required this.name, required this.points, required this.td}) : super(key: key);

  final String place;
  final String name;
  final String points;
  final String td;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text("$place.")),
      const Spacer(),
      Text(name),
      const Spacer(),
      Text(points),
      const Spacer(),
      Text(td),
      const Spacer()
    ],);
  }
}