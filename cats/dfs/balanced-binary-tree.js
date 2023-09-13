/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */

const treeHeight = node => {
  if(!node) return 0;

  const leftHeight = treeHeight(node.left);
  const rightHeight = treeHeight(node.right);

  if(Math.abs(leftHeight - rightHeight) > 1) return -1;
  if(leftHeight === -1 || rightHeight === -1) return -1;

  return Math.max(leftHeight, rightHeight) + 1;

}


var isBalanced = function(root) {
  return treeHeight(root) !== -1;
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