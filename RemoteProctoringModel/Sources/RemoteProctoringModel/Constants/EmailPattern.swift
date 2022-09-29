//
//  EmailPattern.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 29/09/2022.
//

import Foundation

#if os(iOS)
let word = OneOrMore(.word)
public let emailPattern = Regex {
    Capture {
        ZeroOrMore {
            word
            "."
        }
        word
    }
    "@"
    Capture {
        word
        OneOrMore {
            "."
            word
        }
    }
}
#else
public let emailPattern = {
    do {
        return try NSRegularExpression(pattern: "([^@]+)@([^@]+.[^@]+)", options: .caseInsensitive)
    } catch {
      return NSRegularExpression()
    }
}()
#endif
