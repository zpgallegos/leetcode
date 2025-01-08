# https://leetcode.com/problems/first-letter-capitalization-ii/description/


import pandas as pd


def capitalize_content(user_content: pd.DataFrame) -> pd.DataFrame:
    user_content["converted_text"] = user_content.content_text.str.title()
    return user_content.rename(columns={"content_text": "original_text"})
