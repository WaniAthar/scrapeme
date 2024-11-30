import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapeme/models/models.dart';
import 'package:scrapeme/routes/routes.dart';
import 'package:scrapeme/widgets/widgets.dart';

import '../constants/constants.dart';

class ScrapeHistory extends ConsumerStatefulWidget {
  const ScrapeHistory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScrapeHistoryState();
}

class _ScrapeHistoryState extends ConsumerState<ScrapeHistory> {
  bool isHovered = false;
  bool selectTapped = false;
  bool isEmptyState = false;
  int selectedScrapes = 0;
  TextEditingController searchController = TextEditingController();
  List<RecentScrapeModel> filteredScrapes = [];
  List<RecentScrapeModel> allScrapes = List.generate(
    100,
    (index) => RecentScrapeModel(
      id: index.toString(),
      title: "#$index ${String.fromCharCode(index + 65)}",
      timestamp: DateTime.now().subtract(Duration(minutes: index * 5)),
    ),
  );
  List<bool> selectedItems = List.generate(100, (_) => false);

  void filterScrapes(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredScrapes = List.from(allScrapes);
      } else {
        filteredScrapes = allScrapes.where((scrape) {
          return scrape.title.toLowerCase().contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filteredScrapes = List.from(allScrapes);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      drawer: const KDrawer(),
      backgroundColor: Colours.backgroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ExpandingButton(
              icon: const Icon(Icons.add_box_rounded, size: 22),
              title: "Start a new crawl",
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != Routes.home) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Routes.home);
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: Row(
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
              "History",
              style: GoogleFonts.ebGaramond(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.28),
        child: Column(
          children: [
            InputField(
              leadingIcon: const Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: Colours.primaryColor,
                ),
              ),
              controller: searchController,
              keyboardType: TextInputType.text,
              hintText: "Search your crawls",
              onChanged: filterScrapes,
            ),
            const SizedBox(
              height: 20,
            ),
            !selectTapped ? beforeSelection() : afterSelection(),
            isEmptyState
                ? emptyWidget()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: filteredScrapes.isEmpty
                          ? emptyWidget(
                              const Icon(Icons.search_off_rounded,
                                  color: Colours.secondaryColor),
                              "Nothing was found")
                          : listHistory(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  ListView listHistory() {
    return ListView.builder(
      itemCount: filteredScrapes.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ScrapeHistoryTile(
          title: filteredScrapes[index].title,
          lastMessage: filteredScrapes[index].title,
          timestamp: filteredScrapes[index].timestamp,
          isSelected: selectedItems[index],
          onCheckboxChanged: (bool? value) {
            selectTile(index, value);
          },
          onTap: () {
            if (selectTapped) {
              bool? value = selectedItems[index] == true ? false : true;
              selectTile(index, value);
            } else {
              //navigation to scrape page
            }
          },
        );
      },
    );
  }

  void selectTile(int index, bool? value) {
    return setState(() {
      selectedItems[index] = value ?? false;
      selectedScrapes = selectedItems.where((item) => item).length;
      if (selectedScrapes == 0) {
        selectTapped = false;
      } else {
        selectTapped = true;
      }
    });
  }

  Center emptyWidget([Icon? icon, String? message]) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                const Icon(Icons.checklist_rounded,
                    color: Colours.secondaryColor),
            const SizedBox(
              height: 20,
            ),
            Text(
              message ?? " You have no scrapes with ScrapeMe",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colours.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row afterSelection() {
    return Row(
      children: [
        const Icon(Icons.checklist_rounded, color: Colours.primaryColor),
        const SizedBox(
          width: 10,
        ),
        Text(
          "$selectedScrapes selected scrapes",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colours.primaryColor,
          ),
        ),
        const Spacer(),
        MouseRegion(
          onEnter: (event) => setState(() => isHovered = true),
          onExit: (event) => setState(() => isHovered = false),
          child: selectedItems.every((item) => item == true)
              ? const SizedBox()
              : InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      selectedItems.fillRange(0, selectedItems.length, true);
                      selectedScrapes =
                          selectedItems.where((item) => item == true).length;
                    });
                  },
                  child: Text(
                    "Select all",
                    style: GoogleFonts.poppins(
                      fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: Colours.textColor,
                    ),
                  ),
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            KSecondaryButton(
              title: "Cancel",
              onPressed: () {
                setState(() {
                  selectedItems.fillRange(0, selectedItems.length, false);
                  selectTapped = false;
                });
              },
              buttonSize: const Size(100, 40),
            ),
            const SizedBox(
              width: 10,
            ),
            KPrimaryButton(
              title: "Delete selected",
              textColor: Colours.white,
              backgroundColor: Colours.errorColor,
              onPressed: () {
                setState(() {
                  isEmptyState = false;
                });
              },
              buttonSize: const Size(150, 40),
            )
          ],
        ),
      ],
    );
  }

  Row beforeSelection() {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("You have 100 scrapes with ScrapeMe ",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colours.primaryColor,
              )),
        ),
        !isEmptyState
            ? MouseRegion(
                onEnter: (event) => setState(() => isHovered = true),
                onExit: (event) => setState(() => isHovered = false),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      selectTapped = true;
                    });
                  },
                  child: Text(
                    "Select",
                    style: GoogleFonts.poppins(
                      fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: Colours.textColor,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
