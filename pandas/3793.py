# https://leetcode.com/problems/find-users-with-high-token-usage/

import pandas as pd

data = [
    [1, "Write a blog outline", 120],
    [1, "Generate SQL query", 80],
    [1, "Summarize an article", 200],
    [2, "Create resume bullet", 60],
    [2, "Improve LinkedIn bio", 70],
    [3, "Explain neural networks", 300],
    [3, "Generate interview Q&A", 250],
    [3, "Write cover letter", 180],
    [3, "Optimize Python code", 220],
]
prompts = pd.DataFrame(data, columns=["user_id", "prompt", "tokens"]).astype(
    {
        "user_id": "int64",
        "prompt": "string",
        "tokens": "int64",
    }
)


def find_users_with_high_tokens(prompts: pd.DataFrame) -> pd.DataFrame:
    stats = prompts.groupby("user_id", as_index=False).agg(
        prompt_count=("prompt", "size"),
        avg_tokens=("tokens", "mean"),
        max_tokens=("tokens", "max"),
    )

    return (
        stats.query("prompt_count >= 3 and max_tokens > avg_tokens")
        .assign(avg_tokens=lambda df: df.avg_tokens.round(2))
        .drop(columns="max_tokens")
        .sort_values(
            ["avg_tokens", "user_id"],
            ascending=[False, True],
        )
        .reset_index(drop=True)
    )
