import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/constants/constants.dart';

class RecentScrapes extends ConsumerWidget {
  const RecentScrapes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.chat_outlined,
                size: 18,
                color: Colours.primaryColor.withBlue(200),
              ),
            ),
            Text(
              "Your recent scraps",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colours.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: SizedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(
                        "View all",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colours.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Colours.primaryColor.withBlue(200),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 375) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const RecentScrapeContainer(),
                  );
                });
          }
          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return const RecentScrapeContainer();
              });
        })
      ],
    );
  }
}

class RecentScrapeContainer extends StatelessWidget {
  const RecentScrapeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colours.secondaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(
              Icons.chat_outlined,
              size: 16,
              color: Colours.primaryColor,
            ),
            const SizedBox(
              height: 7,
            ),
            Text("Properly Using Refresh Indicator",
                style: GoogleFonts.ebGaramond(
                  fontSize: 18,
                  color: Colours.primaryColor,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 7,
            ),
            Text("2 days ago",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colours.primaryColor.withAlpha(200),
                  fontWeight: FontWeight.w600,
                )),
          ]),
        ),
      ),
    );
  }
}
