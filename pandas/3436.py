# https://leetcode.com/problems/find-valid-emails/description/

import re
import pandas as pd

EMAIL = re.compile(r"^\w+@[a-z]+.com", re.I)


def find_valid_emails(users: pd.DataFrame) -> pd.DataFrame:
    return users[users.email.apply(lambda x: EMAIL.search(x) is not None)]

