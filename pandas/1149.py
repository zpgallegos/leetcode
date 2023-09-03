# https://leetcode.com/problems/article-views-ii/?lang=pythondata

import pandas as pd

def article_views(views: pd.DataFrame) -> pd.DataFrame:
    cnt = views.groupby(["viewer_id", "view_date"]).article_id.nunique()
    ids = cnt[cnt > 1].index.get_level_values(0)
    ids = sorted(set(ids))
    return pd.DataFrame({"id": ids})