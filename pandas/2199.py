# https://leetcode.com/problems/finding-the-topic-of-each-post/

import pandas as pd


def find_topic(keywords: pd.DataFrame, posts: pd.DataFrame) -> pd.DataFrame:
    tokenize = lambda doc: doc.lower().split(" ")
    posts["tokens"] = posts.content.apply(tokenize)

    kw = keywords.groupby("topic_id").word.apply(lambda x: set(x.str.lower())).to_dict()

    def get_topics(tokens: list[str]) -> str:
        out = []
        for post_id, keywords in kw.items():
            for keyword in keywords:
                if keyword in tokens:
                    out.append(post_id)
                    break
        return ",".join(map(str, out)) if out else "Ambiguous!"

    posts["topic"] = posts.tokens.apply(get_topics)

    return posts[["post_id", "topic"]]
