import collections

def solution(root):
    if not root:
        return []
    
    d = collections.deque()
    d.append(root)
    res = [root.val]

    while d:

        children = []
        for node in d:
            if node.left:
                children.append(node.left)
            if node.right:
                children.append(node.right)
        
        if children:
            res.append(children[-1].val)
        
        d = children
    
    return res