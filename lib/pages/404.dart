import 'package:flutter/material.dart';
import 'package:front_end_flutter/base/base_widget.dart';

class Error404 extends BaseWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _Error404State();
  }
}

class _Error404State extends BaseWidgetState<Error404> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: txtw("ERROR 404", size: xx(60)),
      ),
    );
  }
}
