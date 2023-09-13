
const grph = {
  "a": {
    children: ["b", "c", "d", "e"]
  },
  "b": {
    children: ["a", "c", "g"]
  },
  "c": {
    children: ["a", "b", "d"]
  },
  "d": {
    children: ["a", "c", "e"]
  },
  "e": {
    children: ["a", "d", "f"]
  },
  "f": {
    children: ["e", "g", "h"]
  },
  "g": {
    children: ["b", "f"]
  },
  "h": {
    children: ["d", "f"]
  }
}

const bfs = graph => {
  let node;
  const stack = [];
  const seen = new Set();
  stack.push("a")

  while(stack.length) {
    node = stack.shift();
    if(!seen.has(node)) {
      seen.add(node);
      console.log(node);
    }
    for(let child of graph[node].children) {
      if(!seen.has(child)) stack.push(child);
    }
  }
}