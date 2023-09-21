# https://leetcode.com/problems/sales-analysis-i/submissions/

import pandas as pd

def sales_analysis(product: pd.DataFrame, sales: pd.DataFrame) -> pd.DataFrame:
    d = sales.groupby("seller_id").price.sum()
    out = d[d == d.max()].index.to_list()
    return pd.DataFrame({"seller_id": out})