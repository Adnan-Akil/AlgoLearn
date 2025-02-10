import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class lcs extends StatefulWidget {
  @override
  _lcsState createState() => _lcsState();
}

class _lcsState extends State<lcs> {
  final PageController _pageController = PageController();
  final int numPages = 4;
  final List<String> questions = [
    "What is the definition of the Longest Common Subsequence (LCS) between two strings, and how does it differ from the Longest Common Prefix (LCP)?",
    "rite the recursive function to find the LCS of two given strings. What is the base case and the recursive case?",
    "Explain how the recursion tree looks for the LCS problem when given two strings. What is the significance of overlapping subproblems?",
    "Given the strings 'ABCBDAB' and 'BDCAB', manually trace the recursive calls to find the LCS",
    "What are the advantages and disadvantages of using recursion to solve the LCS problem, especially for large strings?",
    "How can the time complexity of the recursive solution for LCS be calculated? What makes it inefficient for larger inputs?",
    "Modify the recursive LCS function to return not only the length but also the actual LCS string",
    "Explain why the recursive approach to solving the LCS problem may result in redundant calculations and how this affects the performance",
    "Using recursion, how would you find the LCS of two strings where one string is the reverse of the other?",
    "For the strings 'AXYT' and 'AYZX', manually compute the recursive calls to find the LCS length",
    "Write the dynamic programming solution to find the LCS of two strings. How does it use a 2D table to store intermediate results?",
    "How does the time complexity of the dynamic programming solution for LCS compare to the recursive approach?",
    "Given two strings, explain how to build the DP table step-by-step to compute the LCS",
    "Consider the strings 'AGGTAB' and 'GXTXAYB'. Construct the DP table and find the length of the LCS",
    "How can dynamic programming be extended to not only find the length of the LCS but also reconstruct the LCS itself? Show the steps involved in this process",
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
        // Allows resizing when the keyboard appears.
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "Longest Common Subsequence",
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
    '''
1. INTRODUCTION  
The LCS problem asks for the longest sequence that is a subsequence of two given sequences (or strings). A subsequence is derived by deleting some or no elements without changing the order. For example, for X = "ABCBDAB" and Y = "BDCABA", one possible LCS is "BCBA". The goal can be to find either the length of the LCS or the actual sequence.

2. RECURSIVE APPROACH  
2.1 Basic Idea  
The recursive solution compares the last characters of two sequences. If they match, they contribute one to the LCS length; otherwise, the solution is the maximum LCS when excluding the last character of one string.

2.2 Recurrence Relation  
Let X[1...m] and Y[1...n] be two sequences. Then:

LCS(m, n) = 0, if m = 0 or n = 0  
LCS(m-1, n-1) + 1, if X[m] = Y[n]  
max(LCS(m-1, n), LCS(m, n-1)), if X[m] ≠ Y[n]

2.3 Discussion  
This approach naturally forms a recursion tree with overlapping subproblems (e.g., LCS(i, j) may be computed multiple times). Its time complexity is exponential (around O(2^(min(m, n)))) due to the binary recursion, making it inefficient for large inputs.

3. DYNAMIC PROGRAMMING APPROACH  
3.1 Basic Idea  
Dynamic programming (DP) saves results of subproblems in a 2D table so that each subproblem is solved only once. A table dp of size (m+1)×(n+1) is built where dp[i][j] stores the LCS length for X[1...i] and Y[1...j].

3.2 Table Initialization  
Set dp[0][j] = 0 for all j and dp[i][0] = 0 for all i since an empty sequence has an LCS length of 0.

3.3 Filling the Table  
For each i from 1 to m and j from 1 to n:

If X[i] equals Y[j]: dp[i][j] = dp[i-1][j-1] + 1  
Otherwise: dp[i][j] = max(dp[i-1][j], dp[i][j-1])

3.4 Reconstructing the LCS  
Once the table is filled, dp[m][n] holds the LCS length. To reconstruct the sequence, trace back from dp[m][n]: if X[i] equals Y[j], add that character to the LCS and move diagonally; if not, move toward the larger value between dp[i-1][j] and dp[i][j-1].

3.5 Time and Space Complexity  
The DP solution runs in O(m×n) time and uses O(m×n) space. Space can be optimized to O(min(m, n)) if only the previous row or column is needed.

4. EXAMPLE  
Consider the given two strings,  
X = "ABCBDAB"  
Y = "BDCABA"  
After using the above approach:

    B   D   C   A   B   A  
A   0   0   0   1   1   1  
B   1   1   1   1   2   2  
C   1   1   2   2   2   2  
B   1   1   2   2   3   3  
D   1   2   2   2   3   3  
A   1   2   2   3   3   4  
B   1   2   2   3   4   4  

LCS length = 4  
One possible LCS: "BCBA"  
Recursive approach is simple but inefficient for large inputs.  
DP approach is much faster (O(m×n)) and can be further optimized.
''',
    '''
ALGORITHM: Dynamic Programming Approach  
def LCS_DP(X, Y):  
    m, n = len(X), len(Y)  
    dp = [[0] * (n + 1) for _ in range(m + 1)]  # Initialize table

    for i in range(1, m + 1):  
        for j in range(1, n + 1):  
            if X[i-1] == Y[j-1]:  
                dp[i][j] = dp[i-1][j-1] + 1  # Characters match  
            else:  
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])  # Take max

    return dp[m][n]  # LCS length is in the last cell

QUICK EXPLANATION:  
A 2D table dp[i][j] is created where dp[i][j] stores the LCS length for the first i characters of X and first j characters of Y.  
If X[i-1] == Y[j-1], add 1 to dp[i-1][j-1] (diagonal value).  
Otherwise, take max(dp[i-1][j], dp[i][j-1]) (max of removing one character from either string).

ALGORITHM: Recursive Approach  
def LCS_recursive(X, Y, m, n):  
    if m == 0 or n == 0:  
        return 0  
    if X[m-1] == Y[n-1]:  
        return 1 + LCS_recursive(X, Y, m-1, n-1)  
    else:  
        return max(LCS_recursive(X, Y, m-1, n), LCS_recursive(X, Y, m, n-1))

QUICK EXPLANATION:  
If either string is empty, return 0.  
If the last characters match, add 1 to the LCS of the remaining strings.  
If they don’t match, compute the LCS by excluding either character and take the maximum.
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
                ? LCSVisualizer()
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
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.07,
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

class LCSVisualizer extends StatefulWidget {
  @override
  _LCSVisualizerState createState() => _LCSVisualizerState();
}

class _LCSVisualizerState extends State<LCSVisualizer> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  List<List<int>> dp = [];
  List<List<bool>> highlight = [];
  String resultLCS = "";
  bool isCalculating = false;
  bool isBacktracking = false;
  int m = 0, n = 0;
  // The input strings stored for header display.
  String _s1 = "";
  String _s2 = "";
  // Variables to store the current cell being processed.
  int? currentProcessingRow;
  int? currentProcessingCol;

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<void> _startVisualization() async {
    _s1 = _controller1.text;
    _s2 = _controller2.text;
    if (_s1.isEmpty || _s2.isEmpty) return;
    setState(() {
      isCalculating = true;
      m = _s1.length;
      n = _s2.length;
      // Build a DP table of size (m+1) x (n+1).
      dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
      highlight = List.generate(m + 1, (_) => List.filled(n + 1, false));
      resultLCS = "";
    });

    // Animate the DP table computation for indices 1..m and 1..n.
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        setState(() {
          currentProcessingRow = i;
          currentProcessingCol = j;
        });
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          if (_s1[i - 1] == _s2[j - 1]) {
            dp[i][j] = dp[i - 1][j - 1] + 1;
          } else {
            dp[i][j] =
                dp[i - 1][j] >= dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1];
          }
          // Clear processing highlight once computed.
          currentProcessingRow = null;
          currentProcessingCol = null;
        });
      }
    }

    setState(() {
      isCalculating = false;
      isBacktracking = true;
    });

    // Backtracking: Highlight only the cells where characters match.
    int i = m, j = n;
    String lcsStr = "";
    while (i > 0 && j > 0) {
      await Future.delayed(Duration(milliseconds: 300));
      if (_s1[i - 1] == _s2[j - 1]) {
        setState(() {
          highlight[i][j] = true;
        });
        lcsStr = _s1[i - 1] + lcsStr;
        i--;
        j--;
      } else if (dp[i - 1][j] > dp[i][j - 1]) {
        i--;
      } else {
        j--;
      }
    }

    setState(() {
      resultLCS = lcsStr;
      isBacktracking = false;
    });
  }

  void _reset() {
    _controller1.clear();
    _controller2.clear();
    setState(() {
      dp = [];
      highlight = [];
      resultLCS = "";
      isCalculating = false;
      isBacktracking = false;
      m = 0;
      n = 0;
      _s1 = "";
      _s2 = "";
    });
  }

  // Build the table with a header row and header column, and only DP cells for indices 1..m and 1..n.
  Widget _buildDPTable() {
    if (dp.isEmpty) return Container();
    // Total rows: header row + m data rows.
    int rowCount = m + 1;
    // Total columns: header column + n data columns.
    int colCount = n + 1;
    return LayoutBuilder(
      builder: (context, constraints) {
        double cellWidth = constraints.maxWidth / colCount;
        double cellHeight = cellWidth; // Square cells.
        List<TableRow> tableRows = [];

        // Build header row.
        List<Widget> headerCells = [];
        // Top-left header cell.
        headerCells.add(Container(
          width: cellWidth,
          height: cellHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
            color: Colors.grey[300],
          ),
          child: Text(""),
        ));
        // Header cells for _s2.
        for (int j = 1; j < colCount; j++) {
          Color headerColor = Colors.grey[300]!;
          if (currentProcessingCol == j) {
            headerColor = Colors.lightBlueAccent.withOpacity(0.5);
          }
          headerCells.add(Container(
            width: cellWidth,
            height: cellHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.onPrimary),
              color: headerColor,
            ),
            child: Text(
              _s2[j - 1],
              style: TextStyle(
                  fontSize: cellWidth * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ));
        }
        tableRows.add(TableRow(children: headerCells));

        // Build each subsequent row.
        for (int i = 1; i < rowCount; i++) {
          List<Widget> rowCells = [];
          // Header cell for _s1.
          Color rowHeaderColor = Colors.grey[300]!;
          if (currentProcessingRow == i) {
            rowHeaderColor = Colors.lightBlueAccent.withOpacity(0.5);
          }
          rowCells.add(Container(
            width: cellWidth,
            height: cellHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
              color: rowHeaderColor,
            ),
            child: Text(
              _s1[i - 1],
              style: TextStyle(
                  fontSize: cellWidth * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ));
          // DP cells.
          for (int j = 1; j < colCount; j++) {
            // Determine background color.
            Color bgColor = Colors.transparent;
            if (currentProcessingRow == i && currentProcessingCol == j) {
              bgColor = Colors.lightBlueAccent.withOpacity(0.5);
            } else if (highlight[i][j]) {
              bgColor = Colors.yellow.withOpacity(0.5);
            }
            rowCells.add(Container(
              width: cellWidth,
              height: cellHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.onPrimary),
                color: bgColor,
              ),
              child: Text(
                dp[i][j].toString(),
                style: TextStyle(
                    fontSize: cellWidth * 0.4,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ));
          }
          tableRows.add(TableRow(children: rowCells));
        }

        return Table(
          defaultColumnWidth: FixedColumnWidth(cellWidth),
          border:
              TableBorder.all(color: Theme.of(context).colorScheme.onPrimary),
          children: tableRows,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wrap in SingleChildScrollView to prevent bottom overflow.
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter First String:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                hintText: "First string",
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(height: 10),
            Text(
              "Enter Second String:",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                hintText: "Second string",
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  // Show "Run" if the DP table has not been built; otherwise, show "Reset".
                  child: dp.isEmpty
                      ? ElevatedButton(
                          onPressed: isCalculating || isBacktracking
                              ? null
                              : _startVisualization,
                          child: Text("Run"),
                        )
                      : ElevatedButton(
                          onPressed: _reset, child: Text("Reset")),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (dp.isNotEmpty)
              FadeIn(
                child: _buildDPTable(),
              ),
            SizedBox(height: 20),
            if (resultLCS.isNotEmpty)
              ZoomIn(
                child: Text(
                  "LCS: $resultLCS  |  Length: ${resultLCS.length}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
