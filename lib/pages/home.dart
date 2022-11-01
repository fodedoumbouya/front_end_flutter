import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/data/fakeData.dart';
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

  // Widget get searchWidget => Container(
  //       margin: EdgeInsets.all(xx(2)),
  //       height: yy(100),
  //       decoration: BoxDecoration(
  //           border: Border.all(
  //               color: const Color.fromARGB(255, 225, 226, 230), width: 0.33),
  //           color: const Color.fromARGB(255, 239, 240, 244),
  //           borderRadius: BorderRadius.circular(12)),
  //       child: TextField(
  //         autofocus: false,
  //         onChanged: (value) {
  //           rebuildState();
  //         },
  //         controller: textEditingController,
  //         decoration: InputDecoration(
  //           prefixIcon: const Icon(
  //             Icons.search,
  //             color: Colors.grey,
  //           ),
  //           suffixIcon: Offstage(
  //             offstage: textEditingController.text.isEmpty,
  //             child: InkWell(
  //               onTap: () {
  //                 textEditingController.clear();
  //                 // _search('');
  //                 // setState(() {});
  //               },
  //               child: const Icon(
  //                 Icons.cancel,
  //                 color: Colors.greenAccent,
  //               ),
  //             ),
  //           ),
  //           border: InputBorder.none,
  //           hintText: 'Cherchez',
  //           hintStyle: const TextStyle(color: Colors.grey),
  //         ),
  //       ),
  //     );

  @override
  void dispose() {
    textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget get head => c(
      h: yy(100),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          color: bc(),
        ),
      ],
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
          // c(color: Colors.black, w: xx(0.5)),
          Flexible(
            flex: 3,
            child: c(
              alig: Alignment.centerLeft,
              child: txtw("Home", size: xx(15), fontWeight: FontWeight.bold),
            ),
          ),
          // c(color: Colors.black, w: xx(0.5)),
          // Flexible(
          //     flex: 1, child: c(alig: Alignment.center, child: searchWidget)),
        ],
      ));

  Widget avatar({required String url}) => CircleAvatar(
        child: imageFromCachedNetworkImage(
            url: url, h: yy(80), w: xx(80), shape: BoxShape.circle),
        backgroundColor: bc(),
      );

  Widget get leftHead => c(
      // topM: yy(2),
      h: yy(400),
      color: Colors.white,
      leftM: xx(40),
      rightM: xx(40),
      topM: xx(10),
      boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: xx(1),
            offset: const Offset(1, 1)),
      ],
      child: Column(
        children: [
          Expanded(
            child: TextField(
              maxLength: 200,
              maxLines: 7,
              // cursorHeight: xx(40),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Speak your mind ...",
                hintStyle: TextStyle(fontSize: xx(20)),
                contentPadding: EdgeInsets.only(left: xx(10), top: yy(0)),
              ),
            ),
          ),
          c(
            h: yy(90),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.photo),
                postBttn,
              ],
            ),
          ),
        ],
      ));

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

  // Widget get dvHere => Divider(
  //       endIndent: xx(80),
  //       indent: xx(40),
  //     );

  @override
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
            SizedBox(
              height: yy(9),
            ),
            Expanded(
              child: Row(
                children: [
                  // dv,
                  leftBar,
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        // c(color: Colors.black, w: xx(0.5)),
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
                                    if (index == 0) {
                                      return leftHead;
                                    }
                                    return postUI(
                                        name: p.posterName,
                                        status: p.status.name,
                                        img: p.url);
                                  },
                                ))),
                        // c(color: Colors.black, w: xx(0.5)),
                      ],
                    ),
                  ),
                  // dv,
                  Flexible(
                    flex: 1,
                    child: c(
                      // color: Colors.orange,
                      topM: yy(100),
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
                                      h: yy(80),
                                      allM: xx(2),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          avatar(url: contact.url),
                                          SizedBox(
                                            width: xx(10),
                                          ),
                                          txtw(contact.name, size: xx(10))
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
