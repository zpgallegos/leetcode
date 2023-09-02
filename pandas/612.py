# https://leetcode.com/problems/shortest-distance-in-a-plane/?lang=pythondata

import pandas as pd

data = [[-1, -1], [0, 0], [-1, -1], [-1, -2]]
point2_d = pd.DataFrame(data, columns=['x', 'y']).astype({'x':'Int64', 'y':'Int64'})


def euclidean(x1, x2, y1, y2):
    return ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** (1/2)


def shortest_distance(point2_d: pd.DataFrame) -> pd.DataFrame:
    point2_d = point2_d.drop_duplicates().reset_index()
    point2_d = point2_d.merge(point2_d, how="cross", suffixes=["_l", "_r"])
    point2_d = point2_d[point2_d.index_l < point2_d.index_r]

    mn = point2_d.apply(lambda row: euclidean(row.x_l, row.x_r, row.y_l, row.y_r), axis=1).min()

    return pd.DataFrame({"shortest": [round(mn, 2)]})
