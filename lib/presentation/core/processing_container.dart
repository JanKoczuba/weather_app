import 'package:flutter/material.dart';

class ProcessingContainer extends StatelessWidget {
  const ProcessingContainer({
    required this.child,
    required this.isProcessing,
    this.processingBuilder,
    this.expand = true,
    this.progress,
    this.hideContent = false,
    super.key,
  });

  final Widget child;
  final WidgetBuilder? processingBuilder;
  final bool isProcessing;
  final bool expand;
  final double? progress;

  final bool hideContent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: expand ? StackFit.expand : StackFit.passthrough,
      children: [
        if (!hideContent || !isProcessing) child,
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.linearToEaseOut,
            switchOutCurve: Curves.linearToEaseOut,
            child: _buildOverlay(context),
          ),
        ),
      ],
    );
  }

  Widget _buildOverlay(BuildContext context) {
    if (!isProcessing) {
      return Container(
        key: const ValueKey("NotProcessingOverlay"),
      );
    }

    final processingBuilder = this.processingBuilder;
    if (processingBuilder != null) {
      return processingBuilder.call(context);
    }

    return Container(
      color: Colors.white60,
      child: Center(
        child: CircularProgressIndicator.adaptive(value: progress),
      ),
    );
  }
}
