# https://leetcode.com/problems/delete-duplicate-emails/

import pandas as pd

# Modify Person in place
def delete_duplicate_emails(person: pd.DataFrame) -> None:
    mn = person.groupby("email").id.min()
    drop = set(person.id) - set(mn)
    person.drop(person[person.id.isin(drop)].index, inplace=True)