

class MinStack:
    def __init__(self):
        self.stack = []

    def push(self, val):
        if self.stack:
            if val <= self.getMin():
                self.min_n += 1
                self.mins[self.min_n] = val
        else:
            self.min_n = 0
            self.mins = {self.min_n: val}
        self.stack.append(val)
    
    def pop(self):
        out = self.stack.pop()
        if self.getMin() == out:
            self.mins.pop(self.min_n)
            self.min_n -= 1
        return out

    def top(self):
        return self.stack[-1]

    def getMin(self):
        return self.mins[self.min_n]


if __name__ == "__main__":

    # ["MinStack","push","push","push","push","getMin","pop","getMin","pop","getMin","pop","getMin"]
    # [[]        ,   [2],   [0],   [3],   [0],      [],   [],      [],   [],      [],   [],      []]
    # [      null,  null,  null,  null,  null,       0, null,       0, null,       0, null,       2]
    m = MinStack()
    m.push(2)
    m.push(0)
    m.push(3)
    m.push(0)
    m.getMin() # -> 0
    m.pop() # -> 0
    m.getMin() # -> 0
    m.pop()
    m.getMin() # -> 0
    m.pop()
    m.getMin() # -> 2
