import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      drawer: const KDrawer(),
      backgroundColor: Colours.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 3),
              child: RotatingIcon(
                icon: Icons.settings,
                size: 24,
                color: Colours.primaryColor,
                duration: Duration(seconds: 4),
              ),
            ),
            Text(
              "Settings",
              style: GoogleFonts.ebGaramond(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.12,
          right: MediaQuery.of(context).size.width * 0.12,
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonTab(
                    title: "Profile",
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ButtonTab(
                    title: "Account",
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child:
                  selectedIndex == 0 ? const ProfileTab() : const AccountTab(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          border: Border.all(color: Colours.secondaryColor, width: 0.8),
          borderRadius: BorderRadius.circular(16),
          color: Colours.tertiaryColor.withOpacity(0.07),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Full name",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colours.primaryColor),
              ),
            ),
            InputField(
              hintText: "Athar",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              controller: TextEditingController(text: "Athar Wani"),
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
              child: Text(
                "What should we call you?",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colours.primaryColor),
              ),
            ),
            InputField(
              hintText: "Athar",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nickname is required';
                }
                return null;
              },
              controller: TextEditingController(text: "Athar"),
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: KPrimaryButton(
                  title: "Update Name",
                  onPressed: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTab extends StatelessWidget {
  const ButtonTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: const Size(220, 50),
        backgroundColor: isSelected
            ? Colours.secondaryColor.withOpacity(0.4)
            : Colors.transparent,
      ),
      onPressed: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: Colours.primaryColor,
          ),
        ),
      ),
    );
  }
}

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          border: Border.all(color: Colours.secondaryColor, width: 0.8),
          borderRadius: BorderRadius.circular(16),
          color: Colours.tertiaryColor.withOpacity(0.07),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Account",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colours.primaryColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Export data",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colours.primaryColor,
                  ),
                ),
                KSecondaryButton(
                  title: "Export Data",
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colours.primaryColor.withOpacity(0.2),
              thickness: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delete account",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colours.primaryColor,
                  ),
                ),
                KPrimaryButton(
                  title: "Delete Account",
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
