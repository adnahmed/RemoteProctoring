//
//  File.swift
//  
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import Navajo_Swift
public let passwordValdator = PasswordValidator(rules: [LengthRule(min: 8, max: 200), RequiredCharacterRule(preset: .lowercaseCharacter),
                                                     RequiredCharacterRule(preset: .uppercaseCharacter), RequiredCharacterRule(preset: .decimalDigitCharacter),
                                                     RequiredCharacterRule(preset: .symbolCharacter)])
