import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

/// A simple class to represent an edge between two nodes with an associated cost.
class Edge {
  final String from;
  final String to;
  final double cost;
  Edge(this.from, this.to, this.cost);
}

/// A class to hold each step’s details for the tour.
class TourStep {
  final int step;
  final String node;
  final double edgeCost;
  final double cumulativeCost;
  TourStep({
    required this.step,
    required this.node,
    required this.edgeCost,
    required this.cumulativeCost,
  });
}

/// Main widget for the Travelling Salesman Problem visualization.
class travellingSalesman extends StatefulWidget {
  @override
  _travellingSalesmanState createState() => _travellingSalesmanState();
}

class _travellingSalesmanState extends State<travellingSalesman> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
      " What is the Travelling Salesman Problem (TSP)? Explain its formulation in terms of a graph",
    " Why is TSP classified as an NP-hard problem? What makes it computationally challenging? ",
    " Explain how TSP is related to Hamiltonian cycles in a graph",
    " How does the branch and bound approach work for solving TSP?",
    " What are some real-life applications of TSP in logistics and network design?",
    " Implement a brute force algorithm to solve a 4-city TSP problem and display all possible tours",
    " Explain step-by-step how branch and bound would solve a 4-city TSP with the given cost matrix",
    " Develop a recursive algorithm to generate all possible TSP routes and compute their cost"
    " Write a pseudo code for solving TSP using branch and bound and explain its working"
    " Solve a 4-city TSP using dynamic programming (excluding Held-Karp) and show the DP table"
    " Explain how the lower bound in branch and bound helps in pruning unpromising paths while solving TSP"
    " Implement a recursive backtracking solution for TSP and test it on a sample input"
    " Compare the time complexity of brute force, branch and bound, and dynamic programming solutions for TSP when applied to a 5-city problem"
    ''' Solve the following TSP manually using the nearest insertion method (starting from vertex A)
      A	B	C	D	E
    A	0	5	7	9	10
    B	5	0	3	4	8
    C	7	3	0	2	6
    D	9	4	2	0	3
    E	10 8 6 3 0
'''
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
            "Travelling Salesman Problem",
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

///
/// The PageContent widget handles the content for each page.
///
class PageContent extends StatelessWidget {
  final int pageIndex;
  final String question;
  final VoidCallback refreshQuestion;

  const PageContent({
    Key? key,
    required this.pageIndex,
    required this.question,
    required this.refreshQuestion,
  }) : super(key: key);

