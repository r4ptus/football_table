import 'dart:convert';

Tabelle tableFromJson(String str) => Tabelle.fromJson(json.decode(str));

String tableToJson(Tabelle data) => json.encode(data.toJson());

class Tabelle {
    Tabelle({
        required this.tabelle,
    });

    TabelleChild tabelle;

    factory Tabelle.fromJson(Map<String, dynamic> json) => Tabelle(
        tabelle: TabelleChild.fromJson(json["tabelle"]),
    );

    Map<String, dynamic> toJson() => {
        "tabelle": tabelle.toJson(),
    };
}

class TabelleChild {
    TabelleChild({
        required this.teams,
    });

    List<Team> teams;

    factory TabelleChild.fromJson(Map<String, dynamic> json) => TabelleChild(
        teams: List<Team>.from(json["Team"].map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Team": List<dynamic>.from(teams.map((x) => x.toJson())),
    };
}

class Team {
    Team({
        required this.liga,
        required this.bezeichnung,
        required this.gruppe,
        required this.platz,
        required this.team,
        required this.teamname,
        required this.kuerzel,
        required this.pPlus,
        required this.pMinus,
        required this.tdPlus,
        required this.tdMinus,
    });

    String liga;
    String bezeichnung;
    String gruppe;
    String platz;
    String team;
    String teamname;
    String kuerzel;
    String pPlus;
    String pMinus;
    String tdPlus;
    String tdMinus;

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        liga: json["Liga"],
        bezeichnung: json["Bezeichnung"],
        gruppe: json["Gruppe"],
        platz: json["Platz"],
        team: json["Team"],
        teamname: json["Teamname"],
        kuerzel: json["Kuerzel"],
        pPlus: json["PPlus"],
        pMinus: json["PMinus"],
        tdPlus: json["TDPlus"],
        tdMinus: json["TDMinus"],
    );

    Map<String, dynamic> toJson() => {
        "Liga": liga,
        "Bezeichnung": bezeichnung,
        "Gruppe": gruppe,
        "Platz": platz,
        "Team": team,
        "Teamname": teamname,
        "Kuerzel": kuerzel,
        "PPlus": pPlus,
        "PMinus": pMinus,
        "TDPlus": tdPlus,
        "TDMinus": tdMinus,
    };
}

