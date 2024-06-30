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
  
  /**
   Applies a given transformation to each element of an array, modifying the elements in place, particularly use for value type elements.
   
   - Parameter transform: Closure that takes an `inout Element` and performs some operation on it. The closure can throw an error, and if it does, the function will propagate the error.
  
   To use this function, you call it on a mutable collection and pass a closure that modifies each element. If the closure can throw an error, you need to handle the error using `try`, `try?`, or `try!`.
   
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
  
  /**
  Returns an array containing unique elements from the original collection based on a specified mapping. The uniqueness of each element is determined by the value returned from the provided mapping closure.
  - Parameter map: A closure that takes an element of the collection and returns a value of a hashable type `T`.
  - Returns: An array containing elements from the original collection that are unique based on the value produced by the mapping closure.
   
   ```swift
   struct Car {
       let model: String
       let year: Int
   }

   let cars = [
       Car(model: "Toyota", year: 2020),
       Car(model: "Honda", year: 2020),
       Car(model: "Toyota", year: 2021),
       Car(model: "Ford", year: 2020)
   ]

   let uniqueCarsByModel = cars.unique(\.model)
   
   // uniqueCarsByModel will be:
   // [
   //   Car(model: "Toyota", year: 2020),
   //   Car(model: "Honda", year: 2020),
   //   Car(model: "Ford", year: 2020)
   // ]
   ```
  */
  func unique<T: Hashable>(_ map: (Element) -> T)  -> [Element] {
    var set = Set<T>()
    var arrayOrdered = [Element]()
    for value in self {
      if !set.contains(map(value)) {
        set.insert(map(value))
        arrayOrdered.append(value)
      }
    }
    
    return arrayOrdered
  }
}

public extension Array where Element: Hashable {
  /**
   Get unique elements from an array
   
   ```swift
   let numbers = [1, 2, 2, 3, 5, 5, 4]
   let uniqueNumbers = numbers.uniques // [1, 2, 3, 5, 4]
   ```
   */
  var uniques: Array {
    var buffer = Array()
    var added = Set<Element>()
    for elem in self {
      if !added.contains(elem) {
        buffer.append(elem)
        added.insert(elem)
      }
    }
    return buffer
  }
}

public extension RangeReplaceableCollection where Indices: Equatable {
  /** 
   Rearranges an element within a collection by moving it from one index to another.
   - Parameter from: The index of the element to move.
   - Parameter to: The index where the element should be moved.
   
   This function is useful when you need to change the position of an element in a collection, such as moving an item in an array from one position to another.
   
   ```swift
   var numbers = [1, 2, 3, 4, 5]
   numbers.rearrange(from: 2, to: 0)
   // numbers will be [3, 1, 2, 4, 5]
   ```
   */
  mutating func rearrange(from: Index, to: Index) {
    precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indices")
    insert(remove(at: from), at: to)
  }
}
