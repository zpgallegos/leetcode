# https://leetcode.com/problems/longest-team-pass-streak/description/

import pandas as pd


def time_to_num(time_stamp: str) -> float:
    mn, sec = time_stamp.split(":")
    return float(mn) + float(sec) / 60


def calculate_longest_streaks(
    teams: pd.DataFrame, passes: pd.DataFrame
) -> pd.DataFrame:
    team_map = teams.set_index("player_id").team_name.to_dict()

    passes["time_num"] = passes.time_stamp.apply(time_to_num)
    passes["team_name"] = passes.pass_from.map(team_map)
    passes["pass_to_team"] = passes.pass_to.map(team_map)
    passes["success"] = (passes.team_name == passes.pass_to_team).astype(int)

    passes = passes.sort_values(["team_name", "time_num"])
    passes["last"] = passes.groupby("team_name").success.shift(1)

    out = []
    for team, grp in passes.groupby("team_name"):
        mx = 0
        curr = 0
        for row in grp.itertuples():
            if row.success:
                curr += 1
            else:
                if curr > mx:
                    mx = curr
                curr = 0

        if curr > mx:
            mx = curr

        out.append({"team_name": team, "longest_streak": mx})

    return pd.DataFrame(out).query("longest_streak > 0")  # doesn't want the zeros...
