# https://leetcode.com/problems/finding-the-topic-of-each-post/

import pandas as pd

data = [[1, "handball"], [1, "football"], [3, "WAR"], [2, "Vaccine"]]
keywords = pd.DataFrame(data, columns=["topic_id", "word"]).astype(
    {"topic_id": "Int64", "word": "object"}
)
data = [
    [1, "We call it soccer They call it football hahaha"],
    [2, "Americans prefer basketball while Europeans love handball and football"],
    [3, "stop the war and play handball"],
    [4, "warning I planted some flowers this morning and then got vaccinated"],
]
posts = pd.DataFrame(data, columns=["post_id", "content"]).astype(
    {"post_id": "Int64", "content": "object"}
)


def get_post_topics(content: str, keywords: pd.DataFrame) -> str:
    tokens = content.lower().split()

    matches = set()
    for row in keywords.itertuples():
        if row.word in tokens:
            matches.add(row.topic_id)

    if not matches:
        return "Ambiguous!"

    return ",".join(map(str, sorted(matches)))


def find_topic(keywords: pd.DataFrame, posts: pd.DataFrame) -> pd.DataFrame:

    keywords = keywords.assign(word=lambda df: df.word.str.lower())

    return posts.assign(
        topic=lambda df: df.content.apply(lambda x: get_post_topics(x, keywords))
    ).drop(columns="content")

