import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

void main() {
  runApp(knapsackBB());
}

class knapsackBB extends StatefulWidget {
  @override
  _knapsackBBState createState() => _knapsackBBState();
}

class _knapsackBBState extends State<knapsackBB> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
    "Explain the concept of Branch and Bound in solving optimization problems like the Knapsack problem. How does it differ from the greedy approach?",
    "Describe the general steps involved in solving the Knapsack problem using the Branch and Bound technique",
    "In the Branch and Bound approach for the Knapsack problem, what is the significance of the bounding function?",
    "Given a knapsack with a capacity of 50 units and items with weights and values as: (10, 60), (20, 100), (30, 120), explain the process of solving this problem using the Branch and Bound method",
    "How does the Branch and Bound algorithm decide whether to include or exclude an item in the knapsack during the search tree exploration?",
    "What role does the Upper Bound play in the Branch and Bound technique when solving the Knapsack problem?",
    "What is the time complexity of the Branch and Bound algorithm when solving the Knapsack problem, and how can it be optimized?",
    "Can Branch and Bound be applied to both 0/1 and fractional Knapsack problems? Explain why or why not",
    "Explain how the Branch and Bound method is more efficient than exhaustive search in solving the Knapsack problem",
    "How does the algorithm use pruning to reduce the search space in Branch and Bound for the Knapsack problem?",
    "For a knapsack with a capacity of 60 and 4 items with the following weight-value pairs: (20, 60), (30, 90), (10, 30), (40, 100), demonstrate the use of Branch and Bound to solve the problem",
    "In Branch and Bound, what is the significance of the Lower Bound, and how does it help in pruning the search tree?",
    "How would you modify the Branch and Bound algorithm to handle cases where the value of items is fractional?",
    "Given the items: (weight, value) = (10, 100), (20, 150), (30, 200), (40, 300), and a knapsack capacity of 50 units, show how the Branch and Bound method can be used to find the optimal solution",
    "Compare the Branch and Bound method with the dynamic programming approach in terms of space and time complexity when solving the Knapsack problem"
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
        // Ensure the Scaffold resizes when the keyboard shows up.
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Knapsack Problem(Branch&Bound)",
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
                    children: [
                      Icon(Icons.home, size: 30, color: Theme.of(context).colorScheme.onPrimary),
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
                    children: [
                      Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onPrimary),
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

  const PageContent({
    Key? key,
    required this.pageIndex,
    required this.question,
    required this.refreshQuestion,
  }) : super(key: key);

  static const List<String> pageTitles = ["Overview", "Algorithm", "Visualization", "Quiz"];
  static const List<String> pageContents = [
    '''
1. INTRODUCTION
The 0/1 Knapsack Problem is a classic NP-hard optimization problem. Given a set of items (each with a weight and a value) and a knapsack with limited capacity, the goal is to select a subset of items such that the total weight does not exceed the capacity and the total value is maximized. In the 0/1 version, each item is either taken or left.

2. BRANCH & BOUND
Branch and Bound (B&B) systematically explores the solution space while eliminating suboptimal branches. In the knapsack problem, each decision is binary (include or exclude an item), and the solution space is represented as a decision tree where each node corresponds to a partial solution with a cumulative weight and value.

3. KEY COMPONENTS
• Branching – deciding to include or exclude an item.
• Bounding – computing an upper bound on potential profit.
• Pruning – eliminating branches that cannot beat the best known solution.

4. ALGORITHM FLOW
• Start at the root (no items selected).
• For each item, explore both including and excluding it.
• Compute an upper bound and prune unpromising branches.
• Continue until the best solution is found.

5. CONCLUSION
Branch and Bound significantly reduces the search space compared to brute force.
''',
''' 
ALGORITHM:
function knapsackBranchAndBound(items, capacity):
    sort items by value-to-weight ratio in descending order
    bestValue = 0
    priorityQueue = empty

    rootNode = (level=0, value=0, weight=0, bound=calculateBound(0, 0, 0, items, capacity))
    add rootNode to priorityQueue

    while priorityQueue is not empty:
        currentNode = remove node with highest bound from priorityQueue
        if currentNode.bound <= bestValue:
            continue
        if currentNode.level == length(items):
            continue
        nextItem = items[currentNode.level]
        includeNode = (level=currentNode.level + 1, value=currentNode.value + nextItem.value, weight=currentNode.weight + nextItem.weight)
        if includeNode.weight <= capacity and includeNode.value > bestValue:
            bestValue = includeNode.value

        includeNode.bound = calculateBound(includeNode.level, includeNode.value, includeNode.weight, items, capacity)
        if includeNode.bound > bestValue:
            add includeNode to priorityQueue

        excludeNode = (level=currentNode.level + 1, value=currentNode.value, weight=currentNode.weight, bound=calculateBound(excludeNode.level, excludeNode.value, excludeNode.weight, items, capacity))

        if excludeNode.bound > bestValue:
            add excludeNode to priorityQueue

    return bestValue

function calculateBound(level, value, weight, items, capacity):
    if weight >= capacity:
        return 0

    bound = value
    totalWeight = weight

    for i from level to length(items):
        if totalWeight + items[i].weight <= capacity:
            bound += items[i].value
            totalWeight += items[i].weight
        else:
            bound += (capacity - totalWeight) * (items[i].value / items[i].weight)
            break

    return bound

QUICK EXPLANATION:  
Sorting Items: Items are sorted in descending order based on value-to-weight ratio to maximize value selection.
Priority Queue: The algorithm uses a max-priority queue to explore nodes with the highest bound first.
Root Node Initialization: Starts with an empty knapsack (value=0, weight=0, bound calculated).
Exploring Nodes: The algorithm removes the node with the highest bound and explores two branches:
Include the item: Adds item weight and value, then calculates a new bound.
Exclude the item: Keeps current value and weight but calculates a new bound.
Pruning: If a node’s bound is less than the best found value, it is discarded.
Bounding Function: Estimates an upper bound using a fractional knapsack approach.
Final Answer: The best value found represents the optimal solution.
''',
"",
'''


'''
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
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
              Text(
                pageContents[pageIndex],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: 'Sans-Serif',
                ),
              ),
              // On the Visualization page, show the Knapsack visualizer.
              if (pageIndex == 2)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: KnapsackVisualizerWidget(),
                ),
              if (pageIndex == 3)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Item Model.
