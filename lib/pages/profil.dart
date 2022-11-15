import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/model/model.dart';

class Profil extends BaseWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _ProfilState();
  }
}

class _ProfilState extends BaseWidgetState<Profil> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  List<Posts> posts = [];
  List<Friends> friends = [];

  getContacts() async {
    getMap("friends", {"userID": user!.id}, (callback) {
      // log(callback.toString());
      for (var f in (callback['data'] as List).reversed) {
        Friends fr = Friends.fromJson(f);
        friends.add(fr);
        rebuildState();
      }
    });
  }

  getData() async {
    posts.clear();
    getMap("posts", {"id": user!.id}, (callback) {
      for (var p in (callback['data'] as List).reversed) {
        Posts post = Posts.fromJson(p);
        posts.add(post);
        rebuildState();
      }
    });
  }

  chageName() async {
    var body = {"id": "", "email": ""};
    postMap("users", body, (callback) {});
  }

  @override
  void initState() {
    getData();
    getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget amiProfil({required Friends friend}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: c(
        h: yy(220),
        w: xx(80),
        // color: Colors.blue,
        child: Column(
          children: [
            Expanded(child: myNetworkImage(url: "https://picsum.photos/200")),
            txtw(friend.name ?? "", size: xx(10), fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Listener(
                      onPointerDown: (event) {
                        showDataAlert();
                      },
                      child: c(
                          h: yy(80),
                          w: xx(80),
                          alig: Alignment.center,
                          border: Border.all(
                              color: const Color.fromARGB(221, 175, 169, 169),
                              width: 1),
                          borderRadius: BorderRadius.circular(xx(10)),
                          child: txtw("Modifier",
                              size: xx(10), fontWeight: FontWeight.bold)),
                    ),
                  )),
            ],
          ),
        ),
        c(
            alig: Alignment.centerLeft,
            leftM: xx(10),
            child: txtw(user?.name, fontWeight: FontWeight.bold, size: xx(15))),
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
        c(
            alig: Alignment.centerLeft,
            leftM: xx(10),
            child: txtw("${friends.length} amis",
                fontWeight: FontWeight.bold, size: xx(10))),
        const Divider(),
      ],
    );
  }

  showDataAlert() {
    _controller.text = user?.name;
    showDialog(
        context: context,
        builder: (context) {
          return c(
            h: sh(),
            w: sw(),
            color: Colors.transparent,
            alig: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                c(
                    h: yy(1300),
                    w: xx(500),
                    color: Colors.white,
                    child: Column(
                      children: [
                        c(
                            h: yy(100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: (() => pop()),
                                    icon: const Icon(
                                      Icons.close,
                                    )),
                                txtw("Modifier Profile", size: xx(15)),
                                Listener(
                                  onPointerDown: (event) {
                                    if (_controller.text != user?.name) {}
                                  },
                                  child: c(
                                      h: yy(80),
                                      w: xx(80),
                                      boxShape: BoxShape.circle,
                                      color: Colors.blue,
                                      // child: txtw("Fini", color: Colors.white),
                                      child: const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            )),
                        c(
                            h: yy(650),
                            // w: xx()
                            // color: Colors.yellow,
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
                                          border: Border.all(
                                              color: Colors.white,
                                              width: xx(2)),
                                          shape: BoxShape.circle),
                                      child: imageFromCachedNetworkImage(
                                          h: xx(200),
                                          w: xx(200),
                                          url:
                                              "https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500"),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                              hintText: 'Entrer le nom',
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
          // AlertDialog(

          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(
          //         20.0,
          //       ),
          //     ),
          //   ),
          //   contentPadding: const EdgeInsets.only(
          //     top: 10.0,
          //   ),
          //   title: const Text(
          //     "Create ID",
          //     style: TextStyle(fontSize: 24.0),
          //   ),
          //   content: SizedBox(
          //     height: 400,
          //     child: SingleChildScrollView(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: <Widget>[
          //           const Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text(
          //               "Mension Your ID ",
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.all(8.0),
          //             child: const TextField(
          //               decoration: InputDecoration(
          //                   border: OutlineInputBorder(),
          //                   hintText: 'Enter Id here',
          //                   labelText: 'ID'),
          //             ),
          //           ),
          //           Container(
          //             width: double.infinity,
          //             height: 60,
          //             padding: const EdgeInsets.all(8.0),
          //             child: ElevatedButton(
          //               onPressed: () {
          //                 Navigator.of(context).pop();
          //               },
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Colors.black,
          //                 // fixedSize: Size(250, 50),
          //               ),
          //               child: const Text(
          //                 "Submit",
          //               ),
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.all(8.0),
          //             child: const Text('Note'),
          //           ),
          //           const Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: Text(
          //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
          //               ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
          //               ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
          //               ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
          //               'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
          //               ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
          //               style: TextStyle(fontSize: 12),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bc(),
      appBar: AppBar(
        leading: const SizedBox(),
        // backgroundColor: b,
        title:
            c(alig: Alignment.centerLeft, child: txtw("Profile", size: xx(15))),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          leftBar,
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      child: c(
                          // color: Colors.blue,
                          bottomM: yy(20),
                          alig: Alignment.center,
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
                          )))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              // color: Colors.white,
              alignment: Alignment.topCenter,
              child: c(
                h: yy(700),
                w: xx(400),
                allM: yy(20),
                borderRadius: BorderRadius.circular(xx(20)),
                color: Colors.white,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    txtw(
                      "Amis (${friends.length})",
                      size: xx(15),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: yy(10),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          Friends f = friends[index];
                          return amiProfil(friend: f);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
