import 'package:flutter/cupertino.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

class HomeBottomWidget extends StatefulWidget {
  const HomeBottomWidget({super.key});

  @override
  State<HomeBottomWidget> createState() => _HomeBottomWidgetState();
}

class _HomeBottomWidgetState extends State<HomeBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: 'home_bottom'.png3x),
      ],
    );
  }
}
