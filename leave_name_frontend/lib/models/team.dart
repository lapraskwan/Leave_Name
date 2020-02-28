class Team {
  int teamId;
  String name;
  String emoji;
  String description;

  Team({
    this.teamId,
    this.name,
    this.emoji,
    this.description,
  });

  Team.fromJSON(Map<String, dynamic> json)
      : teamId = json['team_id'],
        name = json['name'],
        description = json['description'],
        emoji = json['emoji'];
}
