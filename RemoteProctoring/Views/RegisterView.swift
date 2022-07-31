//
//  RegisterView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 30/06/2022.
//

import SwiftUI
import Navajo_Swift

struct RegisterView: View {
    let passwordValdator = PasswordValidator(rules: [LengthRule(min: 8, max: 200), RequiredCharacterRule(preset: .lowercaseCharacter),
                                                     RequiredCharacterRule(preset: .uppercaseCharacter), RequiredCharacterRule(preset: .decimalDigitCharacter),
                                                     RequiredCharacterRule(preset: .symbolCharacter)])
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordStrength: PasswordStrength? = nil
    @State private var passwordStrengthProgress: Float = 0.0
    @State private var passwordStrengthColor: Color = .red
    @State private var repeatPassword: String = ""
    @State private var prefix: String = ""
    @State private var givenName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var emailAddress: String = ""
    @State private var showPasswordRules: Bool = false
    @State private var passwordsMatch: Bool = true
    @State private var usernameTaken: Bool = false
    @State private var passwordValidationErrors: [String] = []
#if os(macOS)
    @Binding var showRegisterView: Bool
#endif
    #if os(macOS)
    init(showRegisterView: Binding<Bool>) {
        self._showRegisterView = showRegisterView
    }
    #endif
    var body: some View {
        GeometryReader { g in
            HStack {
                Spacer()
                VStack {
                    VStack {
#if os(macOS)
                        HStack {
                            Button {
                                withAnimation {
                                    showRegisterView = false
                                }
                            } label: {
                                Image(systemName: "chevron.backward.circle")
                                    .imageScale(.large)
                            }
                            Spacer()
                        }
#endif
                        Text("New Registeration")
                            .font(.title)
                            .padding(.top)
                        Divider()
                        TextField("Username", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
#if os(iOS)
                            .textInputAutocapitalization(.never)
#endif
                        if usernameTaken {
                            Label {
                                Text("Username already taken. Please try another one")
                            } icon: {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .symbolRenderingMode(.multicolor)
                            }
                            .foregroundStyle(.secondary)
                            .controlSize(.small)
                            .tint(.red)
                        }
                    }
                    .frame(maxWidth: g.size.width * 0.45)
                    ZStack {
                        VStack {
                            SecureField("Password",text: $password)
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)
#if os(iOS)
                                .textInputAutocapitalization(.never)
#endif
                                .onChange(of:password){ newPassword in
                                    passwordStrength = Navajo.strength(ofPassword: newPassword)
                                    withAnimation {
                                        switch(passwordStrength) {
                                        case .veryWeak:
                                            passwordStrengthProgress = 0
                                            passwordStrengthColor = .red
                                        case .weak:
                                            passwordStrengthProgress = 20
                                            passwordStrengthColor = .red
                                        case .reasonable:
                                            passwordStrengthProgress = 40
                                            passwordStrengthColor = .yellow
                                        case .strong:
                                            passwordStrengthProgress = 60
                                            passwordStrengthColor = .green
                                        case .veryStrong:
                                            passwordStrengthProgress = 80
                                            passwordStrengthColor = .green
                                        default:
                                            passwordStrengthProgress = 0
                                        }
                                    }
                                }
                                .overlay {
                                    HStack {
                                        Spacer()
                                        if password.isEmpty {
                                            Image(systemName:"info.circle")
                                                .padding(.trailing)
                                                .onTapGesture {
                                                    withAnimation {
                                                        showPasswordRules.toggle()
                                                    }
                                                }
                                                .symbolRenderingMode(.multicolor)
                                        }
                                    }
                                }
                                .frame(maxWidth: g.size.width * 0.45)
                        }
                        
                        if showPasswordRules {
                            Label {
                                Text("Password must contain atleast one uppercase letter, one lowercase letter, one digit and one symbol (i.e. %, @, $ etc.).")
                                    .lineLimit(4)
                                    .allowsTightening(true)
                                    .font(.body)
                            } icon: {
                                Image(systemName: "x.circle.fill")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, .red)
                                    .imageScale(.small)
                                    .onTapGesture {
                                        withAnimation {
                                            showPasswordRules.toggle()
                                        }
                                    }
                            }
                            .background(.white)
                            .frame(maxWidth: g.size.width * 0.50)
                        }
                    }
                    ProgressView(value: passwordStrengthProgress, total: 80) {
                        Text("Password Strength")
                            .font(Font.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .tint(passwordStrengthColor)
                    .frame(maxWidth: g.size.width * 0.45)
                    if !passwordValidationErrors.isEmpty {
                        VStack(alignment: .leading) {
                            ForEach(passwordValidationErrors, id: \.self) { validationError in
                                Text(validationError)
                                    .dynamicTypeSize(.small)
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(maxWidth: g.size.width * 0.45)
                    }
                    VStack {
                        SecureField("Repeat Password",text: $repeatPassword)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
#if os(iOS)
                            .textInputAutocapitalization(.never)
#endif
                            .onChange(of:repeatPassword) { newRepeatPassword in
                                withAnimation {
                                    if newRepeatPassword != password {
                                        passwordsMatch = false
                                    }
                                    else {
                                        passwordsMatch = true
                                    }
                                }
                            }
                        if !passwordsMatch {
                            Text("Password do not Match.")
                                .foregroundColor(.red)
                        }
                        TextField("Prefix", text: $prefix)
                            .textFieldStyle(.roundedBorder)
                        TextField("Given Name",text: $givenName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Middle Name",text: $middleName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name",text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Email Address",text: $emailAddress)
                            .textFieldStyle(.roundedBorder)
                    }
                    .frame(maxWidth: g.size.width * 0.45)
                    Button(action: handleRegisteration) {
                        Text("Register")
                            .font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                Spacer()
            }
        }
    }
    
    func handleRegisteration() {
        passwordValidationErrors.removeAll()
        if let failingRules = self.passwordValdator.validate(password) {
            for failingRule in failingRules {
                passwordValidationErrors.append(failingRule.localizedErrorDescription)
            }
        } else {
            
        }
        
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(macOS)
        RegisterView(showRegisterView: .constant(false))
        #else
        RegisterView()
        #endif
    }
}
#endif
