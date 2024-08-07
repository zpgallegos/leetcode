# https://leetcode.com/problems/server-utilization-time/description/

import pandas as pd


def server_utilization_time(servers: pd.DataFrame) -> pd.DataFrame:
    servers["status_time"] = pd.to_datetime(
        servers["status_time"]
    )  # shouldn't be needed based on the schema given, but it is

    servers = servers.sort_values(["server_id", "status_time"])
    servers["last_time"] = servers.groupby("server_id").status_time.diff()

    ans = servers.query("session_status == 'stop'").last_time.dt.seconds.sum() / (
        60 * 60 * 24
    )

    return pd.DataFrame({"total_uptime_days": [int(ans)]})