  static const List<String> pageTitles = [
    "Overview",
    "Algorithm",
    "Visualization",
    "Quiz"
  ];
  static const List<String> pageContents = [
    // Overview page content
'''
1. INTRODUCTION  
The Travelling Salesman Problem (TSP) is one of the most fundamental problems in combinatorial optimization and computer science. It involves finding the shortest possible route that visits each city exactly once and returns to the starting city.  

2. GRAPH REPRESENTATION
TSP is typically represented using a graph, where:  
Cities are represented as nodes (vertices).  
Paths between cities are represented as edges with associated costs (distances).  
The goal is to find a Hamiltonian cycle (a cycle that visits every node exactly once and returns to the starting node) with the minimum total cost.  

A distance matrix is commonly used to store the pairwise distances between cities, making it easier to work with computationally.  

3. COMPLEXITY OF TSP
TSP is classified as an NP-hard problem, meaning that no known polynomial-time algorithm can solve all instances of TSP efficiently. The number of possible routes increases factorially with the number of cities:  

  If there are n cities, the total number of possible tours (without considering direction) is (n-1)! / 2.  
  The makes the problem computationally intractable for large values of n.  

  For example, with just 10 cities the number of possible tours is 181,440, and with 20 cities it becomes 60.8 trillion.  

4. BRUTE FORCE APPROACH
The simplest approach to solving TSP is to **generate all possible tours** and compute their cost to find the optimal one. This method guarantees an optimal solution but is impractical for large **n** due to factorial growth.  

Time Complexity: O(n!)  

5. SOLVING TSP  
5.1 Branch and Bound  
Branch and Bound reduces the number of solutions to be explored by pruning branches that cannot lead to an optimal solution.  

  The algorithm partitions the search space into smaller subproblems (branches).  
  For each branch, a lower bound on the possible tour cost is calculated.  
  If the lower bound of a branch exceeds the best known solution, that branch is discarded.  
  This reduces the number of cases to explore, though it still remains exponential in the worst case.  
  
  Time Complexity: O(n!) (but much better in practice with pruning).  

5.2 Dynamic Programming Approach  
Another way to solve TSP exactly is using dynamic programming, where we break the problem into subproblems and store solutions to avoid redundant computations.  

  A state is represented as (current city, set of visited cities).  
  The solution builds up the shortest tour recursively by storing and reusing results of smaller subproblems.  
  A table is maintained where each entry corresponds to the minimum cost of visiting a subset of cities ending at a specific city.  
  
  Time Complexity: O(n² * 2ⁿ), which is still exponential but better than brute force.  

6. REAL WORLD APPLICATIONS  
TSP is not just a theoretical problem; it has many real-world applications, including:  

  Logistics and Route Optimization – Used by delivery services (e.g., UPS, FedEx) to minimize travel time and fuel consumption.  
  Manufacturing – Optimizing the movement of robotic arms to minimize travel distance between assembly points.  
  Network Design – Optimizing the layout of fiber optic or electrical networks.  
  Genome Sequencing – Finding the shortest way to assemble DNA fragments in computational biology.  
''',
    // Algorithm page content
    '''
ALGORITHM:
Function TSP_BranchAndBound(graph, n):
    Initialize minCost = ∞
    Create an array visited[n] and mark all cities as unvisited
    Initialize a priority queue PQ for storing partial solutions
    Compute the lower bound for the initial city and push (cost, path, visited) into PQ

    While PQ is not empty:
        Pop the node with the lowest bound (currentCost, currentPath, visitedCities)
        
        If all cities are visited and path returns to start:
            If currentCost < minCost:
                minCost = currentCost
                bestPath = currentPath
            Continue

        For each unvisited city nextCity:
            Compute newCost = currentCost + cost from currentCity to nextCity
            Compute newLowerBound = newCost + heuristic estimate
            If newLowerBound < minCost:
                Push (newLowerBound, updatedPath, updatedVisitedCities) into PQ

    Return bestPath and minCost

QUICK EXPLANATION:  

We start by setting minCost to infinity (∞) to store the best solution found.
A visited array is used to track which cities have been visited.
A priority queue (PQ) is used to explore the most promising paths first (i.e., those with the lowest bound).

The lower bound is an estimate of the minimum tour cost if we continue on the current path.
This helps in pruning unpromising branches.

The algorithm expands the current node by visiting each unvisited city.
The new cost is computed by adding the distance between the current city and the next city.
A heuristic estimate is added to compute a new lower bound.

If the computed lower bound is greater than minCost, we discard that path (pruning).
Otherwise, we push the new path into the priority queue.

If all cities are visited and the path returns to the starting city, we update minCost if the new path is shorter than the previously known best path.

After exploring all promising paths, the algorithm returns the shortest tour and its cost.
''',

"",
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
            child: pageIndex == 2
                ? TSPVisualizationWidget()
                : ListView(
                    children: [
                      Text(
                        pageContents[pageIndex],
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          color: Theme.of(context).colorScheme.onPrimary,
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

///
/// The TSPVisualizationWidget contains the input field, simulation logic, graph drawing,
/// and a table that shows detailed tour step data. It now uses an AnimationController to
/// animate the drawing of each edge on the graph in real time.
///
class TSPVisualizationWidget extends StatefulWidget {
  @override
  _TSPVisualizationWidgetState createState() => _TSPVisualizationWidgetState();
}

class _TSPVisualizationWidgetState extends State<TSPVisualizationWidget>
    with TickerProviderStateMixin {
  // Single controller for combined edge and cost input.
  final TextEditingController _inputController = TextEditingController();

  bool simulationStarted = false;
  bool simulationCompleted = false;
  int currentVisitedIndex = 0; // Indicates the starting node index for the current edge.
  List<int> tour = []; // Optimal tour as a list of node indices.
  double lowestCost = 0.0;

  /// Sorted list of node labels (e.g., ["A", "B", "C"]).
  List<String> sortedNodes = [];
  /// List of edges parsed from user input.
  List<Edge> edges = [];
  /// Detailed tour steps for display in a table.
  List<TourStep> tourSteps = [];

  // Animation controller for drawing the current edge.
  late AnimationController _edgeController;
  late Animation<double> _edgeAnimation;

  @override
  void initState() {
    super.initState();
    _edgeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _edgeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_edgeController)
          ..addListener(() {
            setState(() {});
          });
    _edgeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // When the current edge is fully drawn, update the currentVisitedIndex.
        if (currentVisitedIndex < tour.length - 2) {
          setState(() {
            currentVisitedIndex++;
          });
          _edgeController.forward(from: 0.0);
        } else {
          // Last edge completed.
          setState(() {
            currentVisitedIndex = tour.length - 1;
            simulationCompleted = true;
          });
        }
      }
    });
  }

  /// Called when "Run" is tapped.
  void _runSimulation() {
    String input = _inputController.text.trim();
    if (input.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter graph data.")));
      return;
    }
    // Parse input expecting entries like "A-B:5".
    List<String> tokens =
        input.split(',').map((s) => s.trim()).toList();
    List<Edge> edgeList = [];
    Set<String> nodesSet = {};
    for (String token in tokens) {
      List<String> parts = token.split(':');
      if (parts.length != 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid format in '$token'. Use A-B:cost")));
        return;
      }
      String edgePart = parts[0].trim();
      String costPart = parts[1].trim();
      double? cost = double.tryParse(costPart);
      if (cost == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid cost in '$token'")));
        return;
      }
      List<String> nodes =
          edgePart.split('-').map((s) => s.trim()).toList();
      if (nodes.length != 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invalid edge format in '$token'. Use A-B")));
        return;
      }
      String from = nodes[0];
      String to = nodes[1];
      nodesSet.add(from);
      nodesSet.add(to);
      edgeList.add(Edge(from, to, cost));
    }

    // Save parsed edges.
    setState(() {
      edges = edgeList;
    });

    // Build the graph as a Map.
    Map<String, Map<String, double>> graph = {};
    for (Edge edge in edgeList) {
      graph.putIfAbsent(edge.from, () => {});
      graph.putIfAbsent(edge.to, () => {});
      graph[edge.from]![edge.to] = edge.cost;
      graph[edge.to]![edge.from] = edge.cost; // Assume symmetric.
    }

    // Create a sorted list of nodes.
    List<String> nodesList = nodesSet.toList()..sort();
    int n = nodesList.length;

    // Build cost matrix.
    List<List<double>> costMatrix =
        List.generate(n, (_) => List.filled(n, double.infinity));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (i == j) {
          costMatrix[i][j] = 0;
        } else {
          String a = nodesList[i];
          String b = nodesList[j];
          if (graph.containsKey(a) && graph[a]!.containsKey(b)) {
            costMatrix[i][j] = graph[a]![b]!;
          }
        }
      }
    }

