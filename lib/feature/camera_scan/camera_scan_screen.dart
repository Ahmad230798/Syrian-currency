// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';
import 'dart:async'; // ضروري من أجل الـ Timer
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart';
import 'package:syrian_currency/core/routing/routes.dart';

import 'package:syrian_currency/feature/camera_scan/logic/scanner_cubit.dart';
import 'package:syrian_currency/feature/camera_scan/logic/scanner_state.dart';

import 'package:syrian_currency/feature/camera_scan/widgets/camera_controls_panel.dart';
import 'package:syrian_currency/feature/camera_scan/widgets/scan_frame_overlay.dart';
import 'package:syrian_currency/feature/camera_scan/widgets/scan_hint_overlay.dart';
import 'package:syrian_currency/feature/camera_scan/widgets/top_scan_header.dart';

class CameraScanScreen extends StatefulWidget {
  const CameraScanScreen({super.key});

  @override
  State<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isCameraInitialized = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initCamera();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_isCameraInitialized) return;

    try {
      if (_isFlashOn) {
        await _cameraController!.setFlashMode(FlashMode.off);
        setState(() => _isFlashOn = false);
      } else {
        await _cameraController!.setFlashMode(FlashMode.torch);
        setState(() => _isFlashOn = true);
      }
    } catch (e) {
      debugPrint("Flash Error: $e");
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("Image selected: ${image.path}");
        if (context.mounted) {
          context.read<ScannerCubit>().performScan(File(image.path));
        }
      }
    } catch (e) {
      debugPrint("Gallery Error: $e");
    }
  }

  void _showInstructionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColor.mainContainerBackGround,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: AppColor.blue, size: 48.sp),
                16.verticalSpace,
                Text(
                  "How to Scan",
                  style: AppTextStyle.font20extrabold.copyWith(
                    color: Colors.white,
                  ),
                ),
                24.verticalSpace,
                _buildInstructionStep(
                  "1",
                  "Place the banknote on a flat surface.",
                ),
                12.verticalSpace,
                _buildInstructionStep("2", "Ensure there is good lighting."),
                12.verticalSpace,
                _buildInstructionStep(
                  "3",
                  "Align the banknote within the blue frame.",
                ),
                12.verticalSpace,
                _buildInstructionStep(
                  "4",
                  "Hold the camera steady and capture.",
                ),
                32.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blue,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      "Got it",
                      style: AppTextStyle.font16medium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructionStep(String stepNumber, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AppColor.blue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: AppTextStyle.font12semibold.copyWith(color: AppColor.blue),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.font14regular.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: BlocConsumer<ScannerCubit, ScannerState>(
        listener: (context, state) {
          if (state is ScannerFailure) {
            SnackBarHelper.showError(context, state.errorMessage);
          } else if (state is ScannerSuccess) {
            if (state.response.data != null) {
              context.pushReplacementNamed(
                Routes.scanResult,
                arguments: state.response.data,
              );
            }
          }
        },
        builder: (context, state) {
          bool isLoading = state is ScannerLoading;

          return Stack(
            children: [
              if (_isCameraInitialized && _cameraController != null)
                SizedBox.expand(child: CameraPreview(_cameraController!))
              else
                const Center(
                  child: CircularProgressIndicator(color: AppColor.blue),
                ),

              Container(color: Colors.black.withOpacity(0.4)),

              Center(child: ScanFrameOverlay(animation: _animation)),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: TopScanHeader(onInfoTap: _showInstructionsDialog),
              ),

              Positioned(
                bottom: 32.h,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ScanHintOverlay(),
                    24.verticalSpace,
                    CameraControlsPanel(
                      isFlashOn: _isFlashOn,
                      onFlashToggle: _toggleFlash,
                      onGalleryTap: () => _openGallery(context),
                      onCaptureTap: () async {
                        if (_cameraController != null &&
                            _cameraController!.value.isInitialized) {
                          try {
                            final XFile image = await _cameraController!
                                .takePicture();
                            if (_isFlashOn) await _toggleFlash();

                            if (context.mounted) {
                              context.read<ScannerCubit>().performScan(
                                File(image.path),
                              );
                            }
                          } catch (e) {
                            debugPrint("Capture error: $e");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),

              // استدعاء واجهة التحميل الذكية
              if (isLoading) const SmartLoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------
// واجهة تحميل ذكية تتغير نصوصها لتسلية المستخدم خلال الـ 90 ثانية
// -------------------------------------------------------------
class SmartLoadingOverlay extends StatefulWidget {
  const SmartLoadingOverlay({super.key});

  @override
  State<SmartLoadingOverlay> createState() => _SmartLoadingOverlayState();
}

class _SmartLoadingOverlayState extends State<SmartLoadingOverlay> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> _messages = [
    "Uploading Image...",
    "Initializing SYP SHIELD AI...",
    "Running DeepCAE Anomaly Detection...",
    "Extracting security features...",
    "Analyzing Grad-CAM Heatmaps...",
    "This process may take up to 90 seconds.\nPlease do not close the app...",
    "Finalizing results...",
  ];

  @override
  void initState() {
    super.initState();
    // تغيير النص كل 12 ثانية لإبقاء المستخدم على علم بأن التطبيق لم يتوقف
    _timer = Timer.periodic(const Duration(seconds: 12), (timer) {
      if (mounted) {
        setState(() {
          if (_currentIndex < _messages.length - 1) {
            _currentIndex++;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.75),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColor.blue),
                32.verticalSpace,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _messages[_currentIndex],
                    key: ValueKey<int>(_currentIndex),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font16medium.copyWith(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
