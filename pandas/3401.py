# https://leetcode.com/problems/find-circular-gift-exchange-chains/description/


import pandas as pd


def find_gift_chains(secret_santa: pd.DataFrame) -> pd.DataFrame:
    secret_santa = secret_santa.set_index("giver_id")
    MAP = secret_santa.receiver_id.to_dict()
    VALS = secret_santa.gift_value.to_dict()

    def find_chain(
        giver_start: int, current_giver: int, curr_val: int = None, chain: set = None
    ):
        """
        given @giver_start, find the chain it belongs to and total gift value
        """
        receiver = MAP[current_giver]
        val = VALS[current_giver]

        if not curr_val:
            new_val = val
        else:
            new_val = curr_val + val

        if not chain:
            chain = set([current_giver])
        else:
            chain.add(current_giver)

        if receiver == giver_start:
            return chain, new_val
        else:
            return find_chain(giver_start, receiver, new_val, chain)

    data = []
    used = set()
    for giver in MAP:
        if giver in used:
            continue
        chain, val = find_chain(giver, giver)

        used.update(chain)
        data.append({"chain_length": len(chain), "total_gift_value": val})

    out = (
        pd.DataFrame(data)
        .sort_values(["chain_length", "total_gift_value"], ascending=[False, False])
        .drop_duplicates()
    )
    out.insert(0, "chain_id", [k + 1 for k in range(out.shape[0])])

    return out
