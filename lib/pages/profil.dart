import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/data/fakeData.dart';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget amiProfil() {
    return c(
      h: yy(220),
      w: xx(80),
      // color: Colors.blue,
      child: Column(
        children: [
          Expanded(child: myNetworkImage(url: "https://picsum.photos/200")),
          txtw("contact name", size: xx(10), fontWeight: FontWeight.bold),
        ],
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
                child: c(
                    h: yy(500),
                    w: xx(800),
                    child: myNetworkImage(
                      url:
                          "https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500",
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Positioned(
                top: yy(320),
                left: xx(-100),
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
              Positioned(
                  top: yy(530),
                  right: xx(10),
                  child: c(
                      h: yy(80),
                      w: xx(80),
                      alig: Alignment.center,
                      border: Border.all(
                          color: const Color.fromARGB(221, 175, 169, 169),
                          width: 1),
                      borderRadius: BorderRadius.circular(xx(10)),
                      child: txtw("Modifier",
                          size: xx(10), fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        c(
            alig: Alignment.centerLeft,
            leftM: xx(10),
            child:
                txtw("User name", fontWeight: FontWeight.bold, size: xx(15))),
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
            child: txtw("360 amis", fontWeight: FontWeight.bold, size: xx(10))),
        const Divider(),
      ],
    );
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
                            itemCount: listPost.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              Post p = listPost[index];
                              if (index == 0) {
                                return topWiget();
                              }
                              return postUI(
                                  name: p.posterName,
                                  status: p.status.name,
                                  img: p.url);
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
                      "Amis (360)",
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
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return amiProfil();
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
