# https://leetcode.com/problems/longest-winning-streak/description/

import pandas as pd


def longest_winning_streak(matches: pd.DataFrame) -> pd.DataFrame:
    out = []

    for player_id, grp in matches.groupby("player_id"):
        mx = 0
        curr = 0

        for res in grp.sort_values("match_day").result:
            if res == "Win":
                curr += 1
                if curr > mx:
                    mx = curr
            else:
                curr = 0

        out.append({"player_id": player_id, "longest_streak": mx})

    return pd.DataFrame(out)


# https://leetcode.com/problems/longest-winning-streak/description/


import pandas as pd


def longest_winning_streak(matches: pd.DataFrame) -> pd.DataFrame:
    matches = matches.sort_values(["player_id", "match_day"])

    matches["last_result"] = matches.groupby("player_id").result.shift(1)
    matches["incr"] = matches.apply(
        lambda row: (0 if row.last_result == "Win" and row.result == "Win" else 1),
        axis=1,
    )
    matches["grp"] = matches.incr.cumsum()

    return (
        matches.query("result == 'Win'")
        .groupby(["player_id", "grp"])
        .size()
        .groupby("player_id")
        .max()
        .reindex(matches.player_id.unique(), fill_value=0)
        .rename("longest_streak")
        .reset_index()
    )
