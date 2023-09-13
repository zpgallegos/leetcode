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
 * @return {boolean}
 */

const treeSum = (node, sum) => {
  if(!node) return false;

  let sm = sum - node.val;
  if(!node.left && !node.right) return sm === 0;

  return treeSum(node.left, sm) || treeSum(node.right, sm);

}


var hasPathSum = function(root, sum) {
  return treeSum(root, sum);
};

//        5
//       / \
//      4   8
//     /   / \
//   11  13   4
//  /  \       \
// 7    2       1

//        5
//       / \
//      4   8
