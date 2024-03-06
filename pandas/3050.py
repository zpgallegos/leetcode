# https://leetcode.com/problems/pizza-toppings-cost-analysis/

import pandas as pd


data = [
    ("Ham", 1.37),
    ("Onions", 1.87),
    ("Sausage", 1.83),
    ("Mushrooms", 1.16),
    ("Bacon", 1.95),
    ("Peppers", 1.03),
    ("Pepperoni", 1.77),
    ("Chicken", 1.57),
    ("Olives", 1.32),
    ("Tomatoes", 1.29),
    ("Cheese", 1.96),
    ("Pineapple", 1.9),
]

toppings = pd.DataFrame(data, columns=["topping_name", "cost"])


def cost_analysis(toppings: pd.DataFrame) -> pd.DataFrame:
    n = toppings.shape[0]
    toppings = toppings.sort_values("topping_name").reset_index(drop=True)

    out = []
    for left in range(n):
        for mid in range(left + 1, n):
            for right in range(mid + 1, n):
                rows = [toppings.loc[i] for i in (left, mid, right)]
                out.append(
                    {
                        "pizza": ",".join(getattr(row, "topping_name") for row in rows),
                        "total_cost": round(
                            sum(getattr(row, "cost") for row in rows), 2
                        ),
                    }
                )

    return pd.DataFrame(out).sort_values(
        ["total_cost", "pizza"], ascending=[False, True]
    )
