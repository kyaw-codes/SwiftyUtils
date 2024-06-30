//
//  Test.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 30/06/2024.
//

import SwiftPlus
import Testing

struct ArrayTests {
  
  @Test("isNotEmpty", arguments: [
    [String](),
    ["a", "b", "c"]
  ])
  func isNotEmpty(arr: [String]) async throws {
    #expect(arr.isNotEmpty == !arr.isEmpty)
  }
  
  @Test("Convert array into dictionary with indices")
  func toDictionary() async throws {
    #expect([String]().toDictionary() == [:])
    #expect(["a", "b", "c"].toDictionary() == ["0": "a", "1": "b", "2": "c"])
  }
  
  @Test("mutateInPlace")
  func mutateInPlace() async throws {
    struct Counter: Equatable {
      var count: Int
    }
    
    var counters = (1 ... 10).map { Counter(count: $0) }
    #expect(
      counters == [
        Counter(count: 1),
        Counter(count: 2),
        .init(count: 3),
        .init(count: 4),
        .init(count: 5),
        .init(count: 6),
        .init(count: 7),
        .init(count: 8),
        .init(count: 9),
        .init(count: 10)
      ]
    )
    
    counters.mutateInPlace { $0.count += 1 }
    #expect(
      counters == [
        Counter(count: 2),
        .init(count: 3),
        .init(count: 4),
        .init(count: 5),
        .init(count: 6),
        .init(count: 7),
        .init(count: 8),
        .init(count: 9),
        .init(count: 10),
        .init(count: 11)
      ]
    )
  }
  
  @Test("custom subscript safe retrieval")
  func customSubscript() async throws {
    let arr = ["a", "b", "c"]
    #expect(arr[safe: 0] == "a")
    #expect(arr[safe: 3] == nil)
  }
  
  @Test("Unique")
  func unique() async throws {
    struct Person: Equatable {
        let firstName: String
        let lastName: String
    }
    
    let people = [
        Person(firstName: "John", lastName: "Doe"),
        Person(firstName: "Jane", lastName: "Smith"),
        Person(firstName: "Alice", lastName: "Johnson"),
        Person(firstName: "Bob", lastName: "Brown"),
        Person(firstName: "Anna", lastName: "Smith")
    ]
    
    let uniquePeopleByLastName = people.unique(\.lastName)
    
    #expect(
      uniquePeopleByLastName == [
        Person(firstName: "John", lastName: "Doe"),
        Person(firstName: "Jane", lastName: "Smith"),
        Person(firstName: "Alice", lastName: "Johnson"),
        Person(firstName: "Bob", lastName: "Brown")
      ]
    )
    
    let numbers = [3, 1, 1, 2, 7, 4, 7]
    #expect(numbers.unique(identityFunc) == [3, 1, 2, 7, 4])
    #expect(numbers.uniques == [3, 1, 2, 7, 4])
  }
  
  @Test("Rearrange")
  func rearrange() async throws {
    var numbers = [1, 2, 3, 4, 5]
    numbers.rearrange(from: 3, to: 0)
    #expect(numbers == [4, 1, 2, 3, 5])
  }
  
  @Test("Random pick")
  func randomPick() async throws {
    let numbers = [1, 2, 3, 4, 5]
    #expect(numbers.random(amount: 3).count == 3)
  }
}
