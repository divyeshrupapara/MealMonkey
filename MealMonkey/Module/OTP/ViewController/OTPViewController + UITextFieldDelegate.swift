import OTPFieldView

extension OTPViewController: OTPFieldViewDelegate {
    
    @objc func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }

    @objc func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }

    @objc func enteredOTP(otp otpString: String) {
        print("OTP entered: \(otpString)")
    }
}
