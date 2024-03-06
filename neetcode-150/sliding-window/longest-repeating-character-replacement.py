class Solution:
    """brute, times out"""

    def characterReplacement(self, s, k):
        n = len(s)
        if n <= 1:
            return n

        out = 1
        for l in range(n - 1):
            r = l + 1
            used = 0
            max_len = 1

            while r < n:
                char = s[r]

                if char != s[l]:
                    if used == k:
                        break
                    else:
                        used += 1

                max_len += 1
                out = max(out, max_len)

                if r == n - 1 and used < k:
                    max_len = min(n, max_len + k - used)
                    out = max(out, max_len)

                r += 1

        return out


class Solution:
    def characterReplacement(self, s, k):
        freqs = {}
        l = 0
        out = 0
        for r in range(len(s)):
            char = s[r]
            freqs[char] = freqs.get(char, 0) + 1
            window_len = r - l + 1

            used = window_len - max(freqs.values())
            gap = used - k
            if gap <= 0:  # valid window
                out = max(out, window_len)
            else:  # invalid, increase l until it's valid
                for _ in range(gap):
                    freqs[s[l]] -=1
                    l += 1

        return out
