# https://leetcode.com/problems/find-bursty-behavior/

import pandas as pd

data = [
    [1, 1, "2024-02-27"],
    [6, 2, "2024-02-25"],
    [7, 3, "2024-02-01"],
    [5, 3, "2024-02-06"],
    [4, 3, "2024-02-14"],
    [3, 3, "2024-02-25"],
    [2, 5, "2024-02-06"],
]
posts = pd.DataFrame(data, columns=["post_id", "user_id", "post_date"]).astype(
    {"post_id": "Int64", "user_id": "Int64", "post_date": "datetime64[ns]"}
)


def find_bursty_behavior(posts: pd.DataFrame) -> pd.DataFrame:
    feb = posts.query(
        "post_date >= '2024-02-01' and post_date <= '2024-02-28'"
    ).sort_values(["user_id", "post_date"])

    avgs = feb.user_id.value_counts() / 4
    avgs.name = "avg_weekly_posts"

    mxs = (
        feb.groupby("user_id")
        .rolling("7D", on="post_date")
        .post_id.count()
        .groupby("user_id")
        .max()
    )
    mxs.name = "max_7day_posts"

    return (
        pd.concat((mxs, avgs), axis=1)
        .reset_index()
        .query("max_7day_posts >= 2 * avg_weekly_posts")
        .sort_values("user_id")
    )