class Item {
  final int weight;
  final int profit;
  final double ratio;
  Item({required this.weight, required this.profit}) : ratio = profit / weight;
}

// Tree Node Model.
class TreeNode {
  final int level;
  final int value;
  final int weight;
  final double bound;
  final String decision;
  final List<TreeNode> children;
  final bool pruned;
  TreeNode({
    required this.level,
    required this.value,
    required this.weight,
    required this.bound,
    required this.decision,
    this.children = const [],
    this.pruned = false,
  });
}

// ─────────────────────────────────────────────────────────────
// KnapsackVisualizerWidget: collects user inputs, shows a summary table,
// runs the algorithm, and then displays the results along with the EChart tree visualization.
class KnapsackVisualizerWidget extends StatefulWidget {
  @override
  _KnapsackVisualizerWidgetState createState() => _KnapsackVisualizerWidgetState();
}

class _KnapsackVisualizerWidgetState extends State<KnapsackVisualizerWidget> {
  final TextEditingController _numItemsController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();

  int numItems = 0;
  bool itemsSet = false;

  List<TextEditingController> weightControllers = [];
  List<TextEditingController> profitControllers = [];

  // We still compute the tree for the algorithm.
  TreeNode? algorithmTree;
  bool algorithmRunning = false;
  int bestValue = 0;
  List<bool> bestPath = [];

  void _setItems() {
    setState(() {
      numItems = int.tryParse(_numItemsController.text) ?? 0;
      itemsSet = true;
      weightControllers = List.generate(numItems, (index) => TextEditingController());
      profitControllers = List.generate(numItems, (index) => TextEditingController());
      algorithmTree = null;
    });
  }

