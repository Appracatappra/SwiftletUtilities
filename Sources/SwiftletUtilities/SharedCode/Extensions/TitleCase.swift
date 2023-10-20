// The MIT License (MIT)
//
// Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import Foundation

/// https://gist.github.com/devxoul/a1e6822def36f75d0bc5
extension String {

  /// Returns titlecased string.
  ///
  ///     "we're having dinner in the garden".titlecaseString // We're Having Dinner In The Garden
  ///     "TheSwiftProgrammingLanguage" // The Swift Programming Language
  func titlecased() -> String {
    if self.count <= 1 {
      return self.uppercased()
    }

    let regex = try! NSRegularExpression(pattern: "(?=\\S)[A-Z]", options: [])
    let range = NSMakeRange(1, self.count - 1)
    var titlecased = regex.stringByReplacingMatches(in: self, range: range, withTemplate: " $0")

    for i in titlecased.indices {
      if i == titlecased.startIndex || titlecased[titlecased.index(before: i)] == " " {
        titlecased.replaceSubrange(i...i, with: String(titlecased[i]).uppercased())
      }
    }
    return titlecased
  }

}
