# https://leetcode.com/problems/find-all-unique-email-domains/description/

import re
import pandas as pd


DOMAIN_RE = re.compile(r"@(?P<domain>\w+\.com)$", re.I)


def get_domain(email):
    m = DOMAIN_RE.search(email)
    return m.group("domain") if m else None


def get_domain(email):
    _, dom = email.split("@")
    return dom if dom.endswith(".com") else None


def find_unique_email_domains(emails: pd.DataFrame) -> pd.DataFrame:
    doms = emails.email.apply(get_domain)

    return (
        doms[doms.notnull()]
        .value_counts()
        .reset_index()
        .rename(columns={"email": "email_domain", 0: "count"})
        .sort_values("email_domain")
    )
