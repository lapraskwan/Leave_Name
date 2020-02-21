import './user.dart';

class Team {
  String name;
  List<User> teamCaps;
  List<User> teammates;
  String emoji;

  Team({
    this.name,
    this.teamCaps,
    this.teammates,
    this.emoji,
  });
}