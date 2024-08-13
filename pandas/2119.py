# https://leetcode.com/problems/finding-the-topic-of-each-post/


import pandas as pd


def find_topic(keywords: pd.DataFrame, posts: pd.DataFrame) -> pd.DataFrame:
    posts["content"] = posts.content.str.lower()
    keywords["word"] = keywords.word.str.lower()

    def get_topics(doc: str) -> str:
        out = set()
        tokens = doc.split(" ")
        for row in keywords.itertuples():
            if row.topic_id in out:
                continue
            if row.word in tokens:
                out.add(row.topic_id)
        return ",".join(map(str, sorted(out))) if out else "Ambiguous!"

    posts["topic"] = posts.content.apply(get_topics)

    return posts[["post_id", "topic"]]
