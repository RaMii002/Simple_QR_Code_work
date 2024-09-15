import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  QrScannerScreenState createState() => QrScannerScreenState();
}

class QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  bool _isDialogShown = false;  // Add a flag to track if dialog is shown

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    }
    _controller?.resumeCamera();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (!_isDialogShown) {
        setState(() {
          _isDialogShown = true;  // Set the flag to true to prevent multiple dialogs
        });
        // Pause camera so it doesn't scan again immediately
        _controller?.pauseCamera();

        // Handle the scanned data
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('QR Code Scanned'),
            content: Text(scanData.code ?? 'Unknown'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        // Reset the flag and resume camera after dialog is dismissed
        setState(() {
          _isDialogShown = false;
        });
        _controller?.resumeCamera();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
