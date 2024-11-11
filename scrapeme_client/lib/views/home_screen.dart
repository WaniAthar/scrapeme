// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:scrapeme/constants/constants.dart';
import 'package:scrapeme/routes/routes.dart';
import 'package:scrapeme/utils/scrapeme.dart';
import 'package:scrapeme/widgets/widgets.dart';

import '../controllers/controllers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    var userState = ref.watch(userProvider);
    var userStateNotifier = ref.watch(userProvider.notifier);
    var promptTextController = ref.watch(promptTextControllerProvider);

    if (userState.asData == null) {
      userStateNotifier.getUserProfile();
    }

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      drawerScrimColor: Colors.transparent,
      drawer: const KDrawer(),
      appBar: AppBar(
        titleSpacing: screenWidth * 0.1,
        title: const Text(
          'ScrapeMe',
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Scrapeme.user != null
                      ? greetingWidget(context)
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: CircularProgressIndicator(
                            color: Colours.primaryColor,
                          ),
                        )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double screenWidth = constraints.maxWidth;

                  double width;

                  if (screenWidth <= 375) {
                    width = screenWidth * 0.8;
                  } else if (screenWidth > 375 && screenWidth <= 768) {
                    width = screenWidth * 0.6;
                  } else {
                    width = screenWidth * 0.4;
                  }

                  return SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InputField(
                                hintText: "How can i help you today?",
                                maxLines: 10,
                                minLines: 3,
                                controller: promptTextController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                suffixIcon: const SizedBox(
                                  width: 40,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colours.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                      hoverColor: Colours.white,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          size: 18,
                                          Icons.arrow_upward_rounded,
                                          color: Colours.white,
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: MediaQuery.of(context).size.height * 0.06,
                          //       bottom:
                          //           MediaQuery.of(context).size.height * 0.06),
                          //   child: const RecentScrapes(),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.06,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.06),
                            child: ExampleScrapes(),
                          ),
                        ],
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget greetingWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const RotatingIcon(
          icon: Icons.sunny,
          size: 50,
          color: Colours.primaryColor,
          duration: Duration(seconds: 8),
        ),
        const SizedBox(width: 6),
        Text(
          "${getCurrentGreeting()}, ${Scrapeme.user?.name.split(" ").first ?? Scrapeme.user?.name}",
          style: GoogleFonts.ebGaramond(
            color: Colours.primaryColor,
            fontSize: MediaQuery.of(context).size.height * 0.07,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  String getCurrentGreeting() {
    DateTime now = DateTime.now();
    if (now.hour >= 5 && now.hour < 12) {
      return "Good morning";
    } else if (now.hour >= 12 && now.hour < 16) {
      return "Good afternoon";
    } else if (now.hour >= 16 && now.hour < 21) {
      return "Good evening";
    } else if (now.hour >= 21 && now.hour < 23) {
      return "Good night";
    } else {
      return "Happy late night";
    }
  }
}
