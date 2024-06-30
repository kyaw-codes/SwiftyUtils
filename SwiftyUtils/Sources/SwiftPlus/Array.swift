//
//  Array.swift
//  
//
//  Created by Kyaw Zay Ya Lin Tun on 30/06/2024.
//

import Foundation

public extension Array {
  /// Check whether the given array is not empy or not.
  var isNotEmpty: Bool { !isEmpty }
  
  /// Safe access to elements of an array
  /// If the index is within the bounds of the collection, it returns the element at the specified index. Otherwise, it returns nil.
  subscript(safe index: Int) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
  
  /// Converts an array into a dictionary where the keys are the string representations of the array's indices, and the values are the elements of the array at those indices.
  func toDictionary() -> [String: Element] {
    zip(self.indices, self).reduce(into: [:]) { $0["\($1.0)"] = $1.1 }
  }
  
  /// Applies a given transformation to each element of an array, modifying the elements in place, particularly use for value type elements.
  /// - Parameter transform: Closure that takes an `inout Element` and performs some operation on it. The closure can throw an error, and if it does, the function will propagate the error.
  ///
  /// To use this function, you call it on a mutable collection and pass a closure that modifies each element. If the closure can throw an error, you need to handle the error using `try`, `try?`, or `try!`.
  /**
    ```swift
     struct Person {
       let name: String
       var age: Int
     }

     var people: [Person] = [
       Person(name: "John", age: 20),
       Person(name: "Jane", age: 18),
       Person(name: "Alice", age: 22),
       Person(name: "Bob", age: 16)
     ]

     people.mutateInPlace { person in
       person.age += 1
     }
    // You will see each person's age is incremented in `people` array.
    ```
   */
  mutating func mutateInPlace(by transform: (inout Element) throws -> Void) rethrows {
    var i = startIndex
    while i != endIndex {
      defer { i = index(after: i) }
      try transform(&self[i])
    }
  }
}
