import 'dart:ui';

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
      drawer: Drawer(
        elevation: 1,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          child: Stack(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colours.backgroundColor.withOpacity(0.8),
              //   ),
              // ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colours.secondarybackgroundColor.withOpacity(0.4),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    profileWidget(
                      Scrapeme.user?.email ?? "Loading...",
                      MediaQuery.of(context).size,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 30),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Colours.secondaryColor.withOpacity(0.2),
                          ),
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.add_box_rounded,
                                    color: Colours.primaryColor,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Start a new crawl",
                                    style: GoogleFonts.poppins(
                                      color: Colours.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Recents",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colours.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const RecentDrawerScrapes(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: Colours.primaryColor,
                          ),
                          label: Text(
                            "View all",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colours.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Colours.secondaryColor.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                      ? Text(
                          "${getCurrentGreeting()}, ${Scrapeme.user?.name.split(" ").first ?? Scrapeme.user?.name}",
                          style: GoogleFonts.ebGaramond(
                            color: Colours.primaryColor,
                            fontSize: MediaQuery.of(context).size.height * 0.07,
                            fontWeight: FontWeight.w400,
                          ),
                        )
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

  Builder profileWidget(String email, Size screenSize) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colours.secondaryColor.withOpacity(0.4),
        focusColor: Colours.backgroundColor,
        hoverColor: Colours.secondaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showPopover(
            shadow: [],
            arrowHeight: 10,
            arrowWidth: 0,
            barrierColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            context: context,
            bodyBuilder: (context) => ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: screenSize.height * 0.5,
                maxWidth: screenSize.width * 0.18,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: Colours.secondaryColor, width: 0.8),
                    color: Colours.backgroundColor),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Scrapeme.user?.email ?? "Loading...",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colours.primaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 17,
                            backgroundColor: Colours.secondaryColor,
                            child: Icon(
                              Icons.person_outline_sharp,
                              color: Colours.primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Personal",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color:
                                        Colours.primaryColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Free plan",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colours.textColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.check,
                            color: Colours.primaryColor,
                          )
                        ],
                      ),
                      Divider(
                        color: Colours.primaryColor.withOpacity(0.2),
                        thickness: 1,
                      ),
                      // popMenuItem("Profile", () {}),
                      popMenuItem("Settings", () {
                        Navigator.pushNamed(context, Routes.setting);
                      }),
                      Divider(
                        color: Colours.primaryColor.withOpacity(0.2),
                        thickness: 1,
                      ),
                      popMenuItem("Terms", () {}),
                      popMenuItem("Privacy Policy", () {}),
                      Divider(
                        color: Colours.primaryColor.withOpacity(0.2),
                        thickness: 1,
                      ),
                      popMenuItem("Logout", () {}),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colours.secondaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colours.secondaryColor,
                child: Text(Scrapeme.user?.name.split(" ")[0][0] ?? "...",
                    style: GoogleFonts.poppins()),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colours.primaryColor),
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colours.primaryColor,
              )
            ],
          ),
        ),
      );
    });
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

  Widget popMenuItem(String text, Function() onTap) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
          onPressed: onTap,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colours.primaryColor)),
          )),
    );
  }
}

class RecentDrawerScrapes extends StatelessWidget {
  const RecentDrawerScrapes({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RecentScrapesDrawerContainer(
            onTap: () {},
            title: "Example scrape #$index",
          ),
        );
      },
    );
  }
}
