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

var maxDepth = function(root) {
  if(!root) return 0;

  const lDepth = maxDepth(root.left);
  const rDepth = maxDepth(root.right);

  return Math.max(lDepth, rDepth) + 1;

}


