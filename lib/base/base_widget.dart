import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/model/model.dart';
import 'package:front_end_flutter/utils/constant.dart';
import 'package:front_end_flutter/utils/global.dart';
import 'package:front_end_flutter/utils/network/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/route/routeName.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  BaseWidgetState createState() {
    // ignore: no_logic_in_create_state
    return getState();
  }

  BaseWidgetState getState();
}

User? user;

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  SharedPreferences? prefs;

  @override
  void initState() {
    log("main initState");
    ctxt = context;
    init();
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    getGlobalValue();
  }

  Future getValue({required String key}) async {
    prefs ??= await SharedPreferences.getInstance();

    return prefs!.getString(key) ?? "";
  }

  Future<bool> setValue({required String key, required String value}) async {
    prefs ??= await SharedPreferences.getInstance();
    bool resp = await prefs!.setString(key, value);
    return resp;
  }

  getGlobalValue() async {
    var _tempUser = await getValue(key: userKey);
    if (_tempUser.toString().length > 5) {
      var json = jsonDecode(_tempUser);
      user = User.fromJson(json);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {}
  }

  @override
  void didChangeDependencies() {
    log("didChangeDependencies\n");
    super.didChangeDependencies();
  }

  Future toPage({required String routesName}) {
    return Navigator.pushNamed(context, routesName);
  }

  // void popUntil(String name) {
  //   log("pop until  Page=======================>$name");
  //   Navigator.of(context).popUntil(ModalRoute.withName("/$name"));
  // }

  void jumpToPagePop({required String routesName}) {
    backHome();
    toPage(routesName: routesName);
  }

  Future jumpToPage({required String routesName}) {
    // Navigator.pushNamed(context, RoutesName.SECOND_PAGE);

    return Navigator.pushReplacementNamed(context, routesName);
  }

  void backHome() {
    Navigator.popUntil(context, (Route route) {
      return !route.navigator!.canPop();
    });
  }

  void jumpCleanToPage({required String routesName}) {
    backHome();
    Navigator.pushReplacementNamed(context, routesName);
  }

  richTxt({
    required String txt1,
    required String txt2,
    double? size1,
    double? size2,
    Color? color1,
    Color? color2,
    FontWeight? fontWeight2,
    FontWeight? fontWeight1,
  }) {
    return RichText(
      text: TextSpan(
        text: '$txt1 ',
        style:
            TextStyle(color: color1, fontSize: size1, fontWeight: fontWeight1),
        children: <TextSpan>[
          TextSpan(
              text: txt2,
              style: TextStyle(
                  color: color2, fontSize: size2, fontWeight: fontWeight2)),
          // const TextSpan(text: ' world!'),
        ],
      ),
    );
  }

  Widget get errorImageWidget => SizedBox(
        height: yy(300),
        width: xx(300),
        child: const Center(child: Icon(Icons.error)),
      );
  imageFromCachedNetworkImage({
    required String url,
    double h = 200,
    double w = 200,
    BoxShape shape = BoxShape.circle,
  }) {
    return url.length < 5
        ? errorImageWidget
        : CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                shape: shape,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator(
                    color: bc(), value: downloadProgress.progress),
              );
            },
            errorWidget: (context, url, error) => errorImageWidget,
          );
  }

  Widget statusPost({required String txt, required IconData iconData}) {
    return Row(
      children: [
        Icon(iconData),
        SizedBox(width: xx(2)),
        txtw(txt, fontWeight: FontWeight.w700),
      ],
    );
  }

  Widget get profil => CircleAvatar(
        child: FlutterLogo(size: xx(40)),
        backgroundColor: bc(),
      );

  Widget postUI(
      {required String name, required String status, required String img}) {
    return c(
      h: yy(1300),
      w: xx(330),
      color: Colors.white,
      alig: Alignment.center,
      leftM: xx(40),
      rightM: xx(40),
      bottomM: xx(10),
      topM: xx(10),
      boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: xx(1),
            offset: const Offset(1, 1)),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // dv,
          c(
              h: yy(130),
              child: ListTile(
                leading: profil,
                title: txtw(name, size: xx(15), fontWeight: FontWeight.w500),
                subtitle: statusPost(
                    txt: status,
                    iconData: Icons.wifi_tethering_error_rounded_outlined),
                // trailing: txtw("2022/10/10"),
              )),
          c(
            // color: Colors.red,
            h: yy(140),
            // w: xx(300),
            alig: Alignment.center,
            leftM: xx(45),
            rightM: xx(30),
            child: txtw(
                "bla bla bla bla blaa bla bla bla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla ",
                maxLines: 3,
                color: const Color.fromRGBO(51, 51, 51, 1).withOpacity(0.7),
                size: xx(10)),
          ),
          Expanded(
            // child: c(
            // alig: Alignment.topCenter,
            child: myNetworkImage(
              fit: BoxFit.contain,
              url: img,
              // ),
            ),

            //   ""),
          ),
        ],
      ),
    );
  }

  myNetworkImage({
    required String url,
    //  required  String path ,
    //= "${host}getImage/id/",
    Color? color,
    BoxFit fit = BoxFit.cover,
  }) {
    // log(path + url);
    return url.isEmpty
        ? errorImageWidget
        : CachedNetworkImage(
            imageUrl: url,
            fit: fit,
            color: color,
            colorBlendMode: BlendMode.color,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator(
                    color: Colors.blue, value: downloadProgress.progress),
              );
            },
            errorWidget: (context, url, error) => errorImageWidget,
          );
  }

  Widget holderBox(
      {required IconData icon,
      required String txt,
      required void Function(PointerDownEvent) onPointerDown}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerDown: (event) {
          onPointerDown(event);
          iconTap = txt;
          rebuildState();
        },
        child: c(
          h: yy(100),
          w: xx(150),
          leftM: xx(20),
          topM: yy(10),
          child: Row(
            children: [
              Icon(
                icon,
                size: xx(15),
                color: iconTap == txt ? Colors.blue : Colors.black,
              ),
              SizedBox(
                width: xx(10),
              ),
              txtw(
                txt,
                size: xx(15),
                color: iconTap == txt ? Colors.blue : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get leftBar => Flexible(
      flex: 1,
      child: c(
        alig: Alignment.centerLeft,
        child: Column(
          children: [
            // leftHead,
            // dv,
            // dv,
            Expanded(
                child: c(
              // topM: yy(300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  holderBox(
                      icon: Icons.home,
                      txt: "Home",
                      onPointerDown: (t) {
                        jumpCleanToPage(routesName: RoutesName.HOME_PAGE);
                      }),
                  holderBox(
                      icon: Icons.chat, txt: "Message", onPointerDown: (t) {}),
                  holderBox(
                      icon: Icons.person,
                      txt: "Profile",
                      onPointerDown: (t) {
                        toPage(routesName: RoutesName.PROFIL);
                      }),
                  // dvHere,
                  holderBox(
                      icon: Icons.settings,
                      txt: "Settings",
                      onPointerDown: (t) {}),
                ],
              ),
            )),
          ],
        ),
      ));

  Widget registerWiget(
      {required double h, required double w, required Widget child}) {
    //required List<Widget> widgets
    return c(
        h: yy(h),
        w: xx(w),
        color: bc(),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
        child: child);
  }

  txtw(
    String t, {
    Color? color,
    FontWeight? fontWeight,
    double? size,
    int? maxLines,
  }) {
    // color ??= const Color.fromRGBO(0, 0, 0, 0.392);
    return Text(
      t,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget myForm({
    required TextEditingController editingController,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: editingController,
      autofocus: false,
      obscureText: obscureText,
      validator: (value) {
        if (value!.length < 3) {
          return "$hintText n'est pas correcte ";
        }
        return null;
      },
      decoration: InputDecoration(
        // filled: true,
        hintText: hintText,
        // border: InputBorder.none,
      ),
    );
  }

  Widget get dv => Divider(color: Colors.black, thickness: xx(0.5));
  Color bc() {
    return Theme.of(context).backgroundColor;
  }

  Widget registerBttn(
      {required void Function(PointerDownEvent) onPointerDown,
      required String txt,
      required Color color,
      Color? txtColor}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Listener(
        onPointerDown: onPointerDown,
        child: c(
            color: color,
            alig: Alignment.center,
            child: txtw(txt, color: txtColor)),
      ),
    );
  }

  Widget c(
          {Widget? child,
          double? h,
          double? w,
          double? allM,
          double allP = 0,
          double topM = 0,
          double bottomM = 0,
          double leftM = 0,
          double rightM = 0,
          double radius = 0,
          Alignment? alig,
          Color? color,
          String? image,
          BoxFit? fit = BoxFit.fill,
          Alignment decoAlignment = Alignment.topCenter,
          String imgType = "png",
          // Color c = Colors.transparent,
          BoxShape boxShape = BoxShape.rectangle,
          BorderRadius? borderRadius,
          BoxBorder? border,
          List<BoxShadow>? boxShadow,
          Rect? centerSlice}) =>
      Container(
        alignment: alig,
        margin: allM == null
            ? EdgeInsets.only(
                left: leftM, right: rightM, bottom: bottomM, top: topM)
            : EdgeInsets.all(allM),
        padding: EdgeInsets.all(allP),
        decoration: BoxDecoration(
          color: color,
          shape: boxShape,
          image: image == null
              ? null
              : DecorationImage(
                  image: AssetImage('images/' + image + '.$imgType'),
                  scale: MediaQuery.of(context).devicePixelRatio,
                  centerSlice: centerSlice,
                  fit: fit,
                  alignment: decoAlignment),
          border: border,
          boxShadow: boxShadow,
          borderRadius: boxShape != BoxShape.rectangle
              ? null
              : borderRadius ?? BorderRadius.circular(radius),
        ),
        height: h,
        width: w,
        child: child,
      );

  void pop([Object? o]) {
    Navigator.of(context).pop(o);
  }

  double xx(double x) {
    return sw() / 1080.0 * x;
  }

  double yy(double y) {
    return sh() / 2220 * y;
  }

  rebuildState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    log("build\n");
    // onCreate();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: baseBuild(context),
    );
  }

  double sw() {
    return MediaQuery.of(context).size.width;
  }

  double sh() {
    return MediaQuery.of(context).size.height;
  }

  baseBuild(BuildContext context) {}
  void onCreate() {}

  void postMap(
    String url,
    Map<String, dynamic> body,
    var callback,
    // var errorCallback,
    {
    bool isFile = false,
    String filePath = "",
    bool getFullData = false,
    bool isProfile = false,
  }) async {
    var res = await globalRequest(
      path: url,
      body: body,
      isFile: isFile,
      filePath: filePath,
      isProfile: isProfile,
    );
    callback(res);
  }
}
