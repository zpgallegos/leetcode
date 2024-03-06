def string_to_dict(s):
    d = {}
    for char in s:
        d[char] = d.get(char, 0) + 1
    return d


def contains(t_dict, sub_dict):
    for char, count in t_dict.items():
        if sub_dict.get(char, 0) < count:
            return False
    return True


class Solution:
    def minWindow(self, s, t):
        if len(s) < len(t):
            return ""

        t_dict = string_to_dict(t)

        out = None
        l = 0
        r = l + len(t)
        sub_dict = None
        while r <= len(s):
            if not sub_dict:
                sub_dict = string_to_dict(s[l:r])

            if not contains(t_dict, sub_dict):
                try:
                    add_char = s[r]
                    sub_dict[add_char] = sub_dict.get(add_char, 0) + 1
                except IndexError:
                    pass

                r += 1

            else:
                window_len = r - l
                if window_len == len(t):  # answer guaranteed unique, shortest possible
                    return s[l:r]

                if not out or window_len < out[1] - out[0]:
                    out = (l, r)

                rem_char = s[l]
                sub_dict[rem_char] -= 1
                l += 1

        return "" if not out else s[out[0] : out[1]]
