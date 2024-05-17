# https://leetcode.com/problems/find-trending-hashtags/

import re
import pandas as pd


def find_trending_hashtags(tweets: pd.DataFrame) -> pd.DataFrame:
    tags = tweets.tweet.apply(lambda tweet: re.search(r"#\w+", tweet).group(0))

    return (
        tags.value_counts()
        .reset_index()
        .rename(columns={"tweet": "hashtag", "count": "hashtag_count"})
        .sort_values(["hashtag_count", "hashtag"], ascending=[False, False])
        .head(3)
    )
