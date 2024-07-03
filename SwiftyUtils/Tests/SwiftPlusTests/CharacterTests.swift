//
//  CharacterTests.swift
//
//
//  Created by Kyaw Zay Ya Lin Tun on 03/07/2024.
//

import Testing
import Foundation
import SwiftPlus

struct CharacterTests {

    @Test func isEmoji() async throws {
      let emojiChar: Character = "😂"
      #expect(emojiChar.isEmoji == true)
      
      let nonEmojiChar: Character = "a"
      #expect(nonEmojiChar.isEmoji == false)
    }

  @Test func convertCharacterToString() async throws {
    let text = "Hello, World!"
    let strs = text.map { $0.asString() }
    #expect(strs == ["H", "e", "l", "l", "o", ",", " ", "W", "o", "r", "l", "d", "!"])
  }
}
