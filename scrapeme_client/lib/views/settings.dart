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
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.15,
              top: MediaQuery.of(context).size.height * 0.05,
              right: 40,
            ),
            child: Column(
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
          // Padding(
          //   padding: const EdgeInsets.only(right: 40),
          //   child: Column(
          //     children: [
          //       if (selectedIndex == 0)
          //         const ProfileTab()
          //       else
          //         const AccountTab(), 
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colours.secondaryColor, width: 0.8),
            borderRadius: BorderRadius.circular(16),
            color: Colours.tertiaryColor.withOpacity(0.07),
          ),
          child: Column(
            children: [
              InputField(
                hintText: "yourname@yourCompany.com",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                onFieldSubmitted: (value) {},
              ),
            ],
          ),
        ),
      ],
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

// Placeholder widget for AccountTab
class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Account Settings"),
        // Add more widgets as needed
      ],
    );
  }
}
