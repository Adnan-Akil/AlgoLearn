import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';

class eightQueens extends StatefulWidget {
  @override
  _eightQueensState createState() => _eightQueensState();
}

class _eightQueensState extends State<eightQueens> {
  String currentQuestion = "";
  final int numPages = 4;
  final List<String> questions = [ //all the randomized Questions 
    "What is the N-Queens Problem? Explain its significance in algorithm design and backtracking",
    "Why is the N-Queens Problem classified as a combinatorial problem?",
    "What are the constraints that must be satisfied when placing queens on an N × N chessboard?",
    "What is the time complexity of solving the N-Queens problem using a backtracking approach? Explain your reasoning",
    "Explain why a brute-force approach is inefficient for solving the N-Queens Problem",
    "What is the difference between backtracking and brute-force in the context of solving N-Queens?",
    "Can the N-Queens problem be solved using dynamic programming? Why or why not?",
    "How does the pruning technique help in optimizing the backtracking solution for the N-Queens Problem?",
    "What is the significance of the first valid solution in the N-Queens problem versus finding all possible solutions?",
    "Can the N-Queens problem be solved using an iterative approach instead of recursion? If yes, how?",
    "For N=4, solve the N-Queens problem and find all possible solutions",
    "Write a recursive backtracking algorithm to solve the N-Queens Problem",
    "Modify the backtracking approach to print all possible solutions for a given N",
    "Implement a function that checks whether placing a queen at a given position (row, col) is valid",
  ];

  final PageController _pageController = PageController();

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
            "Eight-Queens",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color:  Theme.of(context).colorScheme.onPrimary,
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
                      Text("Home", style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600)),
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
                      Text("Settings", style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w600)),
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
  const PageContent({Key? key, required this.pageIndex, required this.question, required this.refreshQuestion}) : super(key: key);

  static const List<String> pageContents = [ //this include the entire content of the topic!
'''
1. INTRODUCTION
The N-Queens Problem is a classic combinatorial problem where we must place N queens on an N × N chessboard so that no two queens attack each other. In chess, a queen can attack any piece in the same row, column, or diagonal.  

This problem is significant in algorithm design as it demonstrates backtracking, constraint satisfaction, and optimization techniques. It also has applications in AI, scheduling, and search algorithms.  

2. CONSTRAINTS AND PROPERTIES  
Each queen must follow three constraints:  
Row Constraint: Only one queen per row.  
Column Constraint: Only one queen per column.  
Diagonal Constraint: Queens cannot share the same diagonal.  
Brute force is infeasible due to exponential complexity, requiring smarter techniques like backtracking.  

3. ALGORITHMIC APPROACHES  
3.1 Backtracking (Most Common Approach)  
A recursive depth-first search (DFS) method that places queens row by row and backtracks when an invalid configuration is found.  

Steps:
  Place a queen in the first available column of the current row.  
  Check if it conflicts with previously placed queens.  
  If valid, move to the next row; if not, try the next column.  
  If all rows are filled, a solution is found. Otherwise, backtrack.  

3.2 Constraint Programming  
Defines N variables (each row), with constraints ensuring no conflicts.  
Used in AI and optimization tools like Prolog or Python’s `constraint` library.  

3.3 Bitwise Optimization
For large N, bitwise operations efficiently track column and diagonal conflicts using integer bitmasks instead of arrays. This significantly reduces computation time.

Performance Boost: Works faster for N > 12.  

4. COUNTING AND OPTIMIZATIONS  
Finding All Solutions vs. One Solution  
  Stopping at the first valid configuration vs. searching for all possible valid placements.  
  The 8-Queens problem has 92 solutions, but only 12 unique solutions considering symmetry.  

Pruning and Heuristics  
  Early pruning helps cut off invalid branches quickly.  
  Sorting candidate positions based on constraints can improve efficiency.
''',

'''
ALGORITHM:
function solveNQueens(N):
  board = createBoard(N)  // Create an N x N board
  result = []
    
  function placeQueens(row):
    if row == N:  // All queens are placed
      result.append(board)  // Store the valid solution
      return
        
    for col in 0 to N-1:  // Try all columns in the current row
        if isSafe(row, col, board):
            board[row][col] = 1  // Place the queen
            placeQueens(row + 1)  // Recur for the next row
            board[row][col] = 0  // Backtrack: Remove the queen
    
  function isSafe(row, col, board):
      // Check column conflict
      for i in 0 to row-1:
          if board[i][col] == 1:
              return false
        
      // Check diagonal conflicts (top-left and top-right)
      for i, j in [(row-1, col-1), (row-1, col+1)]:
          while i >= 0 and j >= 0 and j < N:
              if board[i][j] == 1:
                  return false
              i -= 1
              j += (j < col ? -1 : 1)  // Adjust direction for top-left and top-right
        
      return true  // No conflicts
    
  placeQueens(0)  // Start from the first row
  return result


QUICK EXPLANATION:  
solveNQueens(N): The main function to initiate the solution process. It creates an N × N board and calls the placeQueens function to try placing queens row by row.

placeQueens(row): This function is recursively called to try placing a queen in each row. If all queens are placed successfully (i.e., row == N), the board is added to the result. For each column in the current row, it checks if placing a queen is safe.

isSafe(row, col, board): This helper function checks if placing a queen at position (row, col) will result in a conflict. It checks:

Column conflict: If any queen is already placed in the same column.
Diagonal conflicts: If any queen is placed on the same diagonal (both top-left and top-right).
Backtracking: When a queen is placed, the algorithm recurses to place queens in the next row. If no valid column is found in the current row, the algorithm backtracks by removing the queen and trying the next column in the previous row.

Result: The solution is stored in result whenever a valid configuration is found.
''',
'''
''',
''' 


'''
  ];

  static const List<String> pageTitles = ["Overview", "Algorithm", "Visualization", "Quiz"];

  final int pageIndex;
  final String question;
  final VoidCallback refreshQuestion;

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
                // If this is the Quiz page, show the quiz widget:
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
                // --- Here we insert our new eight queens visualizer on the Visualization page ---
                if (pageIndex == 2)
                  EightQueensVisualizer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EightQueensVisualizer extends StatefulWidget {
  @override
  _EightQueensVisualizerState createState() => _EightQueensVisualizerState();
}

