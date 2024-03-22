import 'package:app/screens/appointments.dart';
import 'package:app/screens/dashboard.dart';
import 'package:app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  final List<Widget> screens = <Widget>[
    const Dashboard(),
    const Appointments(),
    const Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 65.0,
        color: Colors.deepOrangeAccent,
        child: GNav(
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white30,
          gap: 8,
          onTabChange: (index) {
            setState(() {
              if (index >= 0 && index < screens.length) {
                currentScreen = screens[index];
              }
            });
          },
          padding: const EdgeInsets.all(8),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Início',
            ),
            GButton(
              icon: Icons.date_range,
              text: 'Agendamentos',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Perfil',
            ),
          ],
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
    );
  }
}
