# https://leetcode.com/problems/top-percentile-fraud/

import numpy as np
import pandas as pd


def top_percentile_fraud(fraud: pd.DataFrame) -> pd.DataFrame:
    fraud = fraud.sort_values(
        ["state", "fraud_score", "policy_id"], ascending=[True, False, True]
    )

    grp = fraud.groupby("state")
    fraud["rnk"] = grp.fraud_score.rank(method="max")
    fraud["n"] = grp.state.transform(len)

    return fraud[fraud.rnk >= np.ceil(fraud.n * 0.95)][
        ["policy_id", "state", "fraud_score"]
    ]
