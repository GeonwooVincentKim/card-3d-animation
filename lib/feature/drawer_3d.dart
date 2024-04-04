import 'dart:math';

import 'package:flutter/material.dart';

class Drawer3D extends StatefulWidget {
  const Drawer3D({super.key});

  @override
  State<Drawer3D> createState() => _Drawer3DState();
}

class _Drawer3DState extends State<Drawer3D> with SingleTickerProviderStateMixin {
  late double _startingPos;
  var _drawerVisible = false;
  Size _screen = const Size(0, 0);

  late AnimationController _animationController;
  late CurvedAnimation _animator;
  late CurvedAnimation _objAnimator;

  var _maxSlide = 0.75;
  var _extraHeight = 0.1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800)
    );

    _animator = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
      reverseCurve: Curves.easeInQuad,
    );

    _objAnimator = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn
    );
  }

  @override
  void didChangeDependencies() {
    _screen = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate:_onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Stack(
          children: [
            _buildBackground(),
            // _build3dObject(),
            _buildDrawer(),
            // _buildHeader(),
            // _buildOverlay(),
          ],
        )
      )
    );
  }

  void _onDragStart(DragStartDetails details) 
    => _startingPos = details.globalPosition.dx;


  void _onDragUpdate(DragUpdateDetails details) {
    final globalDelta = details.globalPosition.dx - _startingPos;
    
    if (globalDelta > 0) {
      final pos = globalDelta / _screen.width;
      if (_drawerVisible && pos <= 1.0) return;
      _animationController.value = pos;
    } else {
      final pos = 1 - (globalDelta.abs() / _screen.width);
      if (!_drawerVisible && pos >= 0.0) return;
      _animationController.value = pos;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() > 500) {
      if (details.velocity.pixelsPerSecond.dx > 0) {
        _animationController.forward(from: _animationController.value);
        _drawerVisible = true;
      } else {
        _animationController.reverse(from: _animationController.value);
        _drawerVisible = false;
      }
      return;
    } 
    
    if (_animationController.value > 0.5) {
      _animationController.forward(from: _animationController.value);
      _drawerVisible = true;
      // Plan to make it extract this part later
    } else {
      _animationController.reverse(from: _animationController.value);
      _drawerVisible = false;
    }
  }

  _buildBackground() => Positioned.fill(
    top: -_extraHeight,
    bottom: -_extraHeight,
    child: AnimatedBuilder(
      animation: _animator,
      builder: (context, widget) => Transform.translate(
        offset: Offset(_maxSlide * _animator.value, 0),
        child: Transform(
          transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY((pi / 2 + 0.1) * -_animator.value),
          alignment: Alignment.centerLeft,
          child: widget,
        ),
      ),
      child: Container(
        color: const Color(0xffe8dfce),
        child: Stack(
          children: [
            Positioned(
              top: _extraHeight + 0.1 * _screen.height,
              left: 80,
              child: Transform.rotate(
                angle: 90 * (pi / 180),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "FENDER",
                  style: TextStyle(
                    fontSize: 100,
                    color: Color(0xFFc7c0b2),
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2.0, 2.0)
                      )
                    ],
                    fontWeight: FontWeight.w900
                  )
                )
              )
            ),
            // Shadow
            Positioned(
              top: _extraHeight + 0.13 * _screen.height,
              bottom: _extraHeight + 0.24 * _screen.height,
              left: _maxSlide - 0.41 * _screen.width,
              right: _screen.width * 1.06 - _maxSlide,
              child: Column(
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.2,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 50,
                              color: Colors.black38,
                            )
                          ],
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animator,
              builder: (_, __) => Container(
                color: Colors.black.withAlpha(
                  (150 * _animator.value).floor()
                )
              ),
            )
          ],
        )
      ),
    ),
  );

  _buildDrawer() => Positioned.fill(
    top: -_extraHeight,
    bottom: -_extraHeight,
    left: 0,
    right: _screen.width - _maxSlide,
    child: AnimatedBuilder(
      animation: _animator,
      builder: (context, widget) {
        return Transform.translate(
          offset: Offset(_maxSlide * (_animator.value - 1), 0),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(pi * (1 - _animator.value) / 2),
            alignment: Alignment.centerRight,
            child: widget
          )
        );
      },
      child: Container(
        color: const Color(0xffe8dfce),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                width: 5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black12]
                  )
                ),
              )
            ),
            Positioned.fill(
              top: _extraHeight,
              bottom: _extraHeight,
              child: SafeArea(
                child: Container(
                  width: _maxSlide,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 4,
                                ),
                                shape: BoxShape.circle
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(-15, 0),
                              child: const Text(
                                "STRING",
                                style: TextStyle(
                                  fontSize: 12,
                                  backgroundColor: Color(0xffe8dfce),
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic
                                )
                              )
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // _buildMenuItem("Guitars", active: true),
                            // _buildMenuItem("Basses"),
                            // _buildMenuItem("Amps"),
                            // _buildMenuItem("Pedals"),
                            // _buildMenuItem("Others"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // _buildFooterMenuItem("About"),
                            // _buildFooterMenuItem("Support"),
                            // _buildFooterMenuItem("Terms"),
                            // _buildFooterMenuItem("Faqs"),
                          ],
                        )
                      ],
                    ),
                  )
                ),
              ) 
            ),
            AnimatedBuilder(
              animation: _animator,
              builder: (_, __) => Container(
                width: _maxSlide,
                color: Colors.black.withAlpha(
                  (150 * (1 - _animator.value)).floor()
                )
              ),
            )
          ],
        )
      )
    )
  );
}
