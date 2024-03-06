def div_towards_zero(a, b):
    if (a < 0) ^ (b < 0):
        return int(a / b)
    return a // b


OPERATORS = {
    "+": lambda a, b: a + b,
    "-": lambda a, b: a - b,
    "*": lambda a, b: a * b,
    "/": lambda a, b: div_towards_zero(a, b),
}


class Solution:
    def evalRPN(self, tokens):
        stack = []

        for token in tokens:
            if token in OPERATORS:
                b = int(stack.pop())
                a = int(stack.pop())
                stack.append(OPERATORS[token](a, b))
            else:
                stack.append(token)

        out = stack[0]
        return int(out) if not isinstance(out, int) else out
