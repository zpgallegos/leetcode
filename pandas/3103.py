# https://leetcode.com/problems/find-trending-hashtags-ii/description/

import re
import pandas as pd


TAG = re.compile(r"#\w+")


def find_trending_hashtags(tweets: pd.DataFrame) -> pd.DataFrame:
    tags = tweets.tweet.apply(lambda tweet: TAG.findall(tweet))

    out = {}
    for row in tags:
        for tag in row:
            out[tag] = out.get(tag, 0) + 1

    tag, count = zip(*out.items())

    return (
        pd.DataFrame({"hashtag": tag, "count": count})
        .sort_values(["count", "hashtag"], ascending=[False, False])
        .head(3)
    )
