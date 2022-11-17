import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';
import 'package:front_end_flutter/utils/route/routeName.dart';

class Index extends BaseWidget {
  const Index({Key? key}) : super(key: key);
  @override
  BaseWidgetState<BaseWidget> getState() {
    return _IndexState();
  }
}

class _IndexState extends BaseWidgetState<Index> {
  Future<void> login() async {
    if (user == null) {
      jumpToPage(routesName: RoutesName.LOGIN_PAGE);
    } else {
      jumpToPage(routesName: RoutesName.HOME_PAGE);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  check() {
    return super.check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: TweenAnimationBuilder(
                tween: ColorTween(
                    begin: Theme.of(context).primaryColor,
                    end: Theme.of(context).backgroundColor),
                duration: const Duration(milliseconds: 500),
                onEnd: () => login(),
                builder: (_, Color? color, __) {
                  return const SizedBox();
                }),
          ),
        ],
      )),
    );
  }
}
