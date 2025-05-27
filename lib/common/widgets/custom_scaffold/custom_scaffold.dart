import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/expanded_appbar.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/floating_appbar.dart';

class CustomScaffold extends StatefulWidget {
  final Widget appBarChild;
  final Widget child;
  const CustomScaffold.withChild({
    super.key,
    required this.appBarChild,
    required this.child,
  });
  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final ScrollController _scrollController = ScrollController();
  final double _cardTopPadding = 20.0; // Initial distance from top
  final double _cardHorizontalPadding = 20.0; // Initial horizontal padding
  bool _isStuck = false;

  static const double _minTopPadding = 0.0; // When stuck to the top
  static const double _minHorizontalPadding =
      0.0; // When expanded to full width
  static const double _triggerOffset =
      60.0; // How much to scroll before sticking

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final stuck = offset > _triggerOffset;
    if (stuck != _isStuck) {
      setState(() {
        _isStuck = stuck;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = _isStuck ? _minTopPadding : _cardTopPadding;
    final double horizontalPadding =
        _isStuck ? _minHorizontalPadding : _cardHorizontalPadding;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // The main scrollable content
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 100,
                bottom: 30,
                left: 20,
                right: 20,
              ),
              controller: _scrollController,
              child: widget.child,
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              curve: Curves.ease,
              top: topPadding,
              left: horizontalPadding,
              right: horizontalPadding,
              child:
                  _isStuck
                      ? ExpandedAppBar.withChild(
                        child: widget.appBarChild,
                      ) // When stuck, show expanded appbar,
                      : FloatingAppBar.withChild(
                        child: widget.appBarChild,
                      ), // When floating, show compact ,card
            ),
          ],
        ),
      ),
    );
  }
}
