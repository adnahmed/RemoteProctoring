//
//  RegisterView.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 30/06/2022.
//

import Navajo_Swift
import Neumorphic
import SwiftUI

struct RegisterView: View {
    let passwordValdator = PasswordValidator(rules: [LengthRule(min: 8, max: 200), RequiredCharacterRule(preset: .lowercaseCharacter),
                                                     RequiredCharacterRule(preset: .uppercaseCharacter), RequiredCharacterRule(preset: .decimalDigitCharacter),
                                                     RequiredCharacterRule(preset: .symbolCharacter)])
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
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
    var body: some View {
        VStack {
            Label {
                Text("New Registeration")
                    .fontWeight(.thin)
                    .kerning(2.0)
                    .font(.largeTitle)
                    .padding([.top, .leading])
            } icon: {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 100, maxWidth: 100)
                    .background(RoundedRectangle(cornerRadius: 24.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            }
            Divider()
                .padding(.bottom)
            Picker(selection: $role, label: Text("Role")) {
                ForEach(Role.allCases, id: \.self) { role in
                    Text(role.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            Form {
                Section(header: Text("Authentication").foregroundStyle(.secondary)) {
                    TextField("Username", text: $username)
                        .authTextField()
                        .focused($focusedField, equals: .usernameField)
                    SecureField("Password", text: $password)
                        .authTextField()
                        .focused($focusedField, equals: .passwordField)
                        .onChange(of: password) { newPassword in
                            onPasswordChange(newPassword)
                        }
                        .overlay {
                            HStack {
                                Spacer()
                                if password.isEmpty {
                                    InfoButtonView(showInfo: $showPasswordRules)
                                        .padding(.trailing)
                                        .frame(minHeight: 20)
                                }
                                else {
                                    TickCross(value: $passwordValid)
                                        .padding(.trailing)
                                        .frame(minHeight: 20)
                                }
                            }
                        }
                    if showPasswordRules {
                        InfoView(
                            InfoText: .constant("Must contain atleast one uppercase letter, one lowercase letter, one digit and one symbol (i.e. %, @, $ etc.)."),
                            showInfo: $showPasswordRules)
                            .frame(minHeight: 50)
                    }
                    ProgressView(value: passwordStrengthProgress, total: 80) {
                        Text("Password Strength")
                            .foregroundStyle(.secondary)
                            .font(.caption2)
                    }
                    .tint(passwordStrengthColor)
                    SecureField("Repeat Password", text: $repeatPassword)
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
                }
                Section(header: Text("Information").foregroundStyle(.secondary)) {
                    TextField("Prefix", text: $prefix)
                        .textFieldStyle(.roundedBorder)
                    TextField("Given Name", text: $givenName)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .givenNameField)
                    Group {
                        TextField("Middle Name", text: $middleName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Email Address", text: $emailAddress)
                            .authTextField()
                            .foregroundColor(!emailAddressValid && !emailAddress.isEmpty ? .red : colorScheme == .light ? .black : .white)
                            .focused($focusedField, equals: .emailAddressField)
                            .onChange(of: emailAddress) { newEmailAddress in
                                validateEmail(newEmailAddress)
                            }
                        TextField("Organization", text: $organization)
                            .focused($focusedField, equals: .organizationField)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            Button(action: handleRegisteration) {
                Text("Register")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous).fill(Color.Neumorphic.main).softOuterShadow())
            .padding()
            if registerPressed {
                ProgressView()
                    .controlSize(.large)
                    .padding()
            }
            if recievedError {
                ErrorMessagesView(errorMessages: $errorMessages, recievedError: $recievedError)
            }
        }
        .frame(minWidth: 640, maxWidth: 640, minHeight: 750, maxHeight: 900)
        .onAppear {
            focusedField = .usernameField
        }
        .padding()
        .eraseToAnyView()
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
            }
            else {
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
        
        let inputUser = UserRegisterationInput(
            username: username,
            password: password,
            role: role,
            prefix: prefix,
            givenName: givenName,
            middleName: middleName,
            lastName: lastName,
            email: emailAddress,
            organization: organization)
        
        ApiClient.shared.client.perform(
            mutation: RegisterMutation(user: inputUser))
        { res in
            registerPressed = false
            switch res {
            case .success(let gqRes):
                if let errors = gqRes.errors {
                    errorMessages.append("Error occurred while connecting to server, Please try again.")
#if DEBUG
                    for error in errors {
                        if let failureReason = error.failureReason {
                            errorMessages.append(failureReason)
                        }
                        else {
                            errorMessages.append(error.description)
                        }
                    }
#endif
                    withAnimation {
                        recievedError = true
                    }
                }
                if let data = gqRes.data {
                    guard let queryResponse = data.register.queryResponse else {
                        #if DEBUG
                        errorMessages.append(contentsOf: data.register.resultMap.values.compactMap {$0.debugDescription})
                        #endif
                        errorMessages.append("Unknown error occurred, Please try again.")
                        withAnimation {
                            recievedError = true
                        }
                        return
                    }
                    switch queryResponse.code {
                    case 200:
                        guard let recievedUser = data.register.user else {
                            errorMessages.append("Uknown error occured, Please try again.")
                            break
                        }
                        user.data.raw = recievedUser.fragments.userDetails
                        withAnimation {
                            SecureStore.shared.token = data.register.token
                        }
                        return
                    case 400:
                        errorMessages.append(contentsOf: queryResponse.message.split(separator: "\n").map { substr in String(substr) })
                    case 500:
                        errorMessages.append("Server error occurred. Please try again later.")
                    default:
                        errorMessages.append(queryResponse.message)
                    }
                    withAnimation {
                        recievedError = true
                    }
                }
            case .failure(let error):
                errorMessages.append("Error occurred while connecting to server, Please try again.")
#if DEBUG
                errorMessages.append(error.localizedDescription)
#endif
                withAnimation {
                    recievedError = true
                }
            }
        }
    }
    
    func calculatePasswordStrengthProgress(password: String) {
        let passwordStrength = Navajo.strength(ofPassword: password)
        withAnimation {
            switch passwordStrength {
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
    
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
}

#if DEBUG
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
#endif
