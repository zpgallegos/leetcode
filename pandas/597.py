# https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/?lang=pythondata

import pandas as pd


def acceptance_rate(
    friend_request: pd.DataFrame, request_accepted: pd.DataFrame
) -> pd.DataFrame:
    out_col = "accept_rate"

    if not friend_request.shape[0] or not request_accepted.shape[0]:
        rate = 0
    else:
        reqs = (
            ~friend_request.duplicated(subset=["sender_id", "send_to_id"], keep="first")
        ).sum()
        acc = (
            ~request_accepted.duplicated(
                subset=["requester_id", "accepter_id"], keep="first"
            )
        ).sum()
        rate = round(acc / reqs, 2)

    return pd.DataFrame({out_col: [rate]})
