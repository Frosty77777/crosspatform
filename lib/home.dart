import 'package:flutter/material.dart';
import 'components/theme_button.dart';
import 'constants.dart';
import 'screens/explore_page.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
  });

  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Explore',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: 'Bookings',
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.person),
    )
  ];


  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(),
      const Center(
          child: Text('Booking Page', 
          style: TextStyle(fontSize: 32.0))),
      const Center(
        child: Text('Account Page', 
        style: TextStyle(fontSize: 32.0))),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IndexedStack(index: tab, children: pages),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (index) {
              setState(() {
                tab = index;
              });
            },
            destinations: appBarDestinations,
          ),
        ),
      ),
    );
  }
}
