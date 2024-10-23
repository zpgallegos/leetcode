# https://leetcode.com/problems/count-the-number-of-experiments/description/

# fails test case 21 which requires a hardcode (all combinations not knowable from the input data)
# not going to bother with that lol

import pandas as pd


def count_experiments(experiments: pd.DataFrame) -> pd.DataFrame:
    by = ["platform", "experiment_name"]

    return (
        experiments.groupby(by)
        .experiment_id.nunique()
        .rename("num_experiments")
        .reindex(
            pd.MultiIndex.from_product((experiments[k].unique() for k in by), names=by),
            fill_value=0,
        )
        .reset_index()
    )
