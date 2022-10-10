import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/model/model.dart';

class Home extends BaseWidget {
  const Home({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _HomeState();
  }
}

class _HomeState extends BaseWidgetState<Home> {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Post> listPost = [
    Post(
        index: 0,
        url:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png",
        posterName: "Full Name 1",
        status: POSTSTATUS.PUBLIC),
    Post(
        index: 1,
        url:
            "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80",
        posterName: "Full Name 2",
        status: POSTSTATUS.PUBLIC),
    Post(
        index: 2,
        url:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcN2P5YcOKn24rv1071WX1cQujWc1BXQRRcw&usqp=CAU",
        posterName: "Full Name 3",
        status: POSTSTATUS.PUBLIC),
    Post(
        index: 3,
        url:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFU7U2h0umyF0P6E_yhTX45sGgPEQAbGaJ4g&usqp=CAU",
        posterName: "Full Name 4",
        status: POSTSTATUS.PUBLIC),
    Post(
        index: 4,
        url:
            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
        posterName: "Full Name 5",
        status: POSTSTATUS.PUBLIC),
    Post(
        index: 5,
        url:
            "https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg",
        posterName: "Full Name 6",
        status: POSTSTATUS.PUBLIC),
  ];

  List<Contact> listContact = [
    Contact(id: "Id1", name: "Ami 1", url: "https://picsum.photos/200"),
    Contact(id: "Id2", name: "Ami 2", url: "https://picsum.photos/200"),
    Contact(id: "Id3", name: "Ami 3", url: "https://picsum.photos/200"),
    Contact(id: "Id4", name: "Ami 4", url: "https://picsum.photos/200"),
    Contact(id: "Id5", name: "Ami 5", url: "https://picsum.photos/200"),
    Contact(id: "Id6", name: "Ami 6", url: "https://picsum.photos/200"),
    Contact(id: "Id7", name: "Ami 7", url: "https://picsum.photos/200"),
  ];

