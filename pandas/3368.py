# https://leetcode.com/problems/first-letter-capitalization/


import pandas as pd


def process_text(user_content: pd.DataFrame) -> pd.DataFrame:
    user_content["converted_text"] = user_content.content_text.str.title()
    return user_content.rename(columns={"content_text": "original_text"})
