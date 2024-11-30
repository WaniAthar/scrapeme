import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class ExpandingButton extends StatefulWidget {
  const ExpandingButton({
    super.key,
    this.isCircular = false,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final bool isCircular;
  final Widget icon;
  final String title;
  final Function() onTap;

  @override
  State<ExpandingButton> createState() => _ExpandingButtonState();
}

class _ExpandingButtonState extends State<ExpandingButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: _isHovered ? 200.0 : 42.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colours.secondaryColor.withOpacity(0.2),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: _isHovered
                  ? BorderRadius.circular(widget.isCircular ? 50 : 50)
                  : BorderRadius.circular(widget.isCircular ? 50 : 10),
            ),
          ),
          onPressed: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: OverflowBox(
              maxWidth: 200,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.icon,
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: _isHovered ? null : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isHovered) ...[
                            const SizedBox(width: 10),
                            Text(
                              widget.title,
                              style: GoogleFonts.poppins(
                                color: Colours.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
