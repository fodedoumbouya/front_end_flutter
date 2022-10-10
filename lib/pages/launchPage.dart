import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';

class LaunchPage extends BaseWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _LaunchPageState();
  }
}

class _LaunchPageState extends BaseWidgetState<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
