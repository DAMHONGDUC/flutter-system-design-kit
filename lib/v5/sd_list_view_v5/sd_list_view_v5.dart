import 'package:flutter/material.dart';

class SdListViewV5 extends StatelessWidget {
  final ScrollController? controller;
  final List<dynamic> items;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const SdListViewV5({
    super.key,
    this.controller,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: padding,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
      separatorBuilder: separatorBuilder ?? (_, _) => const SizedBox.shrink(),
      itemBuilder: itemBuilder,
    );
  }
}
