import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/model/model.dart';
import 'package:front_end_flutter/utils/network/network_util.dart';

class FriendView extends BaseWidget {
  Object? arguments;

  FriendView({Key? key, this.arguments}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _FriendViewState();
  }
}

class _FriendViewState extends BaseWidgetState<FriendView> {
  List<Posts> posts = [];
  List<Friends> friends = [];

  String friendId = "";
  String name = "";

  bool showAdd = false;

  final ScrollController _scrollController = ScrollController();

  getData() async {
    posts.clear();

    getMap("posts", {"id": friendId}, (callback) {
      for (var p in (callback['data'] as List).reversed) {
        Posts post = Posts.fromJson(p);
        posts.add(post);
        rebuildState();
      }
    });
  }

  getContacts() async {
    getMap("friends", {"userID": user!.id}, (callback) {
      log(user!.id.toString());
      print(callback.toString());
      showAdd = true;
      for (var f in (callback['data'] as List).reversed) {
        Friends fr = Friends.fromJson(f);
        friends.add(fr);

        print("fr: =======$friendId=====> ${fr.id}");

        if (fr.id == friendId) {
          showAdd = false;
        }
      }
      rebuildState();
    });
  }

  addFriend() {
    var body = {"userID": user?.id, "contactID": friendId};
    postMap("friends", body, (callback) {
      showToast(callback["status_message"]);
      getContacts();
    });
  }

  @override
  void initState() {
    if (widget.arguments != null) {
      friendId = (widget.arguments! as Map)["id"];
      name = (widget.arguments! as Map)["name"];
    }
    getData();
    getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget topWiget() {
    return Column(
      children: [
        c(
          h: yy(650),
          w: xx(800),
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: xx(0),
                left: xx(0),
                right: xx(0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: c(
                      h: yy(500),
                      w: xx(800),
                      child: myNetworkImage(
                        url:
                            "https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500",
                        fit: BoxFit.fitWidth,
                      )),
                ),
              ),
              Positioned(
                top: yy(320),
                left: xx(-100),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: yy(300),
                    width: xx(300),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: xx(2)),
                        shape: BoxShape.circle),
                    child: imageFromCachedNetworkImage(
                        h: xx(200),
                        w: xx(200),
                        url:
                            "https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500"),
                  ),
                ),
              ),
              Positioned(
                  top: yy(530),
                  right: xx(10),
                  child: showAdd
                      ? MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Listener(
                            onPointerDown: (event) {
                              // showDataAlert();
                              addFriend();
                            },
                            child: c(
                                h: yy(80),
                                w: xx(80),
                                alig: Alignment.center,
                                color: Colors.blue,
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        221, 175, 169, 169),
                                    width: 1),
                                borderRadius: BorderRadius.circular(xx(10)),
                                child: txtw("ADD",
                                    color: Colors.white,
                                    size: xx(10),
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : const SizedBox()),
            ],
          ),
        ),
        c(
            alig: Alignment.centerLeft,
            leftM: xx(10),
            child: txtw(name, fontWeight: FontWeight.bold, size: xx(15))),
        SizedBox(
          height: yy(10),
        ),
        c(
            alig: Alignment.centerLeft,
            leftM: xx(10),
            child: txtw(
                "Bio \nje suis moi, un humain qui vit sur la planet terre",
                fontWeight: FontWeight.w300,
                size: xx(10))),
        SizedBox(
          height: yy(20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: c(
          alig: Alignment.topCenter,
          h: sh(),
          w: sw(),
          child: c(
              w: xx(600),
              // color: Colors.red,
              child: ListView.builder(
                itemCount: posts.length + 1,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return topWiget();
                  }
                  index = index == 0 ? index : index - 1;
                  Posts p = posts[index];
                  return postUI(
                      p: p,
                      img:
                          "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg");

                  //  postUI(
                  //     name: p.posterName,
                  //     status: p.status.name,
                  //     img: p.url);
                },
              ))),
    );
  }
}
