import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class ScanCardPage extends StatefulWidget {
  const ScanCardPage({super.key});

  @override
  State<ScanCardPage> createState() => _ScanCardPageState();
}

class _ScanCardPageState extends State<ScanCardPage> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) setState(() => _isInitialized = true);
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  void _toggleTorch() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    _torchOn = !_torchOn;
    await _controller!.setFlashMode(
      _torchOn ? FlashMode.torch : FlashMode.off,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 摄像头画面
          if (_isInitialized && _controller != null)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.previewSize!.height,
                  height: _controller!.value.previewSize!.width,
                  child: CameraPreview(_controller!),
                ),
              ),
            )
          else
            const ColoredBox(color: Colors.black),

          // 浮层 UI
          SafeArea(
            child: Column(
              children: [
                // 顶部导航
                SizedBox(
                  width: 1.sw,
                  height: 56.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 16.w,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Image(
                            image: 'scan_back'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ),
                        ),
                      ),
                      BaseText(
                        text: '拍卡',
                        fontSize: 18.sp,
                        color: Colors.white,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 底部操作栏
                Container(
                  padding: EdgeInsets.only(
                    left: 48.w,
                    right: 48.w,
                    bottom: 48.w,
                    top: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 轻触照亮
                      GestureDetector(
                        onTap: _toggleTorch,
                        child: _BottomAction(
                          image: 'scan_light',
                          label: '轻触照亮',
                          highlight: _torchOn,
                        ),
                      ),
                      // 相册
                      _BottomAction(
                        image: 'scan_image',
                        label: '相册',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final String image;
  final String label;
  final bool highlight;

  const _BottomAction({
    required this.image,
    required this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: image.png3x,
          width: 44.w,
          height: 44.w,
          color: highlight ? Colors.yellow : null,
        ),
        SizedBox(height: 6.w),
        BaseText(
          text: label,
          fontSize: 13.sp,
          color: Colors.white,
          style: TextStyle(
            fontSize: 13.sp,
            color: highlight ? Colors.yellow : Colors.white,
          ),
        ),
      ],
    );
  }
}
