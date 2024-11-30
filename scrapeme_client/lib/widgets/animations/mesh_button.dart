import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:scrapeme/constants/constants.dart';

class MeshButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;

  const MeshButton({super.key, this.onPressed, this.text = 'Regenerate'});

  @override
  State<MeshButton> createState() => _MeshButtonState();
}

class _MeshButtonState extends State<MeshButton> {
  bool isHovering = false;
  final AnimatedMeshGradientController controller =
      AnimatedMeshGradientController();

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
          scale: isHovering ? 1.04 : 1,
          child: AnimatedContainer(
            curve: Curves.decelerate,
            duration: const Duration(milliseconds: 300),
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                  color: isHovering ? Colors.white : Colors.transparent),
              borderRadius: BorderRadius.circular(30),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: Colours.successColor.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colours.errorColor.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(isHovering ? 0.3 : 0.1),
                  width: 1.5,
                ),
                color: Colors.white.withOpacity(isHovering ? 0.2 : 0.1),
              ),
              child: ClipRRect(
                 clipBehavior: Clip.values.contains(Clip.antiAlias)
                    ? Clip.antiAlias
                    : Clip.hardEdge,
                borderRadius: BorderRadius.circular(30),
                child: AnimatedMeshGradient(
                  options: AnimatedMeshGradientOptions(
                      speed: 5, amplitude: 60, frequency: 10),
                  controller: controller,
                  colors: const [
                    Colours.successColor,
                    Colours.errorColor,
                    Colors.blue,
                    Colors.pink,
                  ],
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            KIcons.svgAI,
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                          Text(
                            widget.text,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
