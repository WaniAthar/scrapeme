import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class ScrapeHistoryTile extends StatefulWidget {
  final String title;
  final String lastMessage;
  final DateTime timestamp;
  final VoidCallback onTap;
  final bool isSelected;
  final Function(bool?)? onCheckboxChanged;

  const ScrapeHistoryTile({
    super.key,
    required this.title,
    required this.lastMessage,
    required this.timestamp,
    required this.onTap,
    this.isSelected = false,
    this.onCheckboxChanged,
  });

  @override
  State<ScrapeHistoryTile> createState() => _ScrapeHistoryTileState();
}

class _ScrapeHistoryTileState extends State<ScrapeHistoryTile>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _checkboxScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _checkboxScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(widget.timestamp);

    if (difference.inDays > 7) {
      return 'Last scrape ${widget.timestamp.month}/${widget.timestamp.day}/${widget.timestamp.year}';
    } else if (difference.inDays > 0) {
      return 'Last scrape ${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return 'Last scrape ${difference.inHours}h ago';
    } else {
      return 'Last scrape ${difference.inMinutes}m ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: widget.onTap,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: isHovered || widget.isSelected ? 36 : 0,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: isHovered || widget.isSelected ? 0.4 : 0.1,
                      color: isHovered || widget.isSelected
                          ? Colours.primaryColor
                          : Colours.primaryColor.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: isHovered
                        ? Colours.tertiaryColor.withOpacity(0.4)
                        : Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.ebGaramond(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: widget.isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _formatTimestamp(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isHovered || widget.isSelected)
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 10,
                  child: Center(
                    child: Transform.scale(
                      scale:
                          widget.isSelected ? 1 : _checkboxScaleAnimation.value,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Checkbox(
                          value: widget.isSelected,
                          onChanged: widget.onCheckboxChanged,
                          fillColor: WidgetStateProperty.all(
                            widget.isSelected
                                ? Colours.primaryColor
                                : Colours.white,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
