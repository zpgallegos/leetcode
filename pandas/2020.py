# https://leetcode.com/problems/number-of-accounts-that-did-not-stream/description/

import pandas as pd


def find_target_accounts(
    subscriptions: pd.DataFrame, streams: pd.DataFrame
) -> pd.DataFrame:
    active = set(
        subscriptions[
            (subscriptions.start_date.dt.year <= 2021)
            & (subscriptions.end_date.dt.year >= 2021)
        ].account_id
    )

    streamed = set(streams[streams.stream_date.dt.year == 2021].account_id)

    return pd.DataFrame({"accounts_count": [len(active - streamed)]})
