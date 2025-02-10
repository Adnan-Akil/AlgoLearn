import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class knapsackBacktrack extends StatefulWidget {
  @override
  _knapsackBacktrackState createState() => _knapsackBacktrackState();
}

class _knapsackBacktrackState extends State<knapsackBacktrack> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
    "Explain the concept of the knapsack problem and how backtracking can be used to solve the 0/1 knapsack problem",
    "What are the advantages and limitations of using backtracking for the knapsack problem compared to dynamic programming?",
    "Describe the basic idea behind the backtracking approach for the 0/1 knapsack problem. How does it explore different subsets of items?",
    "Given a knapsack with a capacity of 50 units and the following items: (weight, value) = (10, 60), (20, 100), (30, 120), apply the backtracking algorithm and find the maximum value",
    "How does the backtracking algorithm decide whether to include or exclude an item in the solution?",
    "Discuss the importance of pruning in backtracking when solving the knapsack problem. How can it improve efficiency?",
    "Write the pseudo code for the backtracking algorithm to solve the 0/1 knapsack problem",
    "What are the base cases in the backtracking solution for the 0/1 knapsack problem, and why are they necessary?",
    "Given the following items: (weight, value) = (5, 10), (10, 20), (15, 30), and a knapsack capacity of 25, implement the backtracking approach and calculate the maximum value",
    "How does backtracking handle multiple recursive calls when exploring different combinations of items for the knapsack?",
    "Explain the concept of 'branch and bound' in the context of the knapsack problem and how it improves backtracking efficiency",
    "What is the time complexity of the backtracking approach for the knapsack problem, and how does it compare to other algorithms like dynamic programming?",
    "How can the backtracking approach be modified to handle fractional knapsack problems?",
    "Provide an example where the backtracking algorithm fails to be the most efficient method for solving the knapsack problem and suggest an alternative",
    "How does backtracking ensure that every possible combination of items is considered for the knapsack, and what role does recursion play in this process?",
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
          backgroundColor:  Theme.of(context).colorScheme.primary,
          title: Text(
            "Knapsack Problem(Backtracking)",
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
                      Icon(Icons.home, size: 30, color: Theme.of(context).colorScheme.onPrimary),
                      Text("Home", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600)),
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
                      Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onPrimary),
                      Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600)),
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

  const PageContent({Key? key, required this.pageIndex, required this.question, required this.refreshQuestion}) : super(key: key);

  static const List<String> pageTitles = ["Overview", "Algorithm", "Visualization", "Quiz"];
  static const List<String> pageContents = [ //this include the entire content of the topic!
'''
1. INTRODUCTION
The 0/1 Knapsack Problem is an NP-hard combinatorial optimization problem. Given a set of items—each with a weight and value—and a knapsack with limited capacity W, the goal is to select a subset of items to maximize total value without exceeding the capacity. In the 0/1 version, items are either fully included or excluded.

2. THE PROBLEM
For n items with weights w[i] and values v[i], we choose a binary vector X = {x[1], x[2], ..., x[n]} such that the total weight Σ x[i]*w[i] ≤ W and the total value Σ x[i]*v[i] is maximized.

3. BACKTRACKING
Backtracking systematically explores all possible subsets of items using recursion. At each step, it decides whether to include or exclude the current item, forming a binary decision tree where each leaf represents a complete selection of items.

3.1 Tree Structure
    Each level corresponds to an item, with two branches: include (1) or exclude (0).
    Leaves represent complete solutions.
    The best valid solution (total weight ≤ W and maximum value) is tracked.

3.2 Recursion and Base Case
    A recursive function takes the current index, accumulated weight, and accumulated value.
    The base case occurs when all items are considered.
    At the base case, if the weight is within W, update the best solution if the value is higher than previously found.

3.3 Including and Excluding Items
    Including an item adds its weight and value, but only if the new weight does not exceed W.
    Excluding an item leaves the current state unchanged.
    The algorithm recurses on both choices.

3.4 Pruning the Search Tree
    Pruning stops the exploration of a branch if the accumulated weight exceeds W.
    Additional pruning can estimate the maximum remaining value; if this plus the current value is less than the best found, the branch is discarded.
    These techniques reduce the number of subsets examined, though worst-case time remains exponential.

3.5 Time and Memory Considerations
    Without pruning, 2^n subsets are explored.
    Effective pruning reduces practical runtime.
    The recursion depth is O(n), so memory usage for the call stack is O(n).

4. EXAMPLE
Consider 3 items:
  Item 1: Weight = 5, Value = 10
  Item 2: Weight = 4, Value = 40
  Item 3: Weight = 6, Value = 30
Knapsack capacity, W = 10.
Start with Item 1:
    Option 1: Include Item 1 → (Weight = 5, Value = 10).
        Option 1a: Include Item 2 → (Weight = 9, Value = 50).
        Option 1a1: Including Item 3 would exceed capacity (Weight 15); prune.
        Option 1a2: Exclude Item 3 → valid solution (Weight = 9, Value = 50).
        Option 1b: Exclude Item 2 → (Weight = 5, Value = 10).
        Option 1b1: Including Item 3 exceeds capacity (Weight = 11); prune.
        Option 1b2: Exclude Item 3 → solution remains (Weight = 5, Value = 10).
    Option 2: Exclude Item 1 and explore remaining items similarly.
    The algorithm evaluates all branches, updating the best valid solution.

Conclusion:
The backtracking approach for the 0/1 Knapsack Problem explores every possible subset through recursive inclusion and exclusion of items. Pruning techniques discard branches that exceed the capacity or cannot beat the current best solution, improving practical performance even though the worst-case complexity remains exponential. This method ensures that all valid combinations are considered to find the optimal solution.  
''',

'''
ALGORITHM:
function knapsackBacktracking(i, currentWeight, currentValue, bestValue, items, capacity):
    if i >= length(items):  // Base case: all items considered
        if currentWeight <= capacity and currentValue > bestValue:
            bestValue = currentValue  // Update the best solution found so far
        return bestValue

    // Option 1: Include the current item (item[i])
    if currentWeight + items[i].weight <= capacity:
        bestValue = knapsackBacktracking(i + 1, currentWeight + items[i].weight, 
            currentValue + items[i].value, bestValue, items, capacity)

    // Option 2: Exclude the current item (item[i])
    bestValue = knapsackBacktracking(i + 1, currentWeight, currentValue, bestValue, items, capacity)
    return bestValue

function solveKnapsack(items, capacity):
    bestValue = 0
    bestValue = knapsackBacktracking(0, 0, 0, bestValue, items, capacity)
    return bestValue

QUICK EXPLANATION:  
knapsackBacktracking(i, currentWeight, currentValue, bestValue, items, capacity):

Recursively explores including or excluding each item.
If all items are considered, it updates the bestValue if the current selection's weight is within capacity and has a higher value.
Two options: Include the current item (if weight allows) or exclude it, and continue the recursion.
solveKnapsack(items, capacity):

Initializes bestValue as 0 and starts the backtracking recursion from the first item.
Returns the best value found after exploring all combinations.
''',

"This section will contain a graph-based visualization where the user can input dimensions and see the optimal order of matrix multiplication.",
''' 


'''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
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
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color:  Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'Sans-Serif',
                  ),
                ),
                if (pageIndex == 3)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ZoomIn(
                          child: Text(
                            question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.07,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.error,
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
