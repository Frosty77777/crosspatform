import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/device_info_service.dart';
import '../state/app_state_scope.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int? _batteryLevel;
  Map<String, dynamic>? _deviceInfo;
  String? _errorMessage;
  bool _loading = false;

  bool get _platformSupported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> _refreshNativeData() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final battery = await DeviceInfoService.instance.getBatteryLevel();
      final info = await DeviceInfoService.instance.getDeviceInfo();
      if (!mounted) return;
      setState(() {
        _batteryLevel = battery;
        _deviceInfo = info;
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message ?? 'Platform error');
    } on UnsupportedError catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _sayHelloNatively() async {
    try {
      await DeviceInfoService.instance.showNativeToast(
        'Hello from Flutter via MethodChannel!',
        long: true,
      );
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Toast failed: ${e.message}')),
      );
    } on UnsupportedError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Unsupported')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AppStateScope.of(context).user;
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: user,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: cs.primaryContainer,
                  child: Icon(Icons.person, size: 40, color: cs.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  user.username.isEmpty ? 'User' : user.username,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // ── Chapter 17 demo: Platform Channels ───────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.memory, color: cs.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Native device info',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Data below comes from native Kotlin code via a MethodChannel.',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),

                  if (!_platformSupported)
                    _InfoBanner(
                      icon: Icons.info_outline,
                      text:
                          'This Chapter 17 demo only ships an Android handler. '
                          'Run the app on an Android device or emulator to try it.',
                      color: cs.secondaryContainer,
                      foreground: cs.onSecondaryContainer,
                    )
                  else ...[
                    _DataRow(
                      label: 'Battery',
                      value: _batteryLevel == null
                          ? '—'
                          : '$_batteryLevel%',
                    ),
                    _DataRow(
                      label: 'Manufacturer',
                      value: _deviceInfo?['manufacturer']?.toString() ?? '—',
                    ),
                    _DataRow(
                      label: 'Model',
                      value: _deviceInfo?['model']?.toString() ?? '—',
                    ),
                    _DataRow(
                      label: 'Android',
                      value: _deviceInfo == null
                          ? '—'
                          : '${_deviceInfo!['release']} '
                                '(SDK ${_deviceInfo!['sdkInt']})',
                    ),
                  ],

                  if (_errorMessage != null) ...[
                    const SizedBox(height: 8),
                    _InfoBanner(
                      icon: Icons.error_outline,
                      text: _errorMessage!,
                      color: cs.errorContainer,
                      foreground: cs.onErrorContainer,
                    ),
                  ],

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: (_loading || !_platformSupported)
                              ? null
                              : _refreshNativeData,
                          icon: _loading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.refresh),
                          label: const Text('Read from native'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _platformSupported
                              ? _sayHelloNatively
                              : null,
                          icon: const Icon(Icons.campaign_outlined),
                          label: const Text('Native toast'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () => user.logout(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    required this.icon,
    required this.text,
    required this.color,
    required this.foreground,
  });
  final IconData icon;
  final String text;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
