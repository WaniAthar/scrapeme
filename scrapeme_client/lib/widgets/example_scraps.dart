import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/controllers/controllers.dart';

import '../constants/constants.dart';

class ExampleScrapes extends ConsumerWidget {
  ExampleScrapes({super.key});

  final List<Map<String, String>> exampleScrapes = [
    {
      "title": "News Healines summary under 30 words",
      "prompt":
          "Can you scrape the web page https://theguardian.com and return the news headlines along with their respective story summaries (under 40 words each) in a tabular format? Each row should contain the headline in one column and the summary in the other.",
    },
    {
      "title": "Today's cricket matches and results",
      "prompt":
          "Go to https://cricbuzz.com and tell what matches are happening today, going on and completed and tell me who won. ",
    },
    {
      "title": "Headphone price prediction",
      "prompt":
          "pricehistory.app/p/skullcandy-hesh-anc-bluetooth-wireless-over-ear-qgk9hoSj do the analysis and prediction on this page and tell me whether the price is going to be up or down",
    }
  ];

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
          height: 15,
        ),
        Text(
          "You can try one of these exmaples",
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
                            exampleScrapes[index]["prompt"]!;
                      },
                      title: exampleScrapes[index]["title"]!,
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
                  childAspectRatio: 3 / 1.5),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ExampleScrapeContainer(
                    onTap: () {
                      promptTextController.text =
                          exampleScrapes[index]["prompt"]!;
                    },
                    title: exampleScrapes[index]["title"]!);
              });
        })
      ],
    );
  }
}

class ExampleScrapeContainer extends StatelessWidget {
  const ExampleScrapeContainer({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
  });

  final Function() onTap;
  final String title;
  final IconData? icon;

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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colours.secondaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Add this
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon ?? Icons.animation_rounded,
                size: 16,
                color: Colours.primaryColor,
              ),
              const SizedBox(
                height: 7,
              ),
              Flexible(
                // Wrap the Text in Flexible
                child: Text(
                  title,
                  style: GoogleFonts.ebGaramond(
                    fontSize: 16,
                    color: Colours.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis, // Add this
                  maxLines: 2, // Add this if you want to show max 2 lines
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
