import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart'; // Make sure this file exists and defines ThemeNotifier

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor:
              Theme.of(context).colorScheme.primary, 
          title: Text(
            "Settings",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'sans-serif',
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Gradient Background (from matrixChain)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.surface, Theme.of(context).colorScheme.onSurface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App Preferences",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Dark Mode Switch integrated via Provider:
                  Consumer<ThemeNotifier>(
                    builder: (context, themeNotifier, child) {
                      bool isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
                      return SwitchListTile(
                        title: Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary
                          ),
                        ),
                        value: isDarkMode,
                        onChanged: (value) {
                          themeNotifier.toggleTheme();
                        },
                        activeColor: Theme.of(context).colorScheme.error,
                      );
                    },
                  ),
                  // You can add additional settings options here.
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).colorScheme.secondary, // Matches matrixChain's bottom bar color
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/home'); // Navigate to Home
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.home, size: 30, color: Theme.of(context).colorScheme.onPrimary),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings'); // Navigate to Settings
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onPrimary),
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
