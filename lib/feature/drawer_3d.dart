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
            // _buildBackground(),
            // _build3dObject(),
            // _buildDrawer(),
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
    } else {
      _animationController.reverse(from: _animationController.value);
      _drawerVisible = false;
    }
  }
}
