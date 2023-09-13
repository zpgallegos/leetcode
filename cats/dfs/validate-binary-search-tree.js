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

const isValid = (tree, min, max) => {
  if (!tree) return true;
  if (tree.val < min || tree.val > max) return false;
  return (
    isValid(tree.left, min, tree.val - 1) &&
    isValid(tree.right, tree.val + 1, max)
  );
};

var isValidBST = function(root) {
  return isValid(root, -Infinity, Infinity);
};

//   2
//  / \
// 1   3

//     5
//    / \
//   1   4
//      / \
//     3   6
