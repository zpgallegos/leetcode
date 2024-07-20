# https://leetcode.com/problems/bitwise-user-permissions-analysis/

import pandas as pd

from functools import reduce


def _bit_and(x):
    return reduce(lambda a, b: a & b, x)


def _bit_or(x):
    return reduce(lambda a, b: a | b, x)


def analyze_permissions(user_permissions: pd.DataFrame) -> pd.DataFrame:
    return user_permissions.agg(
        common_perms=("permissions", _bit_and), any_perms=("permissions", _bit_or)
    ).T