    // Compute the optimal TSP tour via brute force.
    List<int> nodesIndices = List.generate(n, (i) => i);
    int start = 0;
    List<int> otherNodes = nodesIndices.sublist(1);
    List<int> bestTour = [];
    double bestCost = double.infinity;
    List<List<int>> permutations = permute(otherNodes);
    for (List<int> perm in permutations) {
      List<int> currentTour = [start] + perm + [start];
      double currentCost = 0;
      bool valid = true;
      for (int i = 0; i < currentTour.length - 1; i++) {
        int u = currentTour[i];
        int v = currentTour[i + 1];
        double edgeCost = costMatrix[u][v];
        if (edgeCost == double.infinity) {
          valid = false;
          break;
        }
        currentCost += edgeCost;
      }
      if (valid && currentCost < bestCost) {
        bestCost = currentCost;
        bestTour = currentTour;
      }
    }

    // Compute tour step details.
    List<TourStep> steps = [];
    double cumulative = 0.0;
    for (int i = 0; i < bestTour.length; i++) {
      String node = nodesList[bestTour[i]];
      double costForEdge = 0.0;
      if (i > 0) {
        String prevNode = nodesList[bestTour[i - 1]];
        costForEdge = graph[prevNode]?[node] ?? 0.0;
        cumulative += costForEdge;
      }
      steps.add(TourStep(
          step: i,
          node: node,
          edgeCost: costForEdge,
          cumulativeCost: cumulative));
    }

