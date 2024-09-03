//
//  Locale.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 03/09/2024.
//

import Foundation

public typealias CountryInfo = (countryCode: String, localizedName: String)

public extension Locale {
  // English-speaking locales
  static let enUS = Locale(identifier: "en_US") // English (United States)
  static let enGB = Locale(identifier: "en_GB") // English (United Kingdom)
  static let enSG = Locale(identifier: "en_SG") // English (Singapore)
  static let enCA = Locale(identifier: "en_CA") // English (Canada)
  static let enAU = Locale(identifier: "en_AU") // English (Australia)
  static let enIN = Locale(identifier: "en_IN") // English (India)
  static let enNZ = Locale(identifier: "en_NZ") // English (New Zealand)
  static let enZA = Locale(identifier: "en_ZA") // English (South Africa)
  static let enIE = Locale(identifier: "en_IE") // English (Ireland)
  static let enPH = Locale(identifier: "en_PH") // English (Philippines)
  static let enNG = Locale(identifier: "en_NG") // English (Nigeria)
  static let enPK = Locale(identifier: "en_PK") // English (Pakistan)
  static let enKE = Locale(identifier: "en_KE") // English (Kenya)
  static let enGH = Locale(identifier: "en_GH") // English (Ghana)
  
  // Asian locales
  static let jaJP = Locale(identifier: "ja_JP") // Japanese (Japan)
  static let zhCN = Locale(identifier: "zh_CN") // Chinese (Simplified, China)
  
  // French-speaking locales
  static let frFR = Locale(identifier: "fr_FR") // French (France)
  static let frCA = Locale(identifier: "fr_CA") // French (Canada)
  static let frBE = Locale(identifier: "fr_BE") // French (Belgium)
  static let frCH = Locale(identifier: "fr_CH") // French (Switzerland)
  static let frLU = Locale(identifier: "fr_LU") // French (Luxembourg)
  
  // German-speaking locales
  static let deDE = Locale(identifier: "de_DE") // German (Germany)
  static let deAT = Locale(identifier: "de_AT") // German (Austria)
  static let deCH = Locale(identifier: "de_CH") // German (Switzerland)
  static let deLI = Locale(identifier: "de_LI") // German (Liechtenstein)
  
  // Spanish-speaking locales
  static let esES = Locale(identifier: "es_ES") // Spanish (Spain)
  static let esMX = Locale(identifier: "es_MX") // Spanish (Mexico)
  static let esAR = Locale(identifier: "es_AR") // Spanish (Argentina)
  static let esCO = Locale(identifier: "es_CO") // Spanish (Colombia)
  static let esCL = Locale(identifier: "es_CL") // Spanish (Chile)
  static let esPE = Locale(identifier: "es_PE") // Spanish (Peru)
  static let esVE = Locale(identifier: "es_VE") // Spanish (Venezuela)
  
  // Italian-speaking locales
  static let itIT = Locale(identifier: "it_IT") // Italian (Italy)
  static let itCH = Locale(identifier: "it_CH") // Italian (Switzerland)
  
  // Portuguese-speaking locales
  static let ptBR = Locale(identifier: "pt_BR") // Portuguese (Brazil)
  static let ptPT = Locale(identifier: "pt_PT") // Portuguese (Portugal)
  
  // Dutch-speaking locales
  static let nlNL = Locale(identifier: "nl_NL") // Dutch (Netherlands)
  static let nlBE = Locale(identifier: "nl_BE") // Dutch (Belgium)
  
  // Russian-speaking locales
  static let ruRU = Locale(identifier: "ru_RU") // Russian (Russia)
  static let ruBY = Locale(identifier: "ru_BY") // Russian (Belarus)
  
  /// Gets a list of country codes and the localised name for each country using the current Locale.
  ///
  /// - Returns: A list of country code/localized country name pairs.
  var countries: [CountryInfo] {
    return Locale.isoRegionCodes.compactMap { c in
      return (c, Locale.current.localizedString(forRegionCode: c) ?? "")
    }
  }
}
