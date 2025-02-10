import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class knapsackDP extends StatefulWidget {
  @override
  _knapsackDPState createState() => _knapsackDPState();
}

class _knapsackDPState extends State<knapsackDP> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
"What is the difference between the 0/1 Knapsack problem and the Fractional Knapsack problem? Explain why dynamic programming is used for the 0/1 Knapsack problem",
"Define the recursive formula for solving the 0/1 Knapsack problem using dynamic programming",
"Given n items with their respective weights and values, explain how to construct the DP table for solving the Knapsack problem", 
'''Solve the 0/1 Knapsack problem using dynamic programming for the following instance:  
Items = {(weight=2, value=3), (weight=3, value=4), (weight=4, value=5), (weight=5, value=6)}  
Knapsack capacity = 5''',  
"What is the time complexity of the dynamic programming approach for solving the 0/1 Knapsack problem? How does it compare with the recursive approach?",  
"How does the space complexity of the standard DP approach compare with the space-optimized version using a 1D array?",  
"What happens in the DP table if an item's weight is greater than the remaining knapsack capacity? Explain with an example",  
"Modify the dynamic programming approach to print the items included in the optimal solution instead of just the maximum value",
"Consider a case where all items have the same weight but different values. How does the DP approach behave in such cases?",  
"Implement the 0/1 Knapsack problem using dynamic programming in a language of your choice and test it with sample inputs",  
"How can the 0/1 Knapsack DP approach be modified to work with fractional weights (i.e., solve the Fractional Knapsack problem)?",
"If a problem has a constraint where an item can be taken multiple times, how would you modify the DP approach to solve the Unbounded Knapsack problem?",
"Explain how memoization can be used in solving the 0/1 Knapsack problem. How does it compare with the iterative DP approach?",
"Given a set of n items, describe how the DP table changes as we increase the knapsack’s capacity from 1 to W, where W is the maximum capacity",
"In real-life applications, where can the 0/1 Knapsack problem using dynamic programming be applied? Give at least three practical examples",  
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
            "Knapsack Problem(Dynamic Programming)",
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
The Knapsack Problem involves selecting items with given weights and values to maximize total value without exceeding a given weight capacity. The 0/1 Knapsack Problem only allows taking an item completely or not at all.  
Dynamic Programming (DP) efficiently solves this by breaking it into smaller subproblems and storing results to avoid recomputation.  

2. THE PROBLEM
Given:  
    `n` items, each with `weight[i]` and `value[i]`  
    A knapsack with maximum capacity `W`  

Goal: Maximize total value without exceeding `W`.  

3. EXAMPLE  
For 4 items and a knapsack capacity of 5:  

    Item : Weight : Value    
    1    : 2      : 3      
    2    : 3      : 4       
    3    : 4      : 5       
    4    : 5      : 6       

4. DYNAMIC PROGRAMMING APPROACH
A table `dp[i][w]` is used where:  
    `i` represents the first `i` items considered  
    `w` represents the knapsack capacity  
    `dp[i][w]` stores the maximum value achievable  

    Recurrence relation 
        If `weight[i] > w`:  
          `dp[i][w] = dp[i - 1][w]`  
        Otherwise:  
          `dp[i][w] = max(dp[i - 1][w], value[i] + dp[i - 1][w - weight[i]])`  

5. TIME COMPLEXITY
The time complexity of knapsack problem using the dynamic programming approach would be : t(n) = O(nW), where W is the capacity of Knapsack


Real-Life Applications  
    Resource Allocation: Assigning limited resources efficiently  
    Finance: Investment and budgeting decisions  
    Logistics: Packing items optimally for transportation  
    Cloud Computing: Managing computational resources  

Conclusion  
Dynamic Programming provides an efficient O(nW) approach to solving the 0/1 Knapsack Problem. Using a 1D array, space complexity is reduced to O(W), making it practical for large inputs. The problem has applications in finance, logistics, and optimization tasks.
''',

'''
ALGORITHM:
function knapsackDP(weights, values, W, n):
    create dp array of size (n+1) x (W+1)

    for i = 0 to n:
        for w = 0 to W:
            if i == 0 or w == 0:
                dp[i][w] = 0  // Base case: No items or no capacity
            else if weights[i-1] <= w:
                dp[i][w] = max(values[i-1] + dp[i-1][w - weights[i-1]], dp[i-1][w])  // Include or exclude item
            else:
                dp[i][w] = dp[i-1][w]  // Item too heavy, exclude

    return dp[n][W]  // Maximum value possible

QUICK EXPLANATION:  
Initialization:
A 2D array dp[i][w] is created to store maximum value for i items and capacity w.
Base cases: dp[0][w] = 0 (no items) and dp[i][0] = 0 (capacity 0).

Filling the DP Table:
Loop through each item i and each capacity w.
If the item can fit (weights[i-1] <= w), choose the maximum of:
    Including it: values[i-1] + dp[i-1][w - weights[i-1]]
    Excluding it: dp[i-1][w]
If the item is too heavy, exclude it (dp[i-1][w]).

Result:
The maximum value is found at dp[n][W].
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