class _EightQueensVisualizerState extends State<EightQueensVisualizer> {
  int queensCount = 4; // from 4 to 8
  int solutionsLimit = 5; // default limit
  bool isRunning = false;
  bool solved = false;
  bool flashSolution = false;
  List<List<int>> solutions = [];
  late List<int> currentBoard; // currentBoard[row] = column index (or -1 if none)

  @override
  void initState() {
    super.initState();
    resetVisualizer();
  }

  void resetVisualizer() {
    setState(() {
      isRunning = false;
      solved = false;
      flashSolution = false;
      solutions = [];
      currentBoard = List.filled(queensCount, -1);
    });
  }

  /// Check if a queen can be placed at (row, col) safely
  bool isSafe(int row, int col) {
    for (int i = 0; i < row; i++) {
      int qCol = currentBoard[i];
      if (qCol == col || (qCol - col).abs() == (row - i)) {
        return false;
      }
    }
    return true;
  }

  /// Backtracking solver with animation.
  Future<bool> solve(int row) async {
    if (row == queensCount) {
      // Found a complete solution – flash the queens green.
      setState(() {
        flashSolution = true;
      });
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        flashSolution = false;
      });
      solutions.add(List.from(currentBoard));
      // If reached the desired number of solutions, terminate.
      if (solutions.length >= solutionsLimit) return true;
      return false;
    }
    for (int col = 0; col < queensCount; col++) {
      if (isSafe(row, col)) {
        currentBoard[row] = col;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 300));
        bool done = await solve(row + 1);
        if (done) return true;
        // Backtrack:
        currentBoard[row] = -1;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 300));
      }
    }
    return false;
  }

  void runSolver() async {
    setState(() {
      isRunning = true;
      solved = false;
      solutions = [];
      // Reset the board with the current queensCount.
      currentBoard = List.filled(queensCount, -1);
    });
    await solve(0);
    setState(() {
      isRunning = false;
      solved = true;
    });
  }

  Widget buildChessBoard(List<int> board) {
    // The board will be a square that spans the width of the screen.
    double boardSize = MediaQuery.of(context).size.width * 0.95;
    return Container(
      width: boardSize,
      height: boardSize,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: queensCount,
        ),
        itemCount: queensCount * queensCount,
        itemBuilder: (context, index) {
          int row = index ~/ queensCount;
          int col = index % queensCount;
          bool hasQueen = board[row] == col;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onPrimary, width: 0.5),
              color: ((row + col) % 2 == 0)
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            child: Center(
              child: hasQueen
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 450),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: flashSolution
                            ? Colors.green
                            : Theme.of(context).colorScheme.secondary,
                      ),
                      child: Icon(Icons.castle_rounded, size: boardSize / queensCount * 0.6, color: Colors.white),
                    )
                  : SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  /// Build a mini representation of a found solution.
  Widget buildMiniChessBoard(List<int> board) {
    double size = 120;
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary, width: 1),
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: queensCount,
        ),
        itemCount: queensCount * queensCount,
        itemBuilder: (context, index) {
          int row = index ~/ queensCount;
          int col = index % queensCount;
          bool hasQueen = board[row] == col;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), width: 0.5),
              color: ((row + col) % 2 == 0)
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            child: Center(
              child: hasQueen
                  ? Icon(Icons.castle_rounded, size: size / queensCount * 1, color: Colors.green)
                  : SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Controls for queen count
        Text(
          "Choose the number of QUEENS (${queensCount})",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Slider(
          min: 4,
          max: 8,
          divisions: 4,
          label: queensCount.toString(),
          value: queensCount.toDouble(),
          onChanged: isRunning || solved
              ? null
              : (val) {
                  setState(() {
                    queensCount = val.toInt();
                    // When changing board size, reset the current board.
                    currentBoard = List.filled(queensCount, -1);
                  });
                },
        ),
        // Control for number of solutions to display
        Text(
          "Number of solutions to display (${solutionsLimit})",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Slider(
          min: 1,
          max: 10,
          divisions: 9,
          label: solutionsLimit.toString(),
          value: solutionsLimit.toDouble(),
          onChanged: isRunning || solved
              ? null
              : (val) {
                  setState(() {
                    solutionsLimit = val.toInt();
                  });
                },
        ),
        SizedBox(height: 10),
        // Run button
        if (!isRunning && !solved)
          Center(
            child: ElevatedButton(
              onPressed: runSolver,
              child: Text("Run"),
            ),
          ),
        if (isRunning)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Solving... Please wait", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ),
        SizedBox(height: 10),
        // Display the dynamic chessboard during/after solving
        if (isRunning || solved)
          Center(child: buildChessBoard(currentBoard)),
        SizedBox(height: 10),
        // Display found solutions below the board
        if (solutions.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Solutions found:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: solutions.map((sol) => buildMiniChessBoard(sol)).toList(),
                ),
              ),
            ],
          ),
        // Reset button appears after execution
        if (solved)
          Center(
            child: ElevatedButton(
              onPressed: () {
                resetVisualizer();
              },
              child: Text("Reset"),
            ),
          ),
      ],
    );
  }
}
