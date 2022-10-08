import 'dart:developer';

import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  BaseWidgetState createState() {
    return getState();
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    log("main initState");
    WidgetsBinding.instance!.addObserver(this);
    onCreate();
    super.initState();
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

  Future toPage(Widget w) {
    log("Move to Page=======================>${w.toStringShallow()}");
    // return Navigator.of(context).push(MaterialPageRoute(builder: (con) {
    //   return w;
    // }));
    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: "/${w.toStringShallow()}"),
        builder: (context) => w,
      ),
    );
  }

  void popUntil(String name) {
    log("pop until  Page=======================>$name");
    Navigator.of(context).popUntil(ModalRoute.withName("/$name"));
  }

  void jumpToPagePop(Widget w) {
    backHome();
    toPage(w);
  }

  Future jumpToPage(Widget w) {
    log("Jump to Page=======================>${w.toStringShallow()}");

    // Navigator.of(context).popUntil((route) => false)

    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        settings: RouteSettings(name: "/${w.toStringShallow()}"),
        builder: (context) => w,
      ),
    );
  }

  void backHome() {
    Navigator.popUntil(context, (Route route) {
      return !route.navigator!.canPop();
    });
  }

  void jumpCleanToPage(Widget w) {
    backHome();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (con) {
      return w;
    }));
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
}
