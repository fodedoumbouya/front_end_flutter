class Post {
  int index;
  String url;
  String posterName;
  POSTSTATUS status;
  Post(
      {required this.index,
      required this.url,
      required this.posterName,
      required this.status});
}

class Contact {
  String id;
  String name;
  String url;
  Contact({required this.id, required this.name, required this.url});
}

enum POSTSTATUS { PUBLIC, PRIVATE, ONLYFRIENDS }
