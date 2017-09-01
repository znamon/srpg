module util.string;

import std.conv;

string subString(string sText, int iStart, int iEnd) {
  return sText.subRange(iStart, iEnd).text;
};
