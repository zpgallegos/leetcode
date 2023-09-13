/**
 * @param {string} s
 * @return {boolean}
 */

var isPalindrome = function(s) {
  if (s.length <= 1) return true;

  let l = 0;
  let r = s.length - 1;

  s = s.toLowerCase();

  const letters = new Set([
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ]);

  while (l <= r) {
    // while (!s[l].match(/[a-z0-9]/)) {
    while (!letters.has(s[l])) {
      l++;
      if (l >= s.length) return true;
    }
    // while (!s[r].match(/[a-z0-9]/)) r--;
    while (!letters.has(s[r])) r--;
    if (s[l] !== s[r]) return false;
    l++;
    r--;
  }
  return true;
};

s = "\" `b93\"a\"?\"aQ39b` Q"

isPalindrome(s)