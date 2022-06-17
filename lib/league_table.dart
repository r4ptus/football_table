import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import 'models/table.dart';

class LeagueTable extends StatefulWidget {
  const LeagueTable({Key? key, required this.teams}) : super(key: key);

  final List<Team> teams;

  @override
  State<LeagueTable> createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable> {
  List<Team> teams = [];
  @override
  void initState() {
    super.initState();
    teams = widget.teams;
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://vereine.football-verband.de/xmltabelle.php5?Liga=${widget.teams.first.liga}'));
    final converter = Xml2Json();

    if (response.statusCode == 200) {
      converter.parse(response.body);
      var json = converter.toParker();
      setState(() {
        teams = tableFromJson(json).tabelle.teams;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: fetchData,
        child: ListView(children: mapTeamsToWidgets(widget.teams)));
  }

  List<Widget> mapTeamsToWidgets(List<Team> teams) {
    final Map<String, List<Team>> dict =
        groupBy(teams, (Team team) => team.gruppe);
    List<Widget> children = [];
    dict.forEach((key, value) {
      children.add(Container(
          color: Colors.red,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              key.contains("Gruppe") ? key : "Gruppe $key",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ))));
      children.add(createTable(value));
    });

    return children;
  }

  Widget createTable(List<Team> value) => Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },
        children: createTableRows(value),
      );

  List<TableRow> createTableRows(List<Team> value) {
    List<TableRow> tmp = [];
    tmp.add(getHeaderRow());

    value.asMap().forEach((index, element) {
      tmp.add(index % 2 == 1 ? getRedRow(element) : getWhiteRow(element));
    });
    return tmp;
  }

  TableRow getHeaderRow() => const TableRow(
          decoration: BoxDecoration(color: Colors.red),
          children: <TableCell>[
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Platz",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Team",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Punkte",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            TableCell(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "TD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
          ]);

  TableRow getWhiteRow(Team team) => TableRow(
      decoration: const BoxDecoration(color: Colors.white),
      children: getTableCells(team));

  TableRow getRedRow(Team team) => TableRow(
      decoration: const BoxDecoration(color: Color(0xffffcdd2)),
      children: getTableCells(team));

  List<TableCell> getTableCells(Team team) => <TableCell>[
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(child: Text(team.platz)))),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(10), child: Text(team.team))),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(child: Text("${team.pPlus}:${team.pMinus}")))),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("${team.tdPlus}:${team.tdMinus}"))),
      ];
}
