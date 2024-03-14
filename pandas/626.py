# https://leetcode.com/problems/exchange-seats/

import pandas as pd


def exchange_seats(seat: pd.DataFrame) -> pd.DataFrame:
    seat = seat.set_index("id")

    nxt = True
    for idx in seat.index:
        if nxt:
            prev = seat.loc[idx, "student"]
            try:
                seat.loc[idx, "student"] = seat.loc[idx + 1, "student"]
            except KeyError:
                pass
            nxt = False
        else:
            seat.loc[idx, "student"] = prev
            nxt = True
    
    return seat.reset_index()




