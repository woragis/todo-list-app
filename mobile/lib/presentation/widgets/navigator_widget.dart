import 'package:flutter/material.dart';

class NavigatorWidget extends StatelessWidget {
  final int pageIndex;
  final List<Map<String, Object>> pagesData;

  const NavigatorWidget({
    super.key,
    required this.pagesData,
    required this.pageIndex,
    required GlobalKey<NavigatorState> navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        pagesData.length,
        (index) => Offstage(
          offstage: pageIndex != index,
          child: pagesData[index]['page'] as Widget,
        ),
      ),
    );
  }
}
