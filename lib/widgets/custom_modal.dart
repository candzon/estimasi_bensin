import 'package:flutter/material.dart';

class CustomModal extends StatefulWidget {
  final String message;
  final bool isSuccess;

  const CustomModal({
    super.key,
    required this.message,
    this.isSuccess = true,
  });

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse().then((_) {
          Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.isSuccess ? Icons.check_circle : Icons.error,
              color: widget.isSuccess ? Colors.green : Colors.red,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
