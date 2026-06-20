import 'dart:async';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

enum CameraStatus { loading, live, error }

class _CameraPageState extends State<CameraPage> {
  CameraStatus _status = CameraStatus.loading;
  int _retryAttempts = 0;
  Timer? _retryTimer;
  Timer? _hideControlsTimer;
  bool _fullscreen = false;
  bool _showControls = true;

  final String streamUrl = "http://192.168.1.2:80/stream"; // عدل الـ IP لو محتاج

  void _startStream() {
    setState(() {
      _status = CameraStatus.loading;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _status = CameraStatus.live;
          _retryAttempts = 0;
        });
      }
    });
  }

  void _handleError([String? message]) {
    if (mounted) {
      setState(() {
        _status = CameraStatus.error;
      });
      _scheduleRetry();
    }
  }

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _retryAttempts++;
    final delay = Duration(seconds: 2 * _retryAttempts);
    _retryTimer = Timer(delay, () {
      if (mounted) _startStream();
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startStream();
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  Widget _buildStatusOverlay() {
    String text;
    Color color;
    switch (_status) {
      case CameraStatus.loading:
        text = "Connecting to camera...";
        color = Colors.orange;
        break;
      case CameraStatus.live:
        text = "LIVE";
        color = Colors.green;
        break;
      case CameraStatus.error:
        text = "Camera disconnected";
        color = Colors.red;
        break;
    }
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildControls() {
    if (!_showControls) return const SizedBox.shrink();
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_status == CameraStatus.error)
            ElevatedButton(
              onPressed: _startStream,
              child: const Text("Retry"),
            ),
          IconButton(
            icon: Icon(
              _fullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _fullscreen = !_fullscreen;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStream() {
    if (_status == CameraStatus.loading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 12),
            Text("Connecting to camera...",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    } else if (_status == CameraStatus.error) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            SizedBox(height: 12),
            Text("Camera disconnected or timeout",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: _toggleControls,
        child: Image.network(
          streamUrl,
          fit: BoxFit.contain,
          gaplessPlayback: true,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          },
          errorBuilder: (context, error, stack) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _handleError(error.toString());
            });
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  SizedBox(height: 12),
                  Text("Connection error",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _fullscreen
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              title: const Text("Live Camera"),
            ),
      body: Stack(
        children: [
          Center(child: _buildStream()),
          _buildStatusOverlay(),
          _buildControls(),
        ],
      ),
    );
  }
}
