/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {number} sum
 * @return {number[][]}
 */ 


const treeSum = (node, sum, path_sum, solutions) => {
  if (!node) return [];

  console.log("path", path_sum);
  console.log("solutions", solutions);
  let sm = sum - node.val;
  if (!node.left && !node.right) {
    if(sm === 0) {
      path_sum.push(node.val);
      console.log("SOLUTION", path_sum);
      console.log("solutions", solutions);
      solutions.push(path_sum);
    }
  }

  if(node.left) treeSum(node.left, sm, path_sum.concat([node.val]), solutions);
  if(node.right) treeSum(node.right, sm, path_sum.concat([node.val]), solutions);

};

var pathSum = function(root, sum) {
  const solutions = [];
  treeSum(root, sum, [], solutions);
  return solutions;

};

// 5
// / \
// 4   8
// /   / \
// 11  13  4
// /  \    / \
// 7    2  5   1


class TreeNode {
  constructor(val) {
    this.val = val;
  }
}

const a1 = new TreeNode(5)
const b1 = new TreeNode(4)
const b2 = new TreeNode(8)
const c1 = new TreeNode(11)
const c2 = new TreeNode(13)
const c3 = new TreeNode(4)
const d1 = new TreeNode(7)
const d2 = new TreeNode(2)
const d3 = new TreeNode(5)
const d4 = new TreeNode(1)

a1.left = b1;
a1.right = b2;

b1.left = c1;

b2.left = c2;
b2.right = c3;

c1.left = d1;
c1.right = d2;

c3.left = d3;
c3.right = d4;