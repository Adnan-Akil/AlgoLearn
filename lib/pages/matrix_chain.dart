import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animate_do/animate_do.dart';

class matrixchain extends StatefulWidget {
  @override
  _matrixchainState createState() => _matrixchainState();
}

class _matrixchainState extends State<matrixchain> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
    "What is the Matrix Chain Multiplication Problem, and why is it significant in computational optimization?",
    "Explain why matrix multiplication is associative but not commutative",
    "What is the time complexity of a naive matrix multiplication approach? How does it compare to dynamic programming solutions?",
    "Define the Parenthesization Problem in the context of matrix chain multiplication. Why is brute force not feasible for large inputs?",
    "What is dynamic programming, and how does it help solve the Matrix Chain Multiplication problem efficiently?",
    "Explain the role of the cost function used in the dynamic programming approach to matrix chain multiplication",
    "Describe the recursive formula used in Matrix Chain Multiplication",
    "How does memoization improve the efficiency of solving Matrix Chain Multiplication?",
    "What is the significance of the table (DP table) used in the bottom-up approach for solving Matrix Chain Multiplication?",
    "Compare the divide and conquer approach with the dynamic programming approach for Matrix Chain Multiplication",
    "Given matrices A(10×30), B(30×5), C(5×60), find the optimal way to parenthesize them to minimize scalar multiplications",
    "Compute the number of ways to fully parenthesize a chain of 4 matrices (without calculating the cost)",
    "Given matrices A(5×10), B(10×3), C(3×12), D(12×5), determine the minimum number of scalar multiplications needed using dynamic programming",
    "Implement the Matrix Chain Multiplication algorithm using recursion + memoization (write the steps, no code needed)",
    "Construct and fill a DP table for matrices A(4×10), B(10×3), C(3×12), D(12×20), E(20×7) to determine the minimum scalar multiplications required and the optimal parenthesization",
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
            "Matrix Chain Multiplication",
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

  // Separate content for each page.
  static const List<String> pageTitles = ["Overview", "Algorithm", "Visualization", "Quiz"];
  static const List<String> pageContents = [
    '''       
1. INTRODUCTION
Matrix Chain Multiplication (MCM) is an optimization problem where we determine the most efficient way to multiply a sequence of matrices by minimizing the number of scalar multiplications.

2. DOES ORDER MATTER?
Matrix multiplication is associative but not commutative. The way we parenthesize affects computational cost.
Example:
    For matrices A (10×30), B (30×5), C (5×60):
    (A × B) × C → Cost = 4500 operations
    A × (B × C) → Cost = 27000 operations
    
Different parenthesizations can lead to huge differences in computation time.

3. HOW ABOUT BRUTE FORCE?
The number of ways to fully parenthesize n matrices follows the Catalan number sequence, which grows exponentially.
For n = 10, there are 16796 possible parenthesizations.
Dynamic Programming (DP) provides an optimal solution in O(n³) time.

4. DYNAMIC PROGRAMMING
Let m[i][j] represent the minimum cost of multiplying matrices Aᵢ to Aⱼ.
    m[i][j] = min ( m[i][k] + m[k+1][j] + p[i-1]*p[k]*p[j] ) for i ≤ k < j.
Base case: m[i][i] = 0.

5. TABLE FILLING STRATEGY
Compute for chains of increasing lengths and fill the DP table diagonally.

6. TIME COMPLEXITY
The DP approach solves the problem in O(n³) time.
''',
    ''' 
ALGORITHM:
MatrixChainOrder(p, n):
1. Create a table m[n][n] and initialize m[i][i] = 0.
2. For chain_length from 2 to n:
      For i = 1 to n - chain_length + 1:
          j = i + chain_length - 1;
          m[i][j] = ∞;
          For k = i to j - 1:
              cost = m[i][k] + m[k+1][j] + p[i-1]*p[k]*p[j];
              if (cost < m[i][j]) then m[i][j] = cost;
3. Return m[1][n-1] as the optimal cost.

QUICK EXPLANATION:
Create a table m[n][n] where m[i][j] stores the minimum cost of multiplying matrices from index i to j.
Set m[i][i] = 0 because a single matrix requires no multiplication.

Iterate chain_length from 2 to n, meaning we're considering subproblems of increasing sizes.

For each possible matrix chain starting at i and ending at j, initialize m[i][j] to infinity.
Try every possible partition k (splitting point) between i and j to find the minimum cost:
    m[i][k] + m[k+1][j] + p[i−1]×p[k]×p[j]
Update m[i][j] if a smaller cost is found.
The result is stored in m[1][n-1], which gives the minimum number of multiplications needed to multiply the entire chain.
''',
    "This section will contain an interactive visualization where the user can input dimensions and see the optimal order of multiplication.",
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
                if (pageIndex == 2)
                  VisualizationWidget()
                else
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
/// INTERACTIVE VISUALIZATION WIDGET FOR MATRIX CHAIN MULTIPLICATION
///
class VisualizationWidget extends StatefulWidget {
  @override
  _VisualizationWidgetState createState() => _VisualizationWidgetState();
}

class _VisualizationWidgetState extends State<VisualizationWidget> {
  final TextEditingController _controller = TextEditingController();
  // These variables store the computed details.
  List<int> _dims = [];
  int _cost = 0;
  String _parenthesization = "";
  List<String> _matrixList = [];
  List<String> _steps = [];
  List<List<int>> _dpTable = [];
  bool _executed = false; // Whether the "Run" button has been pressed

  // Animation-related state for the DP table.
  List<AnimationStep> _animationSequence = [];
  int _currentAnimationIndex = 0;
  Timer? _animationTimer;

  // This method parses the input, computes the solution, and collects the actual calculation steps.
  void _runMatrixChain() {
    // Cancel any previous animation.
    _animationTimer?.cancel();
    List<String> parts = _controller.text.split(',');
    try {
      _dims = parts.map((s) => int.parse(s.trim())).toList();
      if (_dims.length < 2) {
        setState(() {
          _executed = false;
        });
        _showMessage("Please enter at least two dimensions.");
        return;
      }
    } catch (e) {
      setState(() {
        _executed = false;
      });
      _showMessage("Invalid input. Please enter comma separated integers.");
      return;
    }
    
    // Build list of matrices display.
    _matrixList = [];
    for (int i = 0; i < _dims.length - 1; i++) {
      _matrixList.add("A${i + 1} = ${_dims[i]} x ${_dims[i + 1]}");
    }
    
    // Compute DP solution and capture steps, dp table, and animation sequence.
    MatrixChainResultWithSteps result = _matrixChainOrder(_dims);
    _cost = result.cost;
    _parenthesization = result.parenthesization;
    _steps = result.steps;
    _dpTable = result.dpTable;
    _animationSequence = result.animationSequence;
    _currentAnimationIndex = 0;
    
    setState(() {
      _executed = true;
    });
    
    // Start animation: cycle through the animation sequence slowly (1 sec per update).
    if (_animationSequence.isNotEmpty) {
      _animationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _currentAnimationIndex++;
          if (_currentAnimationIndex >= _animationSequence.length) {
            _animationTimer?.cancel();
          }
        });
      });
    }
  }
  
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  
  void _reset() {
    _animationTimer?.cancel();
    setState(() {
      _controller.clear();
      _dims = [];
      _cost = 0;
      _parenthesization = "";
      _matrixList = [];
      _steps = [];
      _dpTable = [];
      _animationSequence = [];
      _currentAnimationIndex = 0;
      _executed = false;
    });
  }
  
  // Helper function to build a DP table widget using AnimatedDPCell.
  Widget _buildDPTable() {
    List<TableRow> rows = [];
    // Header row: indices.
    List<Widget> headerCells = [Container()];
    for (int j = 0; j < _dpTable.length; j++) {
      headerCells.add(Padding(
        padding: EdgeInsets.all(6.0),
        child: Text("${j+1}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary, fontSize: 20)),
      ));
    }
    rows.add(TableRow(children: headerCells));
    
    // Determine active cell from animation sequence.
    int activeRow = -1, activeCol = -1;
    if (_animationSequence.isNotEmpty && _currentAnimationIndex < _animationSequence.length) {
      activeRow = _animationSequence[_currentAnimationIndex].row;
      activeCol = _animationSequence[_currentAnimationIndex].col;
    }
    
    for (int i = 0; i < _dpTable.length; i++) {
      List<Widget> cells = [];
      cells.add(Padding(
        padding: EdgeInsets.all(6.0),
        child: Text("${i+1}", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary, fontSize: 20)),
      ));
      for (int j = 0; j < _dpTable.length; j++) {
        String cellText;
        if (j < i) {
          cellText = "-";
        } else {
          cellText = _dpTable[i][j] == (1 << 30) ? "∞" : _dpTable[i][j].toString();
        }
        bool isActive = (i == activeRow && j == activeCol);
        cells.add(AnimatedDPCell(value: cellText, isActive: isActive));
      }
      rows.add(TableRow(children: cells));
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: rows,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Section
          Text(
            "Enter matrix dimensions (comma separated):\nFor example, for matrices A1 (25×5), A2 (5×30), enter: 25,5,30",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "e.g., 25,5,30",
              fillColor: Colors.white.withOpacity(0.7),
              filled: true,
            ),
          ),
          SizedBox(height: 20),
          // Run Button (centered)
          Center(
            child: ElevatedButton(
              onPressed: _runMatrixChain,
              child: Text("Run"),
            ),
          ),
          SizedBox(height: 20),
          if (_executed) ...[
            // Top Section: Animated DP Table in a horizontal scroll view.
            Text(
              "Animated DP Table:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 10),
            _buildDPTable(),
            SizedBox(height: 20),
            // Remaining Details:
            Text(
              "Matrices:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 10),
            for (String matrix in _matrixList)
              Text(
                matrix,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Step-by-Step Execution:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 10),
            for (String step in _steps)
              Text(
                step,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Result:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Minimum Multiplications: $_cost",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Optimal Parenthesization: $_parenthesization",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _reset,
                child: Text("Reset"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}


class AnimatedDPCell extends StatefulWidget {
  final String value;
  final bool isActive;
  const AnimatedDPCell({Key? key, required this.value, this.isActive = false}) : super(key: key);

  @override
  _AnimatedDPCellState createState() => _AnimatedDPCellState();
}

class _AnimatedDPCellState extends State<AnimatedDPCell> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 850),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.isActive ? Colors.yellow : Colors.transparent,
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      ),
      child: Text(
        widget.value,
        textAlign: TextAlign.center,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 20.0,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class AnimatedDPTable extends StatelessWidget {
  final List<List<int>> dpTable;
  final int activeRow;
  final int activeCol;

  const AnimatedDPTable({
    Key? key,
    required this.dpTable,
    this.activeRow = -1,
    this.activeCol = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    List<Widget> headerCells = [Container()];
    for (int j = 0; j < dpTable.length; j++) {
      headerCells.add(Padding(
        padding: EdgeInsets.all(4.0),
        child: Text("j=${j+1}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).colorScheme.onPrimary)),
      ));
    }
    rows.add(TableRow(children: headerCells));

    for (int i = 0; i < dpTable.length; i++) {
      List<Widget> cells = [];
      cells.add(Padding(
        padding: EdgeInsets.all(4.0),
        child: Text("i=${i+1}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Theme.of(context).colorScheme.onPrimary)),
      ));
      for (int j = 0; j < dpTable.length; j++) {
        String cellText;
        if (j < i) {
          cellText = "-";
        } else {
          cellText = dpTable[i][j] == (1 << 30) ? "∞" : dpTable[i][j].toString();
        }
        bool isActive = (i == activeRow && j == activeCol);
        cells.add(AnimatedDPCell(value: cellText, isActive: isActive));
      }
      rows.add(TableRow(children: cells));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: rows,
      ),
    );
  }
}

class MatrixChainResult {
  final int cost;
  final String parenthesization;
  MatrixChainResult({required this.cost, required this.parenthesization});
}

class MatrixChainResultWithSteps extends MatrixChainResult {
  final List<String> steps;
  final List<List<int>> dpTable;
  final List<AnimationStep> animationSequence;
  MatrixChainResultWithSteps({
    required int cost,
    required String parenthesization,
    required this.steps,
    required this.dpTable,
    required this.animationSequence,
  }) : super(cost: cost, parenthesization: parenthesization);
}

class AnimationStep {
  final int row;
  final int col;
  final String stepText;
  AnimationStep({required this.row, required this.col, required this.stepText});
}

MatrixChainResultWithSteps _matrixChainOrder(List<int> dims) {
  int n = dims.length - 1; // Number of matrices.
  List<List<int>> m = List.generate(n, (_) => List.filled(n, 0));
  List<List<int>> s = List.generate(n, (_) => List.filled(n, 0));
  List<String> steps = [];
  List<AnimationStep> animationSequence = [];

  for (int i = 0; i < n; i++) {
    m[i][i] = 0;
    String baseStep = "m[${i + 1}][${i + 1}] = 0";
    steps.add(baseStep);
    animationSequence.add(AnimationStep(row: i, col: i, stepText: baseStep));
  }

  for (int l = 2; l <= n; l++) {
    for (int i = 0; i < n - l + 1; i++) {
      int j = i + l - 1;
      m[i][j] = 1 << 30;
      steps.add("\nComputing m[${i + 1}][${j + 1}] for chain length $l:");
      String lastUpdate = "";
      for (int k = i; k < j; k++) {
        int costLeft = m[i][k];
        int costRight = m[k + 1][j];
        int costMultiply = dims[i] * dims[k + 1] * dims[j + 1];
        int q = costLeft + costRight + costMultiply;
        steps.add("For k = ${k + 1}: cost = m[${i + 1}][${k + 1}] ($costLeft) + m[${k + 2}][${j + 1}] ($costRight) + ${dims[i]}*${dims[k + 1]}*${dims[j + 1]} ($costMultiply) = $q");
        if (q < m[i][j]) {
          m[i][j] = q;
          s[i][j] = k;
          lastUpdate = "--> Update m[${i + 1}][${j + 1}] = $q";
          steps.add(lastUpdate);
          animationSequence.add(AnimationStep(row: i, col: j, stepText: lastUpdate));
        }
      }
      String finalMsg = "\nFinal m[${i + 1}][${j + 1}] = ${m[i][j]}";
      steps.add(finalMsg);
      animationSequence.add(AnimationStep(row: i, col: j, stepText: finalMsg));
    }
  }
  String parenthesization = _constructOptimalParens(s, 0, n - 1);
  return MatrixChainResultWithSteps(
    cost: m[0][n - 1],
    parenthesization: parenthesization,
    steps: steps,
    dpTable: m,
    animationSequence: animationSequence,
  );
}

String _constructOptimalParens(List<List<int>> s, int i, int j) {
  if (i == j) return "A${i + 1}";
  return "( " +
      _constructOptimalParens(s, i, s[i][j]) +
      " x " +
      _constructOptimalParens(s, s[i][j] + 1, j) +
      " )";
}
