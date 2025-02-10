import 'package:algolearn/pages/theory.dart';
import 'package:flutter/material.dart';
import 'package:algolearn/pages/settings.dart';
import 'package:algolearn/pages/matrix_chain.dart';
import 'package:algolearn/pages/travelling_salesman.dart';
import 'package:algolearn/pages/eight_queens.dart';
import 'package:algolearn/pages/greedy_knapsack.dart';
//import 'package:algolearn/pages/knapsack_backtrack.dart';
import 'package:algolearn/pages/knapsack_bb.dart';
//import 'package:algolearn/pages/knapsack_dp.dart';
import 'package:algolearn/pages/lcs.dart';
import 'package:algolearn/theme/theme.dart';         // Contains lightTheme & darkTheme
import 'package:algolearn/pages/theme_notifier.dart';  // Contains ThemeNotifier class
import 'package:provider/provider.dart';

// Global variable to remember the last tapped container index.
int lastSelectedContainerIndex = 0;

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeMode.light), // Default to light mode
      child: MyApp(),
    ),
  );
}

///
/// GlowingAppTitle widget: displays the app title in uppercase with an increased size and a static glowy effect.
///
class GlowingAppTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;

  const GlowingAppTitle({Key? key, required this.title, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Combine the provided style (if any) with a static glow using a shadow.
    final style = (textStyle ??
            TextStyle(
              fontSize: 55, // Increased size
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'sans-serif',
              color:  Theme.of(context).colorScheme.onPrimary,
            ))
        .copyWith(
      shadows: [
        Shadow(
          color: Theme.of(context).colorScheme.error, // Warm reddish color for the glow
          blurRadius: 20, // Adjust this value to change the intensity of the glow
        ),
      ],
    );

    return Text(
      title.toUpperCase(), // Capitalize the text
      textAlign: TextAlign.center,
      style: style,
    );
  }
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> containerDetails = [
    {'label': 'Theory', 'route': '/theory'},
    {'label': 'Matrix Chain', 'route': '/MatrixChain'},
    {'label': 'Eight Queens', 'route': '/eightQueens'},
    {'label': 'Longest Common Subsequence', 'route': '/lcs'},
    {'label': 'Travelling Salesman', 'route': '/TravellingSalesman'},
    {'label': 'Greedy Knapsack', 'route': '/greedyKnapsack'},
    //{'label': 'Knapsack (Backtracking)', 'route': '/knapsackBacktrack'},
    {'label': 'Knapsack (Branch & Bound)', 'route': '/knapsackBB'},
    //{'label': 'Knapsack (DP)', 'route': '/knapsackDP'},
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve the current themeMode from the ThemeNotifier.
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // *** NEW CODE ADDED FOR THEME SWITCHING ***
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeNotifier.themeMode,
      // *******************************************
      routes: {
        '/MatrixChain': (context) => matrixchain(),
        '/TravellingSalesman': (context) => travellingSalesman(),
        '/home': (context) => MyApp(),
        '/settings': (context) => const Settings(),
        '/eightQueens': (context) => eightQueens(),
        '/greedyKnapsack': (context) => greedyKnapsack(),
        //'/knapsackBacktrack': (context) => knapsackBacktrack(),
        '/knapsackBB': (context) => knapsackBB(),
        //'/knapsackDP': (context) => knapsackDP(),
        '/lcs': (context) => lcs(),
        '/theory': (context) => theory(),
      },
      // Wrap the home screen Scaffold in WillPopScope to disable back gesture.
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // This gradient now uses colors from the current theme's ColorScheme.
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.onSurface
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      // Replaced the animated title with the static GlowingAppTitle.
                      child: GlowingAppTitle(
                        title: 'AlgoLearn',
                        textStyle: TextStyle(
                          fontSize: 55, // Increased font size
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'sans-serif',
                          // Use the onPrimary color from the theme.
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 300,
                    child: SmoothPageView(containerDetails: containerDetails),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            // Uses the secondary color from the theme.
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    // Determine if the current route is the home screen.
                    // Here we assume that if the current route is the first one in the stack, we're at home.
                    final bool isHome = ModalRoute.of(context)?.isFirst ?? true;
                    return InkWell(
                      onTap: isHome ? null : () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home,
                                color: isHome
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.onPrimary),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: isHome
                                      ? Colors.grey
                                      : Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,
                              color: Theme.of(context).colorScheme.onPrimary),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmoothPageView extends StatefulWidget {
  final List<Map<String, String>> containerDetails;

  SmoothPageView({required this.containerDetails});

  @override
  _SmoothPageViewState createState() => _SmoothPageViewState();
}

class _SmoothPageViewState extends State<SmoothPageView> {
  // Modified to initialize with lastSelectedContainerIndex.
  final PageController _pageController = PageController(
    initialPage: lastSelectedContainerIndex,
    viewportFraction: 0.85,
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.containerDetails.length,
      physics: BouncingScrollPhysics(),
      onPageChanged: (index) {
        // Update the global variable when the page changes.
        setState(() {
          lastSelectedContainerIndex = index;
        });
        print('Current page: $index');
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double scale = 0.9;
            if (_pageController.position.haveDimensions) {
              double pageOffset = _pageController.page ?? 0;
              double difference = (pageOffset - index).abs();
              scale = (1 - (difference * 0.2)).clamp(0.8, 1.0);
            }

            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, widget.containerDetails[index]['route']!);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 80),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(4, 4),
                    blurRadius: 9,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.containerDetails[index]['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