    setState(() {
      simulationStarted = true;
      simulationCompleted = bestTour.isEmpty ? true : false;
      currentVisitedIndex = 0;
      tour = bestTour;
      lowestCost = bestCost;
      sortedNodes = nodesList;
      tourSteps = steps;
    });

    // If a valid tour was found, start animating the edges.
    if (bestTour.isNotEmpty) {
      _edgeController.forward(from: 0.0);
    }
  }

  /// Helper: Generates all permutations of a list of integers.
  List<List<int>> permute(List<int> list) {
    if (list.length == 1) return [list];
    List<List<int>> perms = [];
    for (int i = 0; i < list.length; i++) {
      int current = list[i];
      List<int> remaining = List.from(list)..removeAt(i);
      for (List<int> p in permute(remaining)) {
        perms.add([current] + p);
      }
    }
    return perms;
  }

  void _resetSimulation() {
    _edgeController.reset();
    setState(() {
      simulationStarted = false;
      simulationCompleted = false;
      currentVisitedIndex = 0;
      tour = [];
      lowestCost = 0.0;
      sortedNodes = [];
      edges = [];
      tourSteps = [];
      _inputController.clear();
    });
  }

  @override
  void dispose() {
    _edgeController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input field for graph data.
          TextField(
            controller: _inputController,
            decoration: InputDecoration(
              labelText: "Edges (e.g. A-B:5, B-C:10, A-C:20)",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          // Run button starts the TSP calculation and animation.
          ElevatedButton(
            onPressed: simulationStarted ? null : _runSimulation,
            child: Text("Run"),
          ),
          SizedBox(height: 20),
          // Graph area with real-time edge animation.
          if (simulationStarted && sortedNodes.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: GraphPainter(
                  tour: tour,
                  currentVisitedIndex: currentVisitedIndex,
                  // Use a default value of 0.0 if simulation hasn't started.
                  edgeProgress: simulationStarted ? _edgeAnimation.value : 0.0,
                  numNodes: sortedNodes.length,
                  nodeLabels: sortedNodes,
                  edges: edges,
                ),
              ),
            ),
          SizedBox(height: 20),
          // Data Table: Show detailed tour steps.
          if (simulationStarted && tourSteps.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Step")),
                  DataColumn(label: Text("Node")),
                  DataColumn(label: Text("Edge Cost")),
                  DataColumn(label: Text("Cumulative Cost")),
                ],
                rows: tourSteps.map((step) {
                  final isCurrent = step.step == currentVisitedIndex;
                  return DataRow(
                    cells: [
                      DataCell(Text(step.step.toString())),
                      DataCell(Text(step.node)),
                      DataCell(Text(step.edgeCost.toString())),
                      DataCell(Text(step.cumulativeCost.toString())),
                    ],
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                      if (isCurrent)
                        return Colors.greenAccent.withOpacity(0.5);
                      return null;
                    }),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: 20),
          // When finished, show the final lowest cost or a message.
          if (simulationCompleted)
            Center(
              child: tour.isNotEmpty
                  ? Text(
                      "Lowest Cost: \$${lowestCost.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      "No complete TSP tour found.",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
            ),
          SizedBox(height: 20),
          // Reset button.
          if (simulationStarted)
            Center(
              child: ElevatedButton(
                onPressed: _resetSimulation,
                child: Text("Reset"),
              ),
            ),
        ],
      ),
    );
  }
}

