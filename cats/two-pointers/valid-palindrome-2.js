/**
 * @param {string} s
 * @return {boolean}
 */

const p = s => {
  if (s.length <= 1) return true;

  let l = 0;
  let r = s.length - 1;

  while (l <= r) {
    if (s[l] !== s[r]) return false;
    l++;
    r--;
  }
  return true;
};

const p1 = s => {
  if (s.length <= 1) return true;

  let l = 0;
  let r = s.length - 1;

  while (l <= r) {
    if (s[l] !== s[r]) {
      console.log(`check ${s.slice(l + 1, r + 1)} ${p(s.slice(l + 1, r + 1))}`);
      console.log(`check ${s.slice(l, r)} ${p(s.slice(l, r))}`)
      return p(s.slice(l + 1, r + 1)) || p(s.slice(l, r));
    }
    l++;
    r--;
  }
  return true;
};

var validPalindrome = function(s) {
  return p1(s);
};

s = "eeccccbebaeeabebcccee";

validPalindrome(s);
