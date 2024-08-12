# https://leetcode.com/problems/find-median-given-frequency-of-numbers/

import pandas as pd

"""
N nums
3 -> idx 2
odd -> floor(N / 2) + 1
4 nums -> mean(idx 2, idx 3)
even -> mean(floor(N / 2), floor(N / 2) + 1)


"""


def median_frequency(numbers: pd.DataFrame) -> pd.DataFrame:
    numbers = numbers.sort_values("num")
    numbers["cum"] = numbers.frequency.cumsum()

    get_first = lambda idx: numbers[numbers.cum >= idx].num.min()

    N = numbers.cum.iloc[-1]

    if N % 2 == 0:
        low = N / 2
        high = low + 1
        ans = (get_first(low) + get_first(high)) / 2
    else:
        mid = int(N // 2) + 1
        ans = get_first(mid)

    return pd.DataFrame({"median": [round(ans, 2)]})
