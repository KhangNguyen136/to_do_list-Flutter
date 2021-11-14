class MyNotification {
  int id;
  String title;
  String descript;
  int date;
  int viewed;
  MyNotification(this.id, this.title, this.descript, this.date, this.viewed);
  MyNotification.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res["title"],
        descript = res['descript'],
        date = res["date"],
        viewed = res["viewed"];

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'descript': descript,
      'date': date,
      'viewed': viewed,
    };
  }
}
