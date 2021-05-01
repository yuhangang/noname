enum PasscodeScreenStatus { login, setup, setupRepeat, failure, remove, change }

extension PasscodeScreenStatusUtil on PasscodeScreenStatus {
  String get screenTitle {
    switch (this) {
      case PasscodeScreenStatus.login:
        return 'Enter Passcode';
      case PasscodeScreenStatus.change:
        return 'Enter Passcode';
      case PasscodeScreenStatus.setup:
        return 'Passcode Setup';
      case PasscodeScreenStatus.failure:
        return 'Invalid Passcode';
      case PasscodeScreenStatus.setupRepeat:
        return 'Confirm Passcode';
      case PasscodeScreenStatus.remove:
        return 'Enter Passcode';
    }
  }
}
