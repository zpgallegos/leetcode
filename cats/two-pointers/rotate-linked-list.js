/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} k
 * @return {ListNode}
 */

const rotate = (head, newTail) => {
  const tail = newTail.next;
  tail.next = head;
  newTail.next = null;
  return tail;
}

const doRotation = head => {
  let node = head;
  while(node.next.next) {
    node = node.next;
  }
  return rotate(head, node);
}

var rotateRight = function(head, k) {
  if(!head) return head;
  if(!head.next) return head;
  for(let i = 0; i < k; i++) head = doRotation(head);
  return head;
};


class ListNode {
  constructor(val) {
    this.val = val;
    this.next = null;
  }
}

const n1 = new ListNode(0);
const n2 = new ListNode(1);
const n3 = new ListNode(2);
n1.next = n2;
n2.next = n3;