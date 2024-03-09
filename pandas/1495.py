# https://leetcode.com/problems/friendly-movies-streamed-last-month/description/

import pandas as pd


def friendly_movies(tv_program: pd.DataFrame, content: pd.DataFrame) -> pd.DataFrame:
    june_aired = set(tv_program[tv_program.program_date.dt.month == 6].content_id)

    return content.loc[
        (content.Kids_content == "Y")
        & (content.content_type == "Movies")
        & (content.content_id.isin(june_aired)),
        ["title"],
    ].drop_duplicates()
