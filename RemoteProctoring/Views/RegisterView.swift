//
//  RegisterView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 30/06/2022.
//

import SwiftUI
import Combine
import Navajo_Swift

struct RegisterView: View {
    @EnvironmentObject private var store: Store;
    let passwordValdator = PasswordValidator(rules: [LengthRule(min: 8, max: 200), RequiredCharacterRule(preset: .lowercaseCharacter),
                                                     RequiredCharacterRule(preset: .uppercaseCharacter), RequiredCharacterRule(preset: .decimalDigitCharacter),
                                                     RequiredCharacterRule(preset: .symbolCharacter)])
    private var role: Role
    // group may not need to be state
    @State private var group: Group
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordStrength: PasswordStrength? = nil
    @State private var passwordStrengthProgress: Float = 0.0
    @State private var passwordStrengthColor: Color = .red
    @State private var repeatPassword: String = ""
    @State private var givenName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var emailAddress: String = ""
    @State private var organization: String = ""
    @State private var showPasswordRules: Bool = false
    @State private var passwordsMatch: Bool = true
    @State private var usernameTaken: Bool = false
    @State private var passwordValidationErrors: [String] = []
    init(for role: Role) {
        self.role = role
    }
    var body: some View {
        GeometryReader { g in
            HStack {
                Spacer()
                VStack {
                    Group {
                        Text("New Registeration")
                            .font(.title)
                        Divider()
                        TextField("Username", text: $username)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
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
                        Group {
                            SecureField("Password",text: $password)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .onReceive(Just(password)){ newPassword in
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
                            HStack {
                                Spacer()
                                if password.isEmpty {
                                    Image(systemName:"info.circle")
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
                        if showPasswordRules {
                            Label {
                                Text("Password must contain atleast one uppercase letter, one lowercase letter, one digit and one symbol (i.e. %, @, $ etc.).")
                                    .lineLimit(4)
                                    .allowsTightening(true)
                                    .font(.body)
                            } icon: {
                                Image(systemName: "xmark")
                                    .symbolRenderingMode(.multicolor)
                                    .imageScale(.small)
                                    .onTapGesture {
                                        withAnimation {
                                            showPasswordRules.toggle()
                                        }
                                    }
                            }
                            .background(.white)
                            .frame(maxWidth: g.size.width * 0.70)
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
                    Group {
                        SecureField("Repeat Password",text: $repeatPassword)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .onReceive(Just(repeatPassword)) { newRepeatPassword in
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
                        TextField("Given Name",text: $givenName)
                        TextField("Middle Name",text: $middleName)
                        TextField("Last Name",text: $lastName)
                        TextField("Email Address",text: $emailAddress)
                        if role == .administrator {
                            TextField("Organization",text: $organization)
                        }
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(for: .administrator)
    }
}
