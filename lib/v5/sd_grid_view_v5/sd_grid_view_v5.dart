import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../index.dart';

class SdGridViewV5 extends StatefulWidget {
  final ScrollController? controller;
  final List<dynamic> items;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  // Grid settings
  final int gridCrossAxisCount;
  final double gridMainAxisSpacing;
  final double gridCrossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final bool canLoadMore;
  final VoidCallback? onLoadMore;

  const SdGridViewV5({
    super.key,
    this.controller,
    required this.items,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.gridCrossAxisCount = 2,
    this.gridMainAxisSpacing = 0,
    this.gridCrossAxisSpacing = 0,
    this.padding,
    this.canLoadMore = false,
    this.onLoadMore,
  });

  @override
  State<SdGridViewV5> createState() => _SdGridViewV5State();
}

class _SdGridViewV5State extends State<SdGridViewV5> {
  late final ScrollController _controller;
  bool _isLoadingTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.onLoadMore == null || !widget.canLoadMore) return;

    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 100 &&
        !_isLoadingTriggered) {
      _isLoadingTriggered = true;
      widget.onLoadMore?.call();
    }
  }

  @override
  void didUpdateWidget(covariant SdGridViewV5 oldWidget) {
    _isLoadingTriggered = false;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grid = CustomScrollView(
      controller: _controller,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: [
        SliverPadding(
          padding: widget.padding ?? EdgeInsets.zero,
          sliver: SliverMasonryGrid.count(
            crossAxisCount: widget.gridCrossAxisCount,
            mainAxisSpacing: widget.gridMainAxisSpacing,
            crossAxisSpacing: widget.gridCrossAxisSpacing,
            childCount: widget.items.length,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        if (widget.canLoadMore) SliverToBoxAdapter(child: _buildLoading()),
      ],
    );

    return widget.shrinkWrap ? grid : Expanded(child: grid);
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SdSpacingV5.s16),
      child: const Center(
        child: SizedBox(
          width: SdSpacingV5.s28,
          height: SdSpacingV5.s28,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      ),
    );
  }
}