///
/// The GraphPainter draws the full graph (all provided edges with cost labels)
/// and overlays the computed TSP tour. It uses the edgeProgress value to
/// gradually animate the drawing of the current edge.
///
class GraphPainter extends CustomPainter {
  final List<int> tour;
  final int currentVisitedIndex;
  final double edgeProgress;
  final int numNodes;
  final List<String> nodeLabels;
  final List<Edge> edges;

  GraphPainter({
    required this.tour,
    required this.currentVisitedIndex,
    required this.edgeProgress,
    required this.numNodes,
    required this.nodeLabels,
    required this.edges,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paints for edges and nodes.
    final paintEdge = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;
    final paintEdgeHighlight = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0;

    // Text painter for labels.
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Arrange nodes in a circle.
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    List<Offset> nodePositions = [];
    for (int i = 0; i < numNodes; i++) {
      double angle = (2 * pi * i / numNodes) - (pi / 2);
      Offset pos = Offset(center.dx + radius * cos(angle),
          center.dy + radius * sin(angle));
      nodePositions.add(pos);
    }

    // Draw all provided edges with cost labels.
    for (Edge edge in edges) {
      int indexFrom = nodeLabels.indexOf(edge.from);
      int indexTo = nodeLabels.indexOf(edge.to);
      if (indexFrom == -1 || indexTo == -1) continue;
      Offset pos1 = nodePositions[indexFrom];
      Offset pos2 = nodePositions[indexTo];
      canvas.drawLine(pos1, pos2, paintEdge);

      // Draw cost label at the edge's midpoint.
      Offset midPoint = Offset((pos1.dx + pos2.dx) / 2, (pos1.dy + pos2.dy) / 2);
      textPainter.text = TextSpan(
        text: edge.cost.toString(),
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      Offset labelOffset =
          midPoint - Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, labelOffset);
    }

    // Draw the tour edges with real-time animation.
    if (tour.isNotEmpty) {
      // Draw edges that have been fully animated.
      for (int i = 0; i < currentVisitedIndex; i++) {
        int from = tour[i];
        int to = tour[i + 1];
        canvas.drawLine(nodePositions[from], nodePositions[to], paintEdgeHighlight);
      }
      // Animate the current edge (if available).
      if (currentVisitedIndex < tour.length - 1) {
        int from = tour[currentVisitedIndex];
        int to = tour[currentVisitedIndex + 1];
        Offset startPos = nodePositions[from];
        Offset endPos = nodePositions[to];
        Offset currentPos = Offset.lerp(startPos, endPos, edgeProgress)!;
        canvas.drawLine(startPos, currentPos, paintEdgeHighlight);
      }
    }

    // Draw the nodes.
    for (int i = 0; i < numNodes; i++) {
      Paint nodePaint;
      // Current node (being animated) is green.
      if (tour.isNotEmpty && i == tour[currentVisitedIndex]) {
        nodePaint = Paint()..color = Colors.green;
      }
      // Visited nodes are orange.
      else if (tour.contains(i)) {
        nodePaint = Paint()..color = Colors.orange;
      }
      // Unvisited nodes are blue.
      else {
        nodePaint = Paint()..color = Colors.blue;
      }
      canvas.drawCircle(nodePositions[i], 10, nodePaint);

      // Draw the node label.
      textPainter.text = TextSpan(
        text: nodeLabels[i],
        style: TextStyle(color: Colors.white, fontSize: 12),
      );
      textPainter.layout();
      Offset textOffset = nodePositions[i] -
          Offset(textPainter.width / 2, textPainter.height / 2);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.currentVisitedIndex != currentVisitedIndex ||
        oldDelegate.edgeProgress != edgeProgress ||
        oldDelegate.tour != tour ||
        oldDelegate.edges != edges;
  }
}
