import 'package:flutter/material.dart';
import 'package:linkedin_scroll/home.dart';
import 'package:linkedin_scroll/scroll_to_hide.dart';

/// [AppControllerPage] is the main page of the application
/// This page contains BottomNavigationBar and the main content of the application
/// This page is the parent of all the pages
class AppControllerPage extends StatefulWidget {
  const AppControllerPage({super.key});

  @override
  State<AppControllerPage> createState() => _AppControllerPageState();
}

class _AppControllerPageState extends State<AppControllerPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(ScrollController scrollController) =>
      <Widget>[
        MyHomePage(
          scrollController: scrollController,
        ),
        const MyOrderspage(),
        const SettingsPage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: _widgetOptions(_scrollController)[_selectedIndex],
        bottomNavigationBar: ScrollToHideWidget(
          scrollController: _scrollController,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.note),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.more),
                label: "Settings",
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.shifting, // Shifting mode
          ),
        ),
      ),
    );
  }
}

class MyOrderspage extends StatefulWidget {
  const MyOrderspage({super.key});

  @override
  State<MyOrderspage> createState() => _MyOrderspageState();
}

class _MyOrderspageState extends State<MyOrderspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Center(
        child: Text("Orders Page"),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Text("Settings Page"),
      ),
    );
  }
}
