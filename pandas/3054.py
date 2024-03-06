# https://leetcode.com/problems/binary-tree-nodes/

import pandas as pd


def binary_tree_nodes(tree: pd.DataFrame) -> pd.DataFrame:
    def classify(row):
        if pd.isnull(row.P_x):
            return "Root"
        if pd.isnull(row.P_y):
            return "Leaf"
        return "Inner"

    tree = tree.merge(
        tree, how="left", left_on="N", right_on="P", suffixes=["_x", "_y"]
    )
    tree["Type"] = tree.apply(classify, axis=1)

    return (
        tree[["N_x", "Type"]]
        .rename(columns={"N_x": "N"})
        .drop_duplicates()
        .sort_values("N")
    )
