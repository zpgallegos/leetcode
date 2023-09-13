from collections import deque

grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
rows = len(grid)
cols = len(grid[0])
dirs = [[0, -1], [0, 1], [-1, 0], [1, 0]]


def bfs(r, c):
    visited = set()
    cell = (r, c)
    q = deque([cell])
    visited.add(cell)

    while q:
        cell = q.popleft()
        r, c = cell

        for mr, mc in dirs:
            new_r = r + mr
            new_c = c + mc
            if new_r < 0 or new_r >= rows or new_c < 0 or new_c >= cols:
                continue
            new_cell = (new_r, new_c)
            if grid[new_r][new_c] == "1" and new_cell not in visited:
                q.append(new_cell)
                visited.add(new_cell)

    return visited


def solution(grid):
    if not grid:
        return 0

    res = 0
    visited = set()

    rows = len(grid)
    cols = len(grid[0])

    for r in range(rows):
        for c in range(cols):
            cell = (r, c)
            if cell in visited:
                continue

            if grid[r][c] == "1":
                res += 1
                searched = bfs(r, c)
                visited.update(searched)

            visited.update(cell)

    return res


bfs(0, 0)
