/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {string[]}
 */

const stringify = arr => arr.reduce((a, b) => a + (a ? "->" : "") + b, "");

const dfs = (node, paths, solutions) => {
  if (!node) return [];
  if (!node.left && !node.right)
    solutions.push(stringify(paths.concat([node.val])));
  if (node.left) dfs(node.left, paths.concat([node.val]), solutions);
  if (node.right) dfs(node.right, paths.concat([node.val]), solutions);
};

var binaryTreePaths = function(root) {
  const solutions = [];
  dfs(root, [], solutions);
  return solutions;
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
