class Item {
  int id;
  String title;
  String description;
  int date;
  int done;
  Item(this.id, this.title, this.description, this.date, this.done);
  Item.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res["title"],
        description = res["description"],
        date = res["date"],
        done = res["done"];

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'done': done,
    };
  }
}
