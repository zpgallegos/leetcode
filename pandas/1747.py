# https://leetcode.com/problems/leetflex-banned-accounts/description/


import pandas as pd


def leetflex_banned_accnts(log_info: pd.DataFrame) -> pd.DataFrame:
    return (
        log_info.merge(log_info, on="account_id")
        .query(
            "ip_address_x != ip_address_y and login_y >= login_x and login_y <= logout_x"
        )[["account_id"]]
        .drop_duplicates()
    )
