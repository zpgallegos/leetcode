/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */

const isLeaf = node => !node.left && !node.right;
const min = arrs => {
  if(!arrs.length) return 0;
  let mn = Infinity;
  for(let arr of arrs) if(arr.length < mn) mn = arr.length;
  return mn;
}

const dfs = (node, path, leafPaths) => {
  if (!node) return 0;

  if (isLeaf(node)) {
    leafPaths.push(path.concat([node.val]));
  }

  if (node.left) dfs(node.left, path.concat([node.val]), leafPaths);
  if (node.right) dfs(node.right, path.concat([node.val]), leafPaths);
};

var minDepth = function(root) {
  const leafPaths = [];
  dfs(root, [], leafPaths);
  return min(leafPaths);
};


class TreeNode {
  constructor(val) {
    this.val = val;
  }
}

const a1 = new TreeNode(5);
const b1 = new TreeNode(4);
const b2 = new TreeNode(8);
const c1 = new TreeNode(11);
const c2 = new TreeNode(13);
const c3 = new TreeNode(4);
const d1 = new TreeNode(7);
const d2 = new TreeNode(2);
const d3 = new TreeNode(5);
const d4 = new TreeNode(1);

a1.left = b1;
a1.right = b2;

b1.left = c1;

b2.left = c2;
b2.right = c3;

c1.left = d1;
c1.right = d2;

c3.left = d3;
c3.right = d4;
