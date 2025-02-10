import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class greedyKnapsack extends StatefulWidget {
  @override
  _greedyKnapsackState createState() => _greedyKnapsackState();
}

class _greedyKnapsackState extends State<greedyKnapsack> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
    "Explain the greedy approach for solving the Knapsack Problem. Why is it not always optimal for the 0/1 Knapsack Problem?",
    "Given a set of items with weights and values, describe the steps of the greedy approach to solve the Fractional Knapsack Problem",
    "Consider a Knapsack of capacity 50 kg and items with the following weight-value pairs: (10, 60), (20, 100), (30, 120). Solve using the greedy approach and find the maximum value that can be obtained",
    "How does the greedy algorithm for the Knapsack Problem determine which item to include first?",
    "Given n items with weights w[i] and values v[i], write the pseudo code for the greedy approach to solve the Fractional Knapsack Problem",
    "What is the time complexity of the greedy algorithm for the Knapsack Problem? Explain your answer",
    "Why does the greedy approach work optimally for the Fractional Knapsack Problem but not for the 0/1 Knapsack Problem?",
    "Given a Knapsack of capacity 20 kg and items: (weight, value) = (5, 50), (10, 60), (15, 90), solve the problem using the greedy approach and determine the total value obtained",
    "Suppose we modify the greedy approach by sorting items based on weight instead of value-to-weight ratio. Would this always give the optimal solution? Why or why not?",
    "Describe a real-world application of the greedy approach in solving problems similar to the Knapsack Problem",
    "Can the greedy approach be used for the 0/1 Knapsack Problem? Provide an example where it fails to give the optimal solution",
    "Explain the significance of sorting items by value-to-weight ratio before applying the greedy approach",
    "Suppose you have the following items: (weight, value) = (2, 40), (3, 50), (5, 100). If the knapsack capacity is 5 kg, solve using the greedy approach and state whether the solution is optimal",
    "Compare the greedy approach with dynamic programming for solving the Knapsack Problem. When should each be used?",
    "If an item has a very high value but also a very high weight, how does the greedy approach handle it? Would it still be included in the solution? Why?",
  ];
  String currentQuestion = "";

  @override
  void initState() {
    super.initState();
    _refreshQuestion();
  }

  void _refreshQuestion() {
    setState(() {
      currentQuestion = (questions..shuffle()).first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Knapsack Problem (Greedy Approach)",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.onSurface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              PageView.builder(
                controller: _pageController,
                itemCount: numPages,
                itemBuilder: (context, pageIndex) {
                  return PageContent(
                    pageIndex: pageIndex,
                    question: currentQuestion,
                    refreshQuestion: _refreshQuestion,
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Theme.of(context).colorScheme.secondary,
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home,
                          size: 30,
                          color: Theme.of(context).colorScheme.onPrimary),
                      Text("Home",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings,
                          size: 30,
                          color: Theme.of(context).colorScheme.onPrimary),
                      Text("Settings",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600)),
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

class PageContent extends StatelessWidget {
  final int pageIndex;
  final String question;
  final VoidCallback refreshQuestion;

  const PageContent(
      {Key? key,
      required this.pageIndex,
      required this.question,
      required this.refreshQuestion})
      : super(key: key);

  static const List<String> pageTitles = [
    "Overview",
    "Algorithm",
    "Visualization",
    "Quiz"
  ];
  static const List<String> pageContents = [
    // Overview content
'''
1. INTRODUCTION  
The knapsack problem is an optimization problem where we select items to maximize total value while staying within a weight limit. There are two main types:  
    0/1 Knapsack Problem – Items must be taken whole or not at all.  
    Fractional Knapsack Problem – Items can be divided into fractions.  

The greedy approach is optimal for the fractional knapsack problem, where we take the most valuable items first, even in fractions.  

2. GREEDY APPROACH
    Compute the value-to-weight ratio for each item.  
    Sort items in descending order of this ratio.  
    Initialize total value as 0 and available capacity as the knapsack's weight.  
    Pick items in order:  
      - If the full item fits, take it entirely.  
      - If it doesn’t, take a fraction to fill the remaining space.  
    Stop when the knapsack is full.  

Since we can take fractions of items, the greedy choice ensures the optimal solution.
2.1 Advantages:  
    Efficient O(n log n) time complexity.  
    Guaranteed optimal for fractional knapsack.  
2.2 Limitations:  
    Fails for 0/1 Knapsack, as greedy choices may lead to suboptimal solutions.    

3. TIME COMPLEXITY
Sorting items takes O(n log n), and selecting them takes O(n). Thus, the overall complexity is O(n log n).  

4. EXAMPLE
Knapsack capacity = 50
Items:  
    Item 1: Weight = 10, Value = 60 (Ratio = 6)  
    Item 2: Weight = 20, Value = 100 (Ratio = 5)  
    Item 3: Weight = 30, Value = 120 (Ratio = 4)  

Sorted by ratio: Item 1 → Item 2 → Item 3  
    Take full Item 1 (Weight = 10, Value = 60) → Remaining capacity = 40 
    Take full Item 2 (Weight = 20, Value = 100) → Remaining capacity = 20  
    Take 20/30 of Item 3 (Value added = 80)  

Total value = 240 (optimal solution).
''',
    // Algorithm content
'''
ALGORITHM:
Function FractionalKnapsack(capacity, items):
    Sort items by value-to-weight ratio in descending order
    totalValue = 0
    remainingCapacity = capacity

    For each item in items:
        If item.weight <= remainingCapacity:
            Add item.value to totalValue
            Decrease remainingCapacity by item.weight
        Else:
            fraction = remainingCapacity / item.weight
            Add fraction * item.value to totalValue
            Break

    Return totalValue

QUICK EXPLANATION:  
The first step is to sort the items by their value-to-weight ratio in descending order. This ensures that the items contributing the highest value per unit weight are considered first.

We initialize totalValue to 0, which will keep track of the total value accumulated in the knapsack.
remainingCapacity starts as the total capacity of the knapsack.

The algorithm iterates through the sorted list of items. For each item:
    If the item fits entirely into the knapsack (i.e., its weight is less than or equal to the remaining capacity), the item is added fully to the knapsack.
    If the item doesn’t fit entirely, we take as much of it as the remaining capacity allows (this is the fractional part).

After taking an item or a fraction of an item, the totalValue is updated, and the remainingCapacity is reduced accordingly.

The loop breaks when we can no longer add any more items or when the knapsack is full.

Finally, the function returns the totalValue, which represents the maximum value that can be carried in the knapsack.
''',
"",
''' 


'''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pageTitles[pageIndex],
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
              fontFamily: 'Sans-Serif',
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                Text(
                  pageContents[pageIndex],
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width * 0.045,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'Sans-Serif',
                  ),
                ),
                // Insert our new visualization widget on page 2.
                if (pageIndex == 2) ...[
                  SizedBox(height: 20),
                  KnapsackVisualizer(),
                ],
                if (pageIndex == 3)
                  Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        ZoomIn(
                          child: Text(
                            question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width *
                                      0.07,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme.error,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: refreshQuestion,
                          child: Text("Refresh Question"),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///
/// This widget implements your Greedy Knapsack Visualizer with real-time animated algorithm steps.
///
class KnapsackVisualizer extends StatefulWidget {
  @override
  _KnapsackVisualizerState createState() => _KnapsackVisualizerState();
}

class _KnapsackVisualizerState extends State<KnapsackVisualizer> {
  // Default number of items (3) so that fields are visible.
  int numItems = 3;
  bool isFractional = true;
  TextEditingController numItemsController =
      TextEditingController(text: "3");
  List<TextEditingController> weightControllers = [];
  List<TextEditingController> profitControllers = [];
  TextEditingController capacityController = TextEditingController();

  // Results from running the algorithm.
  List<Map<String, dynamic>> algorithmSteps = [];
  double finalProfit = 0.0;
  List<String> itemsTaken = [];

  @override
  void initState() {
    super.initState();
    _updateControllers(numItems);
  }

  // Create or update controllers based on the number of items.
  void _updateControllers(int count) {
    for (var controller in weightControllers) {
      controller.dispose();
    }
    for (var controller in profitControllers) {
      controller.dispose();
    }
    weightControllers =
        List.generate(count, (_) => TextEditingController());
    profitControllers =
        List.generate(count, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in weightControllers) {
      controller.dispose();
    }
    for (var controller in profitControllers) {
      controller.dispose();
    }
    numItemsController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  // Reset the visualizer for a new run.
  void _resetVisualizer() {
    setState(() {
      algorithmSteps = [];
      finalProfit = 0.0;
      itemsTaken = [];
      capacityController.clear();
      for (var controller in weightControllers) {
        controller.clear();
      }
      for (var controller in profitControllers) {
        controller.clear();
      }
    });
  }

  // Run the greedy algorithm with real-time animated steps.
  Future<void> _runGreedyAlgorithm() async {
    // Parse input values.
    List<double> weights = [];
    List<double> profits = [];
    for (int i = 0; i < numItems; i++) {
      double w = double.tryParse(weightControllers[i].text) ?? 0;
      double p = double.tryParse(profitControllers[i].text) ?? 0;
      weights.add(w);
      profits.add(p);
    }
    double capacity = double.tryParse(capacityController.text) ?? 0;

    // Build list of items with their ratio.
    List<Map<String, dynamic>> items = [];
    for (int i = 0; i < numItems; i++) {
      double ratio = weights[i] == 0 ? 0 : profits[i] / weights[i];
      items.add({
        'index': i,
        'weight': weights[i],
        'profit': profits[i],
        'ratio': ratio,
      });
    }
    // Sort items by value-to-weight ratio in descending order.
    items.sort((a, b) => b['ratio'].compareTo(a['ratio']));

    // Clear previous algorithm steps.
    setState(() {
      algorithmSteps = [];
      finalProfit = 0;
      itemsTaken = [];
    });

    double remainingCapacity = capacity;
    double totalProfit = 0;
    List<Map<String, dynamic>> steps = [];
    List<String> taken = [];

    // Process each item with a delay to animate each step.
    for (var item in items) {
      if (remainingCapacity <= 0) break;
      int idx = item['index'];
      double wt = item['weight'];
      double pr = item['profit'];
      double takenWeight = 0;
      double profitAdded = 0;
      if (isFractional) {
        if (wt <= remainingCapacity) {
          takenWeight = wt;
          profitAdded = pr;
          remainingCapacity -= wt;
          taken.add("Item ${idx + 1} (full)");
        } else {
          double fraction = remainingCapacity / wt;
          takenWeight = remainingCapacity;
          profitAdded = pr * fraction;
          remainingCapacity = 0;
          taken.add("Item ${idx + 1} (${(fraction * 100).toStringAsFixed(1)}%)");
        }
      } else {
        if (wt <= remainingCapacity) {
          takenWeight = wt;
          profitAdded = pr;
          remainingCapacity -= wt;
          taken.add("Item ${idx + 1}");
        } else {
          taken.add("Item ${idx + 1} (skipped)");
          continue;
        }
      }
      totalProfit += profitAdded;
      steps.add({
        'item': "Item ${idx + 1}",
        'weight': takenWeight,
        'profit': profitAdded,
        'remaining': remainingCapacity,
      });

      // Update the UI after processing each item.
      setState(() {
        algorithmSteps = List.from(steps);
        finalProfit = totalProfit;
        itemsTaken = List.from(taken);
      });

      // Wait for 700 milliseconds before processing the next item.
      await Future.delayed(Duration(milliseconds: 700));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number of items input with an update button.
          Text(
            "Enter number of items:",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: numItemsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Number of items",
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  int n = int.tryParse(numItemsController.text) ?? 0;
                  if (n > 0) {
                    setState(() {
                      numItems = n;
                      _updateControllers(n);
                    });
                  }
                },
                child: Text("Set Items"),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Switch between 0/1 and Fractional knapsack.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0/1 Knapsack",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Switch(
                value: isFractional,
                onChanged: (value) {
                  setState(() {
                    isFractional = value;
                  });
                },
              ),
              Text(
                "Fractional Knapsack",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Horizontal list view for entering weights.
          if (numItems > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.fitness_center,
                        color: Theme.of(context).colorScheme.onPrimary),
                    SizedBox(width: 4),
                    Text(
                      "Enter Weights:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: numItems,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          controller: weightControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Weight ${index + 1}",
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          SizedBox(height: 16),
          // Horizontal list view for entering profits.
          if (numItems > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money,
                        color: Theme.of(context).colorScheme.onPrimary),
                    SizedBox(width: 4),
                    Text(
                      "Enter Profits:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: numItems,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          controller: profitControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Profit ${index + 1}",
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          SizedBox(height: 16),
          // Knapsack capacity input.
          Text(
            "Enter Knapsack Capacity:",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: capacityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Capacity",
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Display dynamic Items Data table after input fields.
          if (numItems > 0)
            FadeIn(
              duration: Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items Data:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: screenWidth,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text("Item",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                        DataColumn(
                            label: Text("Weight",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                        DataColumn(
                            label: Text("Profit",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                      ],
                      rows: List.generate(numItems, (index) {
                        String weightText = (index < weightControllers.length)
                            ? weightControllers[index].text
                            : "";
                        String profitText = (index < profitControllers.length)
                            ? profitControllers[index].text
                            : "";
                        return DataRow(
                          cells: [
                            DataCell(Text("Item ${index + 1}",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                            DataCell(Text(weightText,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                            DataCell(Text(profitText,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          // Run button now appears after the dynamic Items Data table.
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text("Run Greedy Algorithm"),
              onPressed: _runGreedyAlgorithm,
            ),
          ),
          SizedBox(height: 16),
          // Display the algorithm steps in a table if available with horizontal scrolling.
          if (algorithmSteps.isNotEmpty)
            ZoomIn(
              duration: Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Algorithm Steps:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text("Item",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                        DataColumn(
                            label: Text("Weight Taken",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                        DataColumn(
                            label: Text("Profit Added",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                        DataColumn(
                            label: Text("Remaining Capacity",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme.onPrimary))),
                      ],
                      rows: algorithmSteps.map((step) {
                        return DataRow(cells: [
                          DataCell(Text(step['item'].toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme.onPrimary))),
                          DataCell(Text(step['weight'].toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme.onPrimary))),
                          DataCell(Text(step['profit'].toStringAsFixed(2),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme.onPrimary))),
                          DataCell(Text(step['remaining'].toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme.onPrimary))),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          // Final answer summary.
          if (algorithmSteps.isNotEmpty)
            BounceInDown(
              duration: Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Final Result:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Maximum Profit: ${finalProfit.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    "Items Taken: ${itemsTaken.join(', ')}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          // Reset button appears only after the algorithm is run.
          if (algorithmSteps.isNotEmpty)
            Center(
              child: ElevatedButton(
                onPressed: _resetVisualizer,
                child: Text("Reset"),
              ),
            ),
        ],
      ),
    );
  }
}
