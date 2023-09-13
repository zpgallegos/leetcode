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

const isMirror = (tree1, tree2) => {
  if(!tree1 || !tree2) return tree1 === tree2;
  if(tree1.val !== tree2.val) return false;
  return isMirror(tree1.left, tree2.right) && isMirror(tree1.right, tree2.left)

}

var isSymmetric = function(root) {
  if(!root) return true;
  return isMirror(root.left, root.right);
};

//
      1
     / \
    2   2
   / \  / \
  3  4 4  3
 / \     / \
5  6    6   5