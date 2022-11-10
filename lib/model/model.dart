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

class Posts {
  Posts({
    this.id,
    this.userID,
    this.title,
    this.content,
    this.statut,
    this.username,
    this.userpicture,
  });
  String? id;
  String? userID;
  String? title;
  String? content;
  String? statut;
  String? username;
  String? userpicture;

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    title = json['title'];
    content = json['content'];
    statut = json['statut'];
    username = json['username'];
    userpicture = json['userpicture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userID'] = userID;
    _data['title'] = title;
    _data['content'] = content;
    _data['statut'] = statut;
    _data['username'] = username;
    _data['userpicture'] = userpicture;
    return _data;
  }
}

class Contact {
  String id;
  String name;
  String url;
  Contact({required this.id, required this.name, required this.url});
}

enum POSTSTATUS { PUBLIC, PRIVATE, ONLYFRIENDS }

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.picture,
    required this.lastLogin,
    required this.createdDate,
    required this.statut,
  });
  var id;
  var name;
  var email;
  var password;
  var picture;
  var lastLogin;
  var createdDate;
  var statut;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    picture = json['picture'];
    lastLogin = json['last_login'];
    createdDate = json['created_date'];
    statut = json['statut'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['picture'] = picture;
    _data['last_login'] = lastLogin;
    _data['created_date'] = createdDate;
    _data['statut'] = statut;
    return _data;
  }
}
