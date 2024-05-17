# https://leetcode.com/problems/invalid-tweets-ii/


import pandas as pd


def is_invalid(tweet: str) -> bool:
    if len(tweet) > 140:
        return True

    hash_count = 0
    mention_count = 0
    tokens = tweet.split()
    for i in range(len(tokens) - 1, -1, -1):
        token = tokens[i]
        if len(token) > 1:
            if token.startswith("#"):
                hash_count += 1
                if hash_count == 4:
                    return True
            elif token.startswith("@"):
                mention_count += 1
                if mention_count == 4:
                    return True
    return False


def find_invalid_tweets(tweets: pd.DataFrame) -> pd.DataFrame:
    return tweets.loc[tweets.content.apply(is_invalid), ["tweet_id"]].sort_values(
        "tweet_id"
    )
