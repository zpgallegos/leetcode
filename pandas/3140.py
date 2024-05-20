# https://leetcode.com/problems/consecutive-available-seats-ii/


import pandas as pd

data = [[1, 1], [2, 0], [3, 1], [4, 1], [5, 1]]
cinema = pd.DataFrame(data, columns=["seat_id", "free"])


def consecutive_available_seats(cinema: pd.DataFrame) -> pd.DataFrame:
    cinema = cinema.sort_values(by="seat_id")
    cinema["chg"] = ((cinema.free == 1) & (cinema.free.shift().eq(0))).astype(int)
    cinema["grp"] = cinema.chg.cumsum()
    cinema = cinema.query("free == 1")

    grp_cnts = cinema.groupby("grp").size()
    max_grps = grp_cnts[grp_cnts.transform(lambda x: x == x.max())].index

    return (
        cinema[cinema.grp.isin(max_grps)]
        .groupby("grp")
        .agg(
            first_seat_id=("seat_id", "min"),
            last_seat_id=("seat_id", "max"),
            consecutive_seats_len=("seat_id", "count"),
        )
    )
