import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

import 'package:xml2json/xml2json.dart';

import 'models/table.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Tabelle> futureString;

  Future<Tabelle> fetchString() async {
    final response = await http.get(Uri.parse(
        'https://vereine.football-verband.de/xmltabelle.php5?Liga=VLM'));
    final converter = Xml2Json();

    if (response.statusCode == 200) {
      converter.parse(response.body);
      var json = converter.toParker();
      return tableFromJson(json);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureString = fetchString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Tabelle>(
          future: futureString,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final teams = snapshot.data!.tabelle.teams;

              return IntrinsicWidth(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: mapTeamsToWidgets(teams),
              ));
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  List<Widget> mapTeamsToWidgets(List<Team> teams) {
    final Map<String, List<Team>> dict =
        groupBy(teams, (Team team) => team.gruppe);
    List<Widget> children = [];
    children.add(const Spacer());
    children.add(Container(
        color: Colors.red,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            teams.first.bezeichnung,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ))));
    dict.forEach((key, value) {
      children.add(Container(
          color: Colors.red,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              "Gruppe $key",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ))));
      children.add(DataTable(
        columns: const [
          DataColumn(label: Text('Platz')),
          DataColumn(label: Text('Team')),
          DataColumn(label: Text('Punkte')),
          DataColumn(label: Text('TD')),
        ],
        headingTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.red),
        rows: value
            .map(
              ((element) => DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.red[100]!;
                      }
                      return Colors.white;
                    }),
                    selected: value.indexOf(element) % 2 == 1,
                    cells: <DataCell>[
                      DataCell(Center(child: Text(element.platz))),
                      DataCell(Text(element.team)),
                      DataCell(Center(
                          child: Text("${element.pPlus}:${element.pMinus}"))),
                      DataCell(Text("${element.tdPlus}:${element.tdMinus}")),
                    ],
                  )),
            )
            .toList(),
      ));
    });
    children.add(const Spacer());

    return children;
  }
}
