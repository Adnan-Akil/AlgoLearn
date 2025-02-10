import 'package:flutter/material.dart';

class theory extends StatefulWidget {
  @override
  _theoryState createState() => _theoryState();
}

class _theoryState extends State<theory> {
  final PageController _pageController = PageController();
  final int numPages = 4; // now 4 topics instead of 4 sections of one topic

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Theory",
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

  const PageContent({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  // Update the titles so that each page reflects one topic.
  static const List<String> pageTitles = [
    "Run Time Analysis",
    "Branch and Bound",
    "Traversal Methods",
    "Dynamic Programming",
  ];

  // Replace the previous four sections with new content for each topic.
  static const List<String> pageContents = [
    // Topic 1: Run Time Analysis
    '''
1. INTRODUCTION
Run-time analysis examines how an algorithm’s execution time grows with input size (n). It is vital for comparing algorithms, optimizing performance, and ensuring scalability. This analysis guides developers in selecting the most efficient algorithms for both small and large-scale systems.

2. TYPE OF ANALYSIS
Worst-Case (O(n))
  Represents the maximum time required for any input of size n.
  Example: QuickSort can degrade to O(n²) when a poor pivot is chosen, leading to highly unbalanced partitions.
Best-Case (Ω(n))
  Indicates the minimum time under ideal conditions.
  Example: Insertion Sort runs in Ω(n) time when the input list is already sorted, requiring minimal operations.
Average-Case (Θ(n))
  Reflects the expected performance over all inputs, assuming a uniform distribution.
  Example: QuickSort averages O(n log n) with effective pivot selection and balanced partitions.

3. ASYMPTOTIC NOTATIONS
O(n): An upper bound describing the worst-case scenario (e.g., Linear Search).
Ω(n): A lower bound showing the best-case performance (e.g., optimized insertions).
Θ(n): A tight bound that captures both the upper and lower limits (e.g., Merge Sort).

These notations simplify comparisons by abstracting constant factors and low-order terms, focusing on scalability.

4. COMMON COMPLEXITIES
O(1): Constant time, such as accessing an array element or a Hash Table Lookup.
O(log n): Logarithmic time found in algorithms like Binary Search.
O(n): Linear time, as seen with Linear Search.
O(n log n): Quasilinear time, typical of efficient sorting algorithms like Merge Sort.
O(n²): Quadratic time, commonly observed in Bubble Sort.
O(2ⁿ) & O(n!): Exponential and factorial complexities that occur in brute-force approaches for certain combinatorial problems.

5. MATHEMATICAL ANALYSIS
Recurrence relations are a key tool for analyzing recursive algorithms. For example:
Merge Sort:
  Recurrence: T(n) = 2T(n/2) + O(n)
  Solution: Solved by substitution, recursion tree, or the Master Theorem to yield O(n log n).
  These methods allow us to predict performance and understand the behavior of divide-and-conquer strategies.

6. APPLICATOINS
Run-time analysis is critical in many fields:
  Web Applications: Enhanced performance through faster search and retrieval.
  AI & ML: Optimized algorithms reduce training times and improve responsiveness.
  Cybersecurity: Quick encryption and decryption algorithms enhance security measures.
  Embedded Systems: Efficient run-time performance ensures reliable real-time operations.
    ''',

    // Topic 2: Branch and Bound
    '''
1. INTRODUCTION
Branch and Bound is a systematic optimization technique used to solve combinatorial problems by exploring the solution space while eliminating branches that cannot yield better results. It is especially useful for tackling NP-hard problems.

2. CORE CONCEPTS
Branching:
  Divides a problem into smaller, manageable subproblems, forming a state space tree.
  Each node in this tree represents a partial solution that may lead to a complete solution upon further exploration.
Bounding:
  Calculates an upper or lower bound to determine if a branch is worth pursuing.
  If the bound is worse than the current best solution, that branch is pruned, saving computational effort.

3. STATE SPACE TREE
Structure:
  A hierarchical tree where each node represents a decision point or partial solution.
Purpose:
  Provides a visual and systematic way to explore all potential solutions, highlighting unpromising paths early in the search process.
  Example:
  In the Traveling Salesman Problem, nodes represent partial routes, and a bounding function estimates the minimum possible tour cost from that node onward.

4. TECHNIQUES AND APPLICATIONS
Bounding Functions:
  Often leverage heuristics to provide tighter estimates, improving pruning efficiency.
Real-World Applications:
  Used in solving the Knapsack Problem, Vehicle Routing, and various scheduling problems.
  Common in resource allocation, logistics, and integer programming where exhaustive search is impractical.

5. CONSIDERATIONS
Computational Complexity:
  Although it significantly prunes the search space in practice, the worst-case time complexity remains exponential for many problems.
Practical Use:
  When tailored with domain-specific knowledge, branch and bound becomes a powerful tool for finding optimal solutions in complex environments.
    ''',

    // Topic 3: Traversal Methods (BFS & DFS)
    '''
1. Introduction
Traversal methods are essential techniques for systematically exploring nodes and edges in data structures like graphs and trees. They form the backbone of many algorithms in search, pathfinding, and problem-solving.

2. BREADTH-FIRST SEARCH(BFS)
Method:
  Explores nodes level by level using a queue.
  Visits all nodes at the current depth before moving deeper into the structure.
Advantages:
  Guarantees the shortest path in unweighted graphs.
  Particularly useful for tasks such as web crawling and finding the minimum number of moves in puzzles.
Usage Example:
  In maze solving or grid-based pathfinding, BFS quickly identifies the shortest route from the start point to the destination.

3. DEPT-FIRST SEARCH(DFS)
Method:
  Explores as deep as possible along one branch before backtracking, typically implemented recursively or using a stack.
Advantages:
  Generally requires less memory than BFS because it does not store all nodes at each level.
  Ideal for applications like cycle detection, topological sorting, and exhaustive searches.
Usage Example:

4. COMPARISON
BFS vs. DFS:
  BFS: Best for shortest path problems and level-order traversal, though it may require significant memory for wide graphs.
  DFS: More memory-efficient for deep but narrow graphs and useful when the solution is expected to be far from the root.
Additional Methods:
  Variants such as Iterative Deepening Search (IDS) combine the space-efficiency of DFS with the optimality of BFS in certain contexts.
Real-World Applications:
  Utilized in network analysis, AI decision making, social network explorations, and many search-related tasks.
    ''',

    // Topic 4: Dynamic Programming
    '''
1. INTRODUCTION
Dynamic Programming (DP) is an approach used to solve problems by breaking them into simpler subproblems, solving each once, and storing their solutions. This technique is particularly effective when subproblems overlap, eliminating redundant computations.

2. KEY TERMINOLOGY
Optimal Substructure:
  An optimal solution can be composed of optimal solutions of its subproblems.
Overlapping Subproblems:
  Many subproblems are solved multiple times; DP caches these results to improve efficiency.
State Transition:
  Involves formulating how to move from smaller subproblems to the overall problem, often represented through recurrence relations.

3. DIFFERENT APPROACHES
Top-Down (Memoization):
  Solves the problem recursively and caches the results to avoid redundant work.
  Particularly intuitive when the recursive structure of the problem is clear.
Bottom-Up (Tabulation):
  Iteratively solves subproblems starting from the simplest, building up to the final solution in a structured table.
  Often results in more efficient use of memory and can be easier to optimize.

4. APPLICATIONS
Classic Problems:
  Fibonacci sequence calculation, Longest Common Subsequence (LCS), and the Knapsack Problem.
Extended Uses:
  Widely used in financial modeling, bioinformatics (e.g., sequence alignment), and operational research.
Real-World Example:
  In route planning or resource allocation, DP helps optimize costs by systematically evaluating and comparing all possibilities.

5. PROS AND CONS
Advantages:
  Dramatically reduces the time complexity for problems with overlapping subproblems by reusing previously computed results.
  Provides a clear, structured framework for breaking down and solving complex decision-making challenges.
Considerations:
  Often requires additional memory to store intermediate results.
  Formulating the correct state transitions can be challenging and may require a deep understanding of the problem structure.
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
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'Sans-Serif',
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
