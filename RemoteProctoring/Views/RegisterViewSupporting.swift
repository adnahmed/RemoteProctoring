//
//  RegisterViewSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 01/08/2022.
//

import SwiftUI
import RegexBuilder
#if os(iOS)
let word = OneOrMore(.word)
let emailPattern = Regex {
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
let emailPattern = {
    do {
        return try NSRegularExpression(pattern: "([^@]+)@([^@]+.[^@]+)", options: .caseInsensitive)
    } catch {
      return NSRegularExpression()
    }
}()
#endif

struct macOSBackButtonView: View {
    @Binding var showCurrentView: Bool
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    showCurrentView = false
                }
            } label: {
                Image(systemName: "chevron.backward.circle")
                    .imageScale(.large)
            }
            Spacer()
        }
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct InfoButtonView: View {
    @Binding var showInfo: Bool
    var body: some View {
        Image(systemName:"info.circle")
            .onTapGesture {
                withAnimation {
                    showInfo.toggle()
                }
            }
            .symbolRenderingMode(.multicolor)
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}
struct TickCross: View {
    @Binding var value: Bool
    var body: some View {
        if value {
            Image(systemName: "checkmark")
                .symbolVariant(.circle)
                .foregroundStyle(.green)
                .symbolRenderingMode(.multicolor)
        }
        else {
            Image(systemName: "x")
                .foregroundColor(.red)
                .symbolVariant(.circle)
                .symbolRenderingMode(.multicolor)
        }
    }
}
struct InfoView: View {
    @Binding var InfoText: String
    var showInfo: Binding<Bool>?
    var body: some View {
        Label {
            Text(InfoText)
                .lineLimit(4)
                .allowsTightening(true)
                .font(.body)
        } icon: {
            if showInfo != nil {
                Image(systemName: "x.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .red)
                    .imageScale(.large)
                    .onTapGesture {
                        withAnimation {
                            showInfo?.wrappedValue.toggle()
                        }
                    }
            }
        }
        
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

enum RegisterFormField: Hashable {
    case emailAddressField, organizationField, passwordField, repeatPasswordField, givenNameField, usernameField
}

