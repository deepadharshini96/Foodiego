// Extracted source snippet from the Foodiego internship report.
Future<void> _checkUserExistsAndLogin() async {
  final user = _auth.currentUser;
  final ref = _database.ref('users/${user!.uid}');
  final snapshot = await ref.get();

  if (snapshot.exists) {
    _showMessage('Login successful!');
    Navigator.pop(context);
  } else {
    await _auth.signOut();
    _showError('No account found. Please sign up first.');
  }
}

// Phone OTP verification callback snippet:
phoneNumber: '+91$phone',
verificationCompleted: (credential) async {
  await _auth.signInWithCredential(credential);
  await checkUserExistsAndLogin();
},
verificationFailed: (e) =>
    _showError(e.message ?? 'Verification failed.'),
codeSent: (verificationId, resendToken) {
  setState(() {
    _verificationId = verificationId;
    isOtpSent = true;
  });
},
codeAutoRetrievalTimeout: (verificationId) =>
    _verificationId = verificationId,
