//
//  RegisterView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 30/06/2022.
//

import SwiftUI
import Navajo_Swift


struct RegisterView: View {
    // TODO: Add Beautiful Animation Behind Register Form in ZStack
    let passwordValdator = PasswordValidator(rules: [LengthRule(min: 8, max: 200), RequiredCharacterRule(preset: .lowercaseCharacter),
                                                     RequiredCharacterRule(preset: .uppercaseCharacter), RequiredCharacterRule(preset: .decimalDigitCharacter),
                                                     RequiredCharacterRule(preset: .symbolCharacter)])
    
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var passwordStrength: PasswordStrength? = nil
    @State private var passwordStrengthProgress: Float = 0.0
    @State private var passwordStrengthColor: Color = .red
    @State private var prefix: String = ""
    @State private var givenName: String = ""
    @State private var middleName: String = ""
    @State private var lastName: String = ""
    @State private var emailAddress: String = ""
    @State private var organization: String = ""
    @State private var showPasswordRules: Bool = false
    @State private var passwordValid: Bool = false
    @State private var passwordsMatch: Bool = true
    @State private var usernameTaken: Bool = false
    @State private var role: Role = .administrator
    @State private var registerPressed: Bool = false
    @State private var recievedError: Bool = false
    @State private var emailAddressValid: Bool = false
    @State private var errorMessages: [String] = []
    @EnvironmentObject private var user: User
    @FocusState private var focusedField: RegisterFormField?
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
            VStack {
#if os(macOS)
                macOSBackButtonView(showCurrentView: $showRegisterView)
#endif
                TitleView(label: .constant("New Registeration"))
                Picker(selection: $role, label: Text("Role")) {
                    ForEach(Role.allCases, id: \.self) { role in
                        Text(role.rawValue.capitalized)
                    }
                }
                
                Form {
                    TextField("*Username", text: $username)
                        .authTextField()
                        .focused($focusedField, equals: .usernameField)
                    SecureField("*Password",text: $password)
                        .authTextField()
                        .focused($focusedField, equals: .passwordField)
                        .onChange(of: password){ newPassword in
                            onPasswordChange(newPassword)
                        }
                        .overlay {
                            HStack {
                                Spacer()
                                if password.isEmpty {
                                    InfoButtonView(showInfo: $showPasswordRules)
                                        .padding(.trailing)
                                }
                                else {
                                    TickCross(value: $passwordValid)
                                        .padding(.trailing)
                                }
                            }
                        }
                    if showPasswordRules {
                        InfoView(
                            InfoText: .constant("Password must contain atleast one uppercase letter, one lowercase letter, one digit and one symbol (i.e. %, @, $ etc.)."),
                            showInfo: $showPasswordRules)
                    }
                    ProgressView(value: passwordStrengthProgress, total: 80) {
                        Text("Password Strength")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .tint(passwordStrengthColor)
                    VStack {
                        SecureField("*Repeat Password",text: $repeatPassword)
                            .authTextField()
                            .focused($focusedField, equals: .repeatPasswordField)
                            .overlay {
                                if !repeatPassword.isEmpty {
                                    HStack {
                                        Spacer()
                                        TickCross(value: $passwordsMatch)
                                            .padding(.trailing)
                                    }
                                }
                            }
                            .onChange(of: repeatPassword) { newRepeatPassword in
                                onRepeatPasswordChange(newRepeatPassword)
                            }
                        
                        TextField("Prefix", text: $prefix)
                            .textFieldStyle(.roundedBorder)
                        TextField("*Given Name",text: $givenName)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .givenNameField )
                        TextField("Middle Name",text: $middleName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name",text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        TextField("*Email Address",text: $emailAddress)
                            .onChange(of: emailAddress) { newEmailAddress in
                                validateEmail(newEmailAddress)
                            }
                            .authTextField()
                            .foregroundColor(emailAddressValid ? .black : .red)
                            .focused($focusedField, equals: .emailAddressField )
                        TextField("*Organization",text: $organization)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .organizationField )
                        Text("Note: Fields marked with * must be provided.")
                            .foregroundStyle(.secondary)
                            .font(.caption2)
                    }
                }
                if registerPressed {
                    ProgressView()
                        .controlSize(.large)
                        .padding()
                }
                Button(action: handleRegisteration) {
                    Text("Register")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                if recievedError {
                    ForEach(errorMessages, id: \.self) { error in
                        AuthenticationErrorView(message: error, animateWhen: $recievedError)
                    }
                }
            }
            .background(.white)
            .onAppear {
                focusedField = .usernameField
            }
        }
    }
    
    func validateEmail(_ emailAddress: String) {
        withAnimation {
            #if os(iOS)
            if let match = emailAddress.firstMatch(of: emailPattern) {
                let (wholeMatch, _, _) = match.output
                self.emailAddress = String(wholeMatch)
                self.emailAddressValid = true
            }
            else {
                self.emailAddressValid = false
            }
            #else
            if emailPattern.firstMatch(in: emailAddress, options: [], range: NSRange(location: 0, length: emailAddress.count)) != nil {
                // TODO: Use matched value from NSTextCheckingResult
                self.emailAddressValid = true
            }
            else {
                self.emailAddressValid = false
            }
            #endif
        }
    }
    
    func onPasswordChange(_ newPassword: String) {
        withAnimation {
            if self.passwordValdator.validate(newPassword) != nil {
                passwordValid = false
            } else {
                passwordValid = true
            }
        }
        calculatePasswordStrengthProgress(password: newPassword)
        
    }
    func onRepeatPasswordChange(_ newRepeatPassword: String) {
        withAnimation {
            if password != newRepeatPassword {
                passwordsMatch = false
            }
            else {
                passwordsMatch = true
            }
        }
    }
    func handleRegisteration() {
        guard !username.isEmpty else {
            focusedField = .usernameField
            return
        }
        guard !password.isEmpty else {
            focusedField = .passwordField
            return
        }
        guard !repeatPassword.isEmpty else {
            focusedField = .repeatPasswordField
            return
        }
        guard !givenName.isEmpty else {
            focusedField = .givenNameField
            return
        }
        guard !emailAddress.isEmpty else {
            focusedField = .emailAddressField
            return
        }
        guard !organization.isEmpty else {
            focusedField = .organizationField
            return
        }
        guard passwordValid else {
            focusedField = .passwordField
            return
        }
        guard emailAddressValid else {
            focusedField = .emailAddressField
            return
        }
        withAnimation {
            registerPressed = true
            recievedError = false
        }
        
        errorMessages.removeAll()
        
        let inputUser: UserRegisterationInput = UserRegisterationInput(
            username: username,
            password: password,
            role: role.rawValue,
            prefix: prefix,
            givenName: givenName,
            middleName: middleName,
            lastName: lastName,
            email: emailAddress,
            organization: organization
        )
        
        Network.shared.client.perform(
            mutation: RegisterMutation(user: inputUser)) { res in
                switch res {
                case .success (let gqRes):
                    if let  errors = gqRes.errors {
                        for error in errors {
                            if let failureReason = error.failureReason {
                                errorMessages.append(failureReason)
                            }
                            else {
                                errorMessages.append(error.description)
                            }
                        }
                        withAnimation {
                            recievedError = true
                        }
                    }
                    if let data = gqRes.data {
                        Network.shared.token = data.register.token
                        if data.register.code == 200 {
                            user.userDetails = data.register.user?.fragments.userDetails
                            withAnimation {
                                user.isLoggedIn.toggle()
                            }
                        }
                        else {
                            errorMessages.append(data.register.message)
                            withAnimation {
                                recievedError = true
                            }
                        }
                    }
                case .failure(let error):
                    errorMessages.append(error.localizedDescription)
                    withAnimation {
                        recievedError = true
                    }
                }
                registerPressed = false
            }
    }
    
    func calculatePasswordStrengthProgress(password: String) {
        let passwordStrength = Navajo.strength(ofPassword: password)
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
            }
        }
    }
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
#if os(macOS)
        RegisterView(showRegisterView: .constant(true))
#else
        RegisterView()
#endif
    }
}
#endif
