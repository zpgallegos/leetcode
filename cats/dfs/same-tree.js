// https://leetcode.com/problems/same-tree/

/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} p
 * @param {TreeNode} q
 * @return {boolean}
 */

var isSameTree = function(p, q) {
  if(!p) return q ? false : true;
  if(!q) return p? false : true;

  let node1;
  let node2;

  const q1 = [];
  const q2 = [];

  q1.push(p);
  q2.push(q);

  while (q1.length && q2.length) {
    node1 = q1.shift();
    node2 = q2.shift();

    if (node1.val !== node2.val) {
      return false;
    }

    if((node1.left && !node2.left) || (!node1.left && node2.left)) {
      return false;
    } else {
      if(node1.left) q1.push(node1.left);
      if(node2.left) q2.push(node2.left);
    }

    if((node1.right && !node2.right) || (!node1.right && node2.right)) {
      return false;
    } else {
      if(node1.right) q1.push(node1.right);
      if(node2.right) q2.push(node2.right);
    }

  }

  return true;
};
