import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/controllers/controllers.dart';
import 'package:scrapeme/utils/scrapeme.dart';
import 'package:scrapeme/widgets/toast_notification.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/constants.dart';
import '../widgets/widgets.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool showResponseWidget = false;
  double promptWidgetScale = 1.4;
  Alignment promptWidgetAlignment = Alignment.center;
  String? responseStatus;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> statusUpdates = [
    "Visiting Cricbuzz.com",
    "Scraping data",
    "Generating response",
  ];
  int statusIndex = 0;
  Timer? statusTimer;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.decelerate,
    );

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        promptWidgetScale = 0.8;
        promptWidgetAlignment = Alignment.topCenter;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showResponseWidget = true;
        responseStatus = statusUpdates[statusIndex];
      });
      _fadeController.forward();

      statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (statusIndex < statusUpdates.length - 1) {
          setState(() {
            statusIndex++;
            responseStatus = statusUpdates[statusIndex];
          });
        } else {
          timer.cancel();
          setState(() {
            responseStatus = "";
            isLoading = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    statusTimer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      drawerScrimColor: Colors.transparent,
      drawer: const KDrawer(),
      appBar: AppBar(
        title: isLoading
            ? Shimmer.fromColors(
                baseColor: Colours.primaryColor,
                highlightColor: Colours.primaryColor.withOpacity(0.2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colours.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 200,
                  height: 25,
                ),
              )
            : Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.chat,
                      size: 24,
                      color: Colours.primaryColor,
                    ),
                  ),
                  Text(
                    "CricBuzz score",
                    style: GoogleFonts.ebGaramond(
                      fontWeight: FontWeight.w500,
                      color: Colours.primaryColor,
                    ),
                  ),
                ],
              ),
      ),
      body: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 600),
            alignment: promptWidgetAlignment,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: ScrollController(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 600),
                    alignment: promptWidgetAlignment,
                    curve: Curves.decelerate,
                    child: AnimatedScale(
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 600),
                      scale: promptWidgetScale,
                      child: userPromptWidget(),
                    ),
                  ),
                  if (showResponseWidget)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.scale(
                        scale: 0.8,
                        child: responseWidget(),
                      ),
                    ),
                  // if (showResponseWidget && !isLoading) const Spacer(),
                  if (showResponseWidget && !isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: MeshButton(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userPromptWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 400, vertical: 10),
        decoration: BoxDecoration(
          color: Colours.secondaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colours.secondaryColor,
                child: Text(Scrapeme.user?.name.split(" ")[0][0] ?? "...",
                    style: GoogleFonts.poppins()),
              ),
            ),
            Expanded(
              child: Text(
                ref.watch(promptTextControllerProvider).text,
                style: GoogleFonts.poppins(
                    color: Colours.primaryColor, fontSize: 18),
              ),
            ),
          ],
        ),
      );

  Widget responseWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (responseStatus != null)
            Shimmer.fromColors(
              baseColor: Colours.grey.withOpacity(0.5),
              highlightColor: Colours.lightGrey,
              child: Padding(
                padding: const EdgeInsets.only(left: 400),
                child: Text(responseStatus!,
                    style: GoogleFonts.poppins(
                        color: Colours.primaryColor, fontSize: 18)),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 400),
            decoration: BoxDecoration(
              color: Colours.secondarybackgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: isLoading
                ? shimmerResponse()
                : Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: RotatingIcon(
                              icon: Icons.wb_sunny_rounded,
                              size: 30,
                              color: Colours.primaryColor,
                              duration: Duration(seconds: 8),
                            ),
                          ),
                          Expanded(
                            child: SelectableText(
                              "${ref.watch(promptTextControllerProvider).text}\n\n\n\t${ref.watch(promptTextControllerProvider).text}",
                              style: GoogleFonts.poppins(
                                color: Colours.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              tooltip: "Download",
                              onPressed: () async {
                                final blob = html.Blob([
                                  ref.watch(promptTextControllerProvider).text
                                ]);

                                final url =
                                    html.Url.createObjectUrlFromBlob(blob);
                                final anchor = html.AnchorElement()
                                  ..href = url
                                  ..download = "downloaded_text.txt"
                                  ..style.display = 'none';

                                html.document.body!.append(anchor);
                                anchor.click();
                                html.document.body!.removeAttribute('href');

                                html.Url.revokeObjectUrl(url);
                              },
                              icon: const Icon(
                                Icons.download_rounded,
                                size: 20,
                              )),
                          IconButton(
                              tooltip: "Copy all",
                              onPressed: () {
                                Clipboard.setData(const ClipboardData(
                                    text: "This is a copied text"));
                                CustomToast.success(
                                    "Copied!", "Text copied to clipboard");
                              },
                              icon: const Icon(
                                Icons.copy,
                                size: 20,
                              ))
                        ],
                      )
                    ],
                  ),
          ),
        ],
      );

  Shimmer shimmerResponse() {
    return Shimmer.fromColors(
      baseColor: Colours.primaryColor,
      highlightColor: Colours.primaryColor.withOpacity(0.5),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colours.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
