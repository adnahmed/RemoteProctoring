//
//  RegisterViewSupporting.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 01/08/2022.
//

import SwiftUI
import RegexBuilder

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
    }
}

struct TitleView: View {
    @Binding var label: String
    var body: some View {
        Text(label)
            .fontWeight(.thin)
            .kerning(2.0)
            .font(.largeTitle)
            .padding(.top)
        Divider()
            .padding(.bottom)
        
    }
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
    }
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
        
    }
}

enum RegisterFormField: Hashable {
    case emailAddressField, organizationField, passwordField, repeatPasswordField, givenNameField, usernameField
}

let emailPattern = Regex {
    Capture {
        ZeroOrMore {
            OneOrMore(.word)
            "."
        }
        OneOrMore(.word)
    }
    "@"
    Capture {
        OneOrMore(.word)
        OneOrMore {
            "."
            OneOrMore(.word)
        }
    }
}
