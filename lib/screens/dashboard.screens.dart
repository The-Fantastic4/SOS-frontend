import 'package:flutter/material.dart';
import 'package:sos_frontend/widgets/alert.widgets.dart';
import 'package:sos_frontend/widgets/colors.widgets.dart';
import 'package:sos_frontend/widgets/dashboard.widgets.dart';
import 'package:sos_frontend/widgets/snackbar.widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map? args = {};
  String featurePrompt = "Feature coming soon";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Map?;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
            child: IconButton(
              onPressed: () {
                showSnackBar(context, primaryColor, featurePrompt);
              },
              icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            )
          )
        ],
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Hello ${args?["firstname"]}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Text(
                  'See all activities...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 450,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 20,
                children: [
                  Grid(
                    image: Image.asset('assets/location.png'),
                    text: "Nearest stations",
                    color: locationAndSettingsColor,
                    onPress: () {
                      showSnackBar(context, primaryColor, featurePrompt);
                    },
                  ),
                  Grid(
                    image: Image.asset('assets/emergency.png'),
                    text: 'Emergency life line',
                    color: emergencyAndProfileColor,
                    onPress: () {
                      showSnackBar(context, primaryColor, featurePrompt);
                    },
                  ),
                  GestureDetector(
                    onTap: () => showSnackBar(context, primaryColor, featurePrompt),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: emergencyAndProfileColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 25, 0, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/profile.png'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Grid(
                    image: Image.asset('assets/settings.png'),
                    text: 'Settings',
                    color: locationAndSettingsColor,
                    onPress: () {
                      showSnackBar(context, primaryColor, featurePrompt);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => alert(context),
        child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: Center(child: Image.asset('assets/logo.png'))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
