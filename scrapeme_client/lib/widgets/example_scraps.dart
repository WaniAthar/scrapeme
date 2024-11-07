import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/controllers/controllers.dart';

import '../constants/constants.dart';

class ExampleScrapes extends ConsumerWidget {
  const ExampleScrapes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var promptTextController = ref.watch(promptTextControllerProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("or",
            style: GoogleFonts.ebGaramond(
                fontSize: 22,
                color: Colours.primaryColor,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        Text(
          "You can try one of these exmaple crawls",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colours.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 375) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ExampleScrapeContainer(
                      onTap: () {
                        promptTextController.text =
                            "Can you scrape the web page https://theguardian.com and return the news headlines along with their respective story summaries (under 40 words each) in a tabular format? Each row should contain the headline in one column and the summary in the other.";
                      },
                    ),
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
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ExampleScrapeContainer(onTap: () {
                  promptTextController.text =
                      "Can you scrape the web page https://theguardian.com and return the news headlines along with their respective story summaries (under 40 words each) in a tabular format? Each row should contain the headline in one column and the summary in the other.";
                });
              });
        })
      ],
    );
  }
}

class ExampleScrapeContainer extends StatelessWidget {
  const ExampleScrapeContainer({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colours.secondaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(
              Icons.animation_rounded,
              size: 16,
              color: Colours.primaryColor,
            ),
            const SizedBox(
              height: 7,
            ),
            Text("Crawl this web page and return the data in tabular format",
                style: GoogleFonts.ebGaramond(
                  fontSize: 16,
                  color: Colours.primaryColor,
                  fontWeight: FontWeight.w500,
                )),
          ]),
        ),
      ),
    );
  }
}
