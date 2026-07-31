# https://leetcode.com/problems/find-emotionally-consistent-users/description/

import pandas as pd

data = [
    [1, 101, "like"],
    [1, 102, "like"],
    [1, 103, "like"],
    [1, 104, "wow"],
    [1, 105, "like"],
    [2, 201, "like"],
    [2, 202, "wow"],
    [2, 203, "sad"],
    [2, 204, "like"],
    [2, 205, "wow"],
    [3, 301, "love"],
    [3, 302, "love"],
    [3, 303, "love"],
    [3, 304, "love"],
    [3, 305, "love"],
]
reactions = pd.DataFrame(
    data,
    columns=["user_id", "content_id", "reaction"],
).astype(
    {
        "user_id": "int64",
        "content_id": "int64",
        "reaction": "string",
    }
)


def find_emotionally_consistent_users(reactions: pd.DataFrame) -> pd.DataFrame:

    return (
        reactions.groupby(["user_id", "reaction"], as_index=False)
        .agg(reaction_count=("content_id", "size"))
        .assign(
            total_reactions=lambda df: df.groupby("user_id")[
                "reaction_count"
            ].transform("sum"),
            reaction_ratio=lambda df: df["reaction_count"] / df["total_reactions"],
        )
        .query("total_reactions >= 5 and reaction_ratio >= .6")
        .rename(columns={"reaction": "dominant_reaction"})
        .assign(reaction_ratio=lambda df: df["reaction_ratio"].add(1e-6).round(2))
        .sort_values(["reaction_ratio", "user_id"], ascending=[False, True])[
            ["user_id", "dominant_reaction", "reaction_ratio"]
        ]
    )
