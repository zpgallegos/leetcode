# https://leetcode.com/problems/find-invalid-ip-addresses/description/


import pandas as pd


def ip_is_invalid(ip: str) -> bool:
    octs = ip.split(".")
    if len(octs) != 4:
        return True

    for oct in octs:
        if oct.startswith("0"):
            return True
        if int(oct) > 255:
            return True

    return False


def find_invalid_ips(logs: pd.DataFrame) -> pd.DataFrame:
    return (
        logs[logs.ip.apply(ip_is_invalid)]
        .ip.value_counts()
        .rename("invalid_count")
        .reset_index()
        .sort_values(["invalid_count", "ip"], ascending=[False, False])
    )