  Widget get searchWidget => Container(
        margin: EdgeInsets.all(xx(2)),
        height: yy(100),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 225, 226, 230), width: 0.33),
            color: const Color.fromARGB(255, 239, 240, 244),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
          autofocus: false,
          onChanged: (value) {
            rebuildState();
          },
          controller: textEditingController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: Offstage(
              offstage: textEditingController.text.isEmpty,
              child: InkWell(
                onTap: () {
                  textEditingController.clear();
                  // _search('');
                  // setState(() {});
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.greenAccent,
                ),
              ),
            ),
            border: InputBorder.none,
            hintText: 'Cherchez',
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      );

  @override
  void dispose() {
    textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget get head => c(
      h: yy(100),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: c(
                  alig: Alignment.centerLeft,
                  child: FlutterLogo(
                    size: xx(20),
                  )),
            ),
          ),
          c(color: Colors.black, w: xx(0.5)),
          Flexible(
            flex: 2,
            child: c(
              alig: Alignment.centerLeft,
              child: txtw("Home", size: xx(15), fontWeight: FontWeight.bold),
            ),
          ),
          c(color: Colors.black, w: xx(0.5)),
          Flexible(
              flex: 1, child: c(alig: Alignment.center, child: searchWidget)),
        ],
      ));

  Widget get profil => CircleAvatar(
        child: FlutterLogo(size: xx(40)),
        backgroundColor: bc(),
      );

  Widget avatar({required String url}) => CircleAvatar(
        child: imageFromCachedNetworkImage(
            url: url, h: yy(80), w: xx(80), shape: BoxShape.circle),
        backgroundColor: bc(),
      );

  Widget get leftHead => c(
      // topM: yy(2),
      h: yy(300),
      child: Stack(
        children: [
          Positioned(
            right: xx(0),
            top: yy(0),
            child: c(
              alig: Alignment.bottomCenter,
              w: xx(200),
              h: yy(300),
              color: Colors.grey[50],
              child: const Center(
                child: TextField(
                  maxLength: 200,
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Speak your mind ...",
                    // contentPadding: EdgeInsets.only(left: xx(3), top: yy(6)),
                  ),
                ),
              ),
            ),
          ),
          Positioned(top: yy(10), left: xx(0), child: profil),
          Positioned(
              bottom: yy(0), left: xx(80), child: const Icon(Icons.image))
        ],
      ));
  Widget postUI(
      {required String name, required String status, required String img}) {
    return c(
      h: yy(800),
      w: xx(350),
      // color: Colors.red,
      alig: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dv,
          c(
              h: yy(200),
              // w: xx(300),
              color: Colors.white,
              // alig: Alignment.centerLeft,
              child: ListTile(
                leading: profil,
                title: txtw(name, size: xx(20), fontWeight: FontWeight.w500),
                subtitle: statusPost(
                    txt: status,
                    iconData: Icons.wifi_tethering_error_rounded_outlined),
                // trailing: txtw("2022/10/10"),
              )),
          Expanded(
            child: myNetworkImage(
              fit: BoxFit.fill,
              url: img,
            ),

            //   ""),
          ),
        ],
      ),
    );
  }

  Widget get postBttn => c(
      h: yy(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          c(
              color: Colors.blue,
              h: yy(80),
              w: xx(60),
              rightM: xx(2),
              alig: Alignment.center,
              child: txtw("Poster"),
              borderRadius: BorderRadius.circular(xx(2))),
        ],
      ));

  Widget get dvHere => Divider(
        endIndent: xx(80),
        indent: xx(40),
      );

  Widget statusPost({required String txt, required IconData iconData}) {
    return Row(
      children: [
        Icon(iconData),
        SizedBox(width: xx(2)),
        txtw(txt, fontWeight: FontWeight.w700),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bc(),
        body: Column(
          children: [
            head,
            Expanded(
              child: Row(
                children: [
                  dv,
                  Flexible(
                      flex: 1,
                      child: c(
                        alig: Alignment.centerLeft,
                        child: Column(
                          children: [
                            leftHead,
                            dv,
                            postBttn,
                            dv,
                            Expanded(
                                child: c(
                              topM: yy(300),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  holderBox(
                                      icon: Icons.home,
                                      txt: "Home",
                                      onPointerDown: (t) {}),
                                  dvHere,
                                  holderBox(
                                      icon: Icons.chat,
                                      txt: "Message",
                                      onPointerDown: (t) {}),
                                  dvHere,
                                  holderBox(
                                      icon: Icons.person,
                                      txt: "Profile",
                                      onPointerDown: (t) {}),
                                  dvHere,
                                  holderBox(
                                      icon: Icons.settings,
                                      txt: "Settings",
                                      onPointerDown: (t) {}),
                                ],
                              ),
                            )),
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        c(color: Colors.black, w: xx(0.5)),
                        Expanded(
                            child: c(
                                // color: Colors.blue,
                                bottomM: yy(20),
                                alig: Alignment.center,
                                child: ListView.builder(
                                  itemCount: listPost.length,
                                  controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    Post p = listPost[index];
                                    return postUI(
                                        name: p.posterName,
                                        status: p.status.name,
                                        img: p.url);
                                  },
                                ))),
                        c(color: Colors.black, w: xx(0.5)),
                      ],
                    ),
                  ),
                  dv,
                  Flexible(
                    flex: 1,
                    child: c(
                      // color: Colors.orange,
                      alig: Alignment.center,
                      child: Column(
                        children: [
                          txtw("Contacts",
                              size: xx(15), fontWeight: FontWeight.bold),
                          Expanded(
                              child: ListView.builder(
                            itemCount: listContact.length,
                            itemBuilder: (context, index) {
                              Contact contact = listContact[index];
                              return Column(
                                children: [
                                  c(
                                      h: yy(100),
                                      allM: xx(2),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          avatar(url: contact.url),
                                          SizedBox(
                                            width: xx(10),
                                          ),
                                          txtw(contact.name, size: xx(15))
                                        ],
                                      )),
                                  const Divider(),
                                ],
                              );
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
