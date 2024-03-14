# https://leetcode.com/problems/ad-free-sessions/


import pandas as pd


def ad_free_sessions(playback: pd.DataFrame, ads: pd.DataFrame) -> pd.DataFrame:
    playback = playback.merge(ads, how="left", on="customer_id")

    return pd.DataFrame(
        {
            "session_id": list(
                set(playback.session_id).difference(
                    set(
                        playback.loc[
                            (playback.timestamp >= playback.start_time)
                            & (playback.timestamp <= playback.end_time),
                            "session_id",
                        ]
                    )
                )
            )
        }
    )
