def is_permutation(d1, d2):
    for char, count in d1.items():
        if count != d2.get(char):
            return False
    return True


def string_to_dict(s):
    d = {}
    for char in s:
        d[char] = d.get(char, 0) + 1
    return d


class Solution:
    def checkInclusion(self, s1, s2):
        if len(s2) < len(s1):
            return False

        l1, l2 = (len(s) for s in (s1, s2))
        d1 = string_to_dict(s1)

        l = 0
        r = l + l1
        d2 = None
        while r <= l2:
            sub = s2[l:r]

            if not d2:
                d2 = string_to_dict(sub)
            else:
                new_char = s2[r - 1]
                d2[new_char] = d2.get(new_char, 0) + 1
                d2[s2[l - 1]] -= 1

            if is_permutation(d1, d2):
                return True

            l += 1
            r += 1

        return False
