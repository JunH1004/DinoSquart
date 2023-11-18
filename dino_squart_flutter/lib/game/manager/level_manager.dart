import 'dart:math';

class LevelManager {
  List<List<int>> dfs(List<List<int>> blocks, int currentTime, int currentCal, int goalTime, int goalCal, List<List<int>> path, List<List<int>> resultBlocks, int startIndex) {
    // 현재 조합이 목표 시간과 목표 칼로리를 만족하는지 확인
    if (currentTime == goalTime && currentCal == goalCal) {
      resultBlocks.add(path.expand((e) => e).toList());  // 현재 경로를 결과 리스트에 추가
      return resultBlocks;
    }

    // DFS 탐색
    for (int i = startIndex; i < blocks.length; i++) {
      // 백트래킹: 현재 블록을 추가해도 목표를 넘지 않을 때만 진행
      if (currentTime + blocks[i].length <= goalTime && currentCal + blocks[i].reduce((a, b) => a + b) <= goalCal) {
        path.add(List.from(blocks[i]));
        dfs(blocks, currentTime + blocks[i].length, currentCal + blocks[i].reduce((a, b) => a + b), goalTime, goalCal, path, resultBlocks, i + 1);
        path.removeLast();  // 백트래킹: 다음 블록을 탐색하기 위해 현재 블록을 제거
      }
    }

    return resultBlocks;
  }

  List<List<int>> findCombination(List<List<int>> blocks, int goalTime, int goalCal) {
    List<List<int>> resultBlocks = [];
    dfs(blocks, 0, 0, goalTime, goalCal, [], resultBlocks, 0);
    return resultBlocks;
  }

  void getQueue() {
    // 목표 시간과 목표 칼로리
    int goalTime = 50;
    int goalCal = 50;

    // 블록들
    List<List<int>> blocks = [
      [0, 1, 0, 1],
      [1, 0, 0, 2],
      [0, 1, 0, 1],
      [1, 0, 0, 2],
      [0, 1, 0, 1],
      [1, 1, 1, 0],
      [1, 0, 0, 1],
      [1, 1, 0, 1],
      [1, 0, 1, 0, 1],
      [0, 1, 0, 1, 0],
      [0, 1, 1, 1, 0],
      [1, 0, 0, 0, 1],
      [1, 1, 0, 1, 1],
      [0, 0, 1, 1, 0],
      [1, 2, 3, 0],
      [3, 0, 0, 2],
      [1, 1, 0, 1],
      [1, 0, 1, 0, 1],
      [0, 3, 0, 3, 0],
      [0, 2, 1, 3, 0],
      [1, 0, 0, 0, 1],
      [2, 1, 0, 1, 1],
      [0, 0, 3, 4, 0],
    ];

    List<List<int>> resultBlocks = findCombination(blocks, goalTime, goalCal);

    if (resultBlocks.isNotEmpty) {
      print("여러 조합 중 하나를 선택하여 합친 결과:");
      List selectedCombination = resultBlocks[Random().nextInt(resultBlocks.length)].toList();
      print(selectedCombination);
    } else {
      print("해당하는 조합이 없습니다.");
    }
  }
}

void main() {
  LevelManager().getQueue();
}
