import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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
        onPointerDown: onPointerDown,
        child: c(
          h: yy(100),
          w: xx(150),
          child: Row(
            children: [
              Icon(
                icon,
                size: xx(20),
              ),
              txtw(txt, size: xx(20))
            ],
          ),
        ),
      ),
    );
  }

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

  txtw(String t, {Color? color, FontWeight? fontWeight, double? size}) {
    // color ??= const Color.fromRGBO(0, 0, 0, 0.392);
    return Text(
      t,
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
}
