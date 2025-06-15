import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_auth.dart';
import 'screen_reset_password.dart';
import 'screen_main_navigation.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isPasswordReset;

  const OtpVerificationScreen({
    super.key,
    this.isPasswordReset = false,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _digitControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpVerification(BuildContext context) async {
    final authService = Provider.of<FakeAuthService>(context, listen: false);
    final otp = _digitControllers.map((c) => c.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    await authService.verifyOtp(otp);

    if (widget.isPasswordReset) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FakeAuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPasswordReset ? 'Reset Password' : 'Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isPasswordReset
                  ? 'Enter the OTP sent to your email to reset your password'
                  : 'Enter the OTP sent to your phone number',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextFormField(
                    controller: _digitControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            authService.isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleOtpVerification(context),
                child: const Text('Verify'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP resent successfully')),
                );
              },
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}