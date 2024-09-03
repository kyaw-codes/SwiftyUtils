//
//  TimeZone.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 03/09/2024.
//

import Foundation

public extension TimeZone {
    // English-speaking countries
    static let us   = TimeZone(abbreviation: "EST")   // United States (Eastern Standard Time)
    static let gb   = TimeZone(abbreviation: "GMT")   // United Kingdom (Greenwich Mean Time)
    static let sg   = TimeZone(abbreviation: "SGT")   // Singapore (Singapore Time)
    static let ca   = TimeZone(abbreviation: "EST")   // Canada (Eastern Standard Time)
    static let au   = TimeZone(abbreviation: "AEST")  // Australia (Australian Eastern Standard Time)
    static let `in` = TimeZone(abbreviation: "IST") // India (India Standard Time)
    static let nz   = TimeZone(abbreviation: "NZST")  // New Zealand (New Zealand Standard Time)
    static let za   = TimeZone(abbreviation: "SAST")  // South Africa (South Africa Standard Time)
    static let ie   = TimeZone(abbreviation: "IST")   // Ireland (Irish Standard Time)
    static let ph   = TimeZone(abbreviation: "PHT")   // Philippines (Philippine Time)
    static let ng   = TimeZone(abbreviation: "WAT")   // Nigeria (West Africa Time)
    static let pk   = TimeZone(abbreviation: "PKT")   // Pakistan (Pakistan Standard Time)
    static let ke   = TimeZone(abbreviation: "EAT")   // Kenya (East Africa Time)
    static let gh   = TimeZone(abbreviation: "GMT")   // Ghana (Greenwich Mean Time)

    // Asian countries
    static let jp = TimeZone(abbreviation: "JST")   // Japan (Japan Standard Time)
    static let cn = TimeZone(abbreviation: "CST")   // China (China Standard Time)

    // French-speaking countries
    static let fr   = TimeZone(abbreviation: "CET")   // France (Central European Time)
    static let caFR = TimeZone(abbreviation: "EST") // Canada (French-speaking, Eastern Standard Time)
    static let be   = TimeZone(abbreviation: "CET")   // Belgium (Central European Time)
    static let chFR = TimeZone(abbreviation: "CET") // Switzerland (French-speaking, Central European Time)
    static let lu   = TimeZone(abbreviation: "CET")   // Luxembourg (Central European Time)

    // German-speaking countries
    static let de = TimeZone(abbreviation: "CET")   // Germany (Central European Time)
    static let at = TimeZone(abbreviation: "CET")   // Austria (Central European Time)
    static let ch = TimeZone(abbreviation: "CET")   // Switzerland (German-speaking, Central European Time)
    static let li = TimeZone(abbreviation: "CET")   // Liechtenstein (Central European Time)

    // Spanish-speaking countries
    static let es = TimeZone(abbreviation: "CET")   // Spain (Central European Time)
    static let mx = TimeZone(abbreviation: "CST")   // Mexico (Central Standard Time)
    static let ar = TimeZone(abbreviation: "ART")   // Argentina (Argentina Time)
    static let co = TimeZone(abbreviation: "COT")   // Colombia (Colombia Time)
    static let cl = TimeZone(abbreviation: "CLT")   // Chile (Chile Standard Time)
    static let pe = TimeZone(abbreviation: "PET")   // Peru (Peru Time)
    static let ve = TimeZone(abbreviation: "VET")   // Venezuela (Venezuela Time)

    // Italian-speaking countries
    static let it   = TimeZone(abbreviation: "CET")   // Italy (Central European Time)
    static let chIT = TimeZone(abbreviation: "CET") // Switzerland (Italian-speaking, Central European Time)

    // Portuguese-speaking countries
    static let br = TimeZone(abbreviation: "BRT")   // Brazil (Brasilia Time)
    static let pt = TimeZone(abbreviation: "WET")   // Portugal (Western European Time)

    // Dutch-speaking countries
    static let nl   = TimeZone(abbreviation: "CET")   // Netherlands (Central European Time)
    static let beNL = TimeZone(abbreviation: "CET") // Belgium (Dutch-speaking, Central European Time)

    // Russian-speaking countries
    static let ru = TimeZone(abbreviation: "MSK")   // Russia (Moscow Standard Time)
    static let by = TimeZone(abbreviation: "MSK")   // Belarus (Moscow Standard Time)
}