  Widget _buildItemsTable() {
    List<DataRow> rows = [];
    for (int i = 0; i < numItems; i++) {
      String weightText = weightControllers[i].text;
      String profitText = profitControllers[i].text;
      rows.add(DataRow(cells: [
        DataCell(Text('Item ${i + 1}', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
        DataCell(Text(weightText, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
        DataCell(Text(profitText, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
      ]));
    }
    return DataTable(
      columns: [
        DataColumn(label: Text("Item", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
        DataColumn(label: Text("Weight", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
        DataColumn(label: Text("Profit", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
      ],
      rows: rows,
    );
  }

  double calculateBound(int index, int currentValue, int currentWeight, List<Item> items, int capacity) {
    if (currentWeight >= capacity) return 0;
    double bound = currentValue.toDouble();
    int totalWeight = currentWeight;
    for (int i = index; i < items.length; i++) {
      if (totalWeight + items[i].weight <= capacity) {
        totalWeight += items[i].weight;
        bound += items[i].profit;
      } else {
        int remain = capacity - totalWeight;
        bound += items[i].profit * (remain / items[i].weight);
        break;
      }
    }
    return bound;
  }

  Future<TreeNode> _branchAndBoundTree(
      int index,
      int currentWeight,
      int currentValue,
      List<Item> items,
      int capacity,
      List<bool> currentPath) async {
    double bound = calculateBound(index, currentValue, currentWeight, items, capacity);
    String decision = index == 0 ? "Start" : (currentPath[index - 1] ? "Include" : "Exclude");

    if (currentWeight > capacity || (index < items.length && bound < bestValue)) {
      bool isPruned = currentWeight > capacity || (index < items.length && bound < bestValue);
      if (index >= items.length && currentValue > bestValue) {
        bestValue = currentValue;
        bestPath = List.from(currentPath);
      }
      return TreeNode(
        level: index,
        value: currentValue,
        weight: currentWeight,
        bound: bound,
        decision: decision,
        pruned: isPruned,
      );
    }

    if (index >= items.length) {
      if (currentValue > bestValue) {
        bestValue = currentValue;
        bestPath = List.from(currentPath);
      }
      return TreeNode(
        level: index,
        value: currentValue,
        weight: currentWeight,
        bound: bound,
        decision: decision,
      );
    }

    currentPath[index] = true;
    TreeNode includeChild = await _branchAndBoundTree(
      index + 1,
      currentWeight + items[index].weight,
      currentValue + items[index].profit,
      items,
      capacity,
      currentPath,
    );
    currentPath[index] = false;
    TreeNode excludeChild = await _branchAndBoundTree(
      index + 1,
      currentWeight,
      currentValue,
      items,
      capacity,
      currentPath,
    );

    return TreeNode(
      level: index,
      value: currentValue,
      weight: currentWeight,
      bound: bound,
      decision: decision,
      children: [includeChild, excludeChild],
    );
  }

  void _runAlgorithm() async {
    List<Item> items = [];
    for (int i = 0; i < numItems; i++) {
      int weight = int.tryParse(weightControllers[i].text) ?? 0;
      int profit = int.tryParse(profitControllers[i].text) ?? 0;
      items.add(Item(weight: weight, profit: profit));
    }
    items.sort((a, b) => b.ratio.compareTo(a.ratio));
    int capacity = int.tryParse(_capacityController.text) ?? 0;
    bestValue = 0;
    bestPath = List.filled(numItems, false);
    setState(() {
      algorithmRunning = true;
    });
    // Compute the tree internally.
    TreeNode tree = await _branchAndBoundTree(
      0,
      0,
      0,
      items,
      capacity,
      List.filled(numItems, false),
    );
    setState(() {
      algorithmTree = tree;
      algorithmRunning = false;
    });
  }

  void _reset() {
    setState(() {
      _numItemsController.clear();
      _capacityController.clear();
      weightControllers.forEach((controller) => controller.clear());
      profitControllers.forEach((controller) => controller.clear());
      itemsSet = false;
      algorithmTree = null;
      algorithmRunning = false;
      bestValue = 0;
      bestPath = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Number of Items and Set Items Button.
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _numItemsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Number of Items",
                  prefixIcon: Icon(Icons.confirmation_number),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: roundedBorder,
                  enabledBorder: roundedBorder,
                  focusedBorder: roundedBorder,
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _setItems,
              icon: Icon(Icons.check_circle),
              label: Text("Set Items"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (itemsSet) ...[
          // Horizontal ListView for Weights.
          Text("Enter Weights:", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: numItems,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: weightControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Weight ${index + 1}",
                      prefixIcon: Icon(Icons.line_weight),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: roundedBorder,
                      enabledBorder: roundedBorder,
                      focusedBorder: roundedBorder,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Horizontal ListView for Profits.
          Text("Enter Profits:", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: numItems,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: profitControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Profit ${index + 1}",
                      prefixIcon: Icon(Icons.attach_money),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: roundedBorder,
                      enabledBorder: roundedBorder,
                      focusedBorder: roundedBorder,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Knapsack Capacity Input.
          TextField(
            controller: _capacityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Knapsack Capacity",
              prefixIcon: Icon(Icons.account_balance_wallet),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: roundedBorder,
              enabledBorder: roundedBorder,
              focusedBorder: roundedBorder,
            ),
          ),
          SizedBox(height: 20),
          // Items Table.
          Container(
            width: MediaQuery.of(context).size.width,
            child: _buildItemsTable(),
          ),
          SizedBox(height: 20),
          // Run Algorithm Button.
          Center(
            child: ElevatedButton.icon(
              onPressed: algorithmRunning ? null : _runAlgorithm,
              icon: Icon(Icons.play_arrow),
              label: Text("Run Algorithm"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
          // After algorithm runs, show results and the EChart tree visualization.
          if (algorithmTree != null) ...[
            SizedBox(height: 20),
            // Display the EChart tree with zoom in/out features.
            EChartTreeWidget(tree: algorithmTree!),
            SizedBox(height: 20),
            Text("Optimal Profit: $bestValue",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary)),
            SizedBox(height: 10),
            Text(
                "Items Selected: ${bestPath.asMap().entries.where((entry) => entry.value).map((entry) => 'Item ${entry.key + 1}').join(', ')}",
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _reset,
                icon: Icon(Icons.refresh),
                label: Text("Reset"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }

  @override
  void dispose() {
    _numItemsController.dispose();
    _capacityController.dispose();
    weightControllers.forEach((controller) => controller.dispose());
    profitControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

/// NEW: EChartTreeWidget
/// This widget converts the computed TreeNode structure into an ECharts‑compatible JSON option.
/// It wraps the ECharts widget in an InteractiveViewer so you can zoom in and out via external buttons.
/// Each node displays both the decision (Include/Exclude/Start) and its bound.
/// NEW: EChartTreeWidget
/// This widget converts the computed TreeNode structure into an ECharts‑compatible JSON option.
/// It enables native panning on the chart by setting "roam" to "move".
class EChartTreeWidget extends StatelessWidget {
  final TreeNode tree;
  const EChartTreeWidget({Key? key, required this.tree}) : super(key: key);

  /// Recursively converts the TreeNode structure into a Map.
  /// Each node’s label now displays both its decision and its bound.
  Map<String, dynamic> _convertTree(TreeNode node) {
    return {
      "name": "${node.decision} (Bound: ${node.bound.toStringAsFixed(2)})",
      if (node.children.isNotEmpty)
        "children": node.children.map((child) => _convertTree(child)).toList()
    };
  }

  @override
  Widget build(BuildContext context) {
    // Convert our tree to JSON.
    String treeJson = jsonEncode(_convertTree(tree));
    // Build the ECharts option, enabling roam (pan) with "roam": "move".
    final String option = '''
    {
      tooltip: {
          show: false
      },
      series: [
          {
              type: 'tree',
              data: [$treeJson],
              top: '1%',
              left: '7%',
              bottom: '1%',
              right: '20%',
              symbolSize: 10,
              label: {
                  position: 'left',
                  verticalAlign: 'middle',
                  align: 'right',
                  fontSize: 12
              },
              leaves: {
                  label: {
                      position: 'right',
                      verticalAlign: 'middle',
                      align: 'left'
                  }
              },
              roam: "move",
              expandAndCollapse: true,
              animationDuration: 550,
              animationDurationUpdate: 750
          }
      ]
    }
    ''';
        
    final double containerWidth = MediaQuery.of(context).size.width * 0.9;
    final double containerHeight = MediaQuery.of(context).size.height * 0.5;

    return Container(
      width: containerWidth,
      height: containerHeight,
      child: Echarts(
        option: option,
      ),
    );
  }
}
