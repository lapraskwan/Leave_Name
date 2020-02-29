class Transaction {
  int transactionId;
  String title;
  int userId;
  DateTime initiatedDateTime;
  double amount;
  int floor;
  int teamId;
  int userApproved;
  DateTime userApprovedDatetime;
  int chairApproved;
  DateTime chairApprovedDatetime;
  String status;
  DateTime completedDatetime;
  String floorName;

  Transaction({
    this.transactionId,
    this.title,
    this.userId,
    this.initiatedDateTime,
    this.amount,
    this.floor,
    this.teamId,
    this.userApproved,
    this.userApprovedDatetime,
    this.chairApproved,
    this.chairApprovedDatetime,
    this.status,
    this.completedDatetime,
    this.floorName,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : transactionId = json['transaction_id'],
        title = json['title'],
        userId = json['user_id'],
        initiatedDateTime = DateTime.parse(json['initiated_datetime']),
        amount = json['amount'].toDouble(),
        floor = json['floor'],
        teamId = json['team_id'],
        userApproved = json['user_approved'],
        userApprovedDatetime = json['user_approved_datetime'] == null ? null : DateTime.parse(json['user_approved_datetime']),
        chairApproved = json['chair_approved'],
        chairApprovedDatetime = json['chair_approved_datetime'] == null ? null : DateTime.parse(json['chair_approved_datetime']),
        status = json['status'],
        completedDatetime = json['completed_datetime'] == null ? null : DateTime.parse(json['completed_datetime']),
        floorName = json['floor_name'];
}
