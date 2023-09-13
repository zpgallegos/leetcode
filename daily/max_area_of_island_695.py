import collections

grid = [
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0],
    [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
]

dirs = [[0, -1], [0, 1], [-1, 0], [1, 0]]


def solution(grid):
    if not grid:
        return 0

    max_count = 0
    visited = set()

    n_rows = len(grid)
    n_cols = len(grid[0])

    def bfs(cell):
        count = 1
        q = collections.deque()
        q.append(cell)
        # visited.add(cell)

        while q:
            cell = q.popleft()
            r, c = cell

            for dr, dc in dirs:
                mr = r + dr
                mc = c + dc
                if mr < 0 or mr >= n_rows or mc < 0 or mc >= n_cols:
                    continue
                mcell = (mr, mc)
                if mcell in visited:
                    continue
                elif grid[mr][mc] == 1:
                    count += 1
                    q.append(mcell)
                visited.add(mcell)

        return count

    for r in range(n_rows):
        for c in range(n_cols):
            cell = (r, c)
            if cell in visited:
                continue

            visited.add(cell)
            
            if grid[r][c] == 1:
                max_count = max(max_count, bfs(cell))

    return max_count
