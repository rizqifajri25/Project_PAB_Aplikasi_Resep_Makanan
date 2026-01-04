import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = '';
  String userName = "";
  int favoriteCandiCount = 0;

  String? _profilePhotoBase64;

  void signIn() {
    Navigator.pushNamed(context, "/signin");
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);

    setState(() {
      isSignedIn = false;
      userName = '';
      fullName = '';
      _profilePhotoBase64 = null;
    });
  }

  void _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSignedIn = prefs.getBool("isSignedIn") ?? false;
    });
  }

  Future<void> _loadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = prefs.getString("profilePhoto");
    });
  }

  void _identitas() async {
    final prefs = await SharedPreferences.getInstance();

    final encFull = prefs.getString("fullname") ?? "";
    final encUser = prefs.getString("username") ?? "";

    final keyString = prefs.getString('key') ?? '';
    final ivString = prefs.getString('iv') ?? '';

    String decFull = encFull;
    String decUser = encUser;

    if (keyString.isNotEmpty && ivString.isNotEmpty) {
      try {
        final key = encrypt.Key.fromBase64(keyString);
        final iv = encrypt.IV.fromBase64(ivString);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        if (encFull.isNotEmpty) decFull = encrypter.decrypt64(encFull, iv: iv);
        if (encUser.isNotEmpty) decUser = encrypter.decrypt64(encUser, iv: iv);
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() {
      fullName = decFull;
      userName = decUser;
    });
  }

  Future<void> _changePhoto() async {
    if (!isSignedIn) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pilih dari Gallery"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Ambil dari Camera"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: source,
      imageQuality: 75,
      maxWidth: 900,
    );
    if (xFile == null) return;

    final bytes = await xFile.readAsBytes();
    final base64Str = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profilePhoto", base64Str);

    if (!mounted) return;
    setState(() {
      _profilePhotoBase64 = base64Str;
    });
  }

  ImageProvider _avatarProvider() {
    if (_profilePhotoBase64 != null && _profilePhotoBase64!.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(_profilePhotoBase64!));
      } catch (_) {}
    }
    return const AssetImage('images/placeholder_image.png');
  }

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    _identitas();
    _loadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        children: [
          // HEADER
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 210,
                width: double.infinity,
                color: colorScheme.primary,
                child: SafeArea(
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            "PROFILES",
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: colorScheme.onPrimary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: -55,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: colorScheme.onBackground.withOpacity(.1),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundImage: _avatarProvider(),
                        ),
                      ),
                      if (isSignedIn)
                        IconButton(
                          onPressed: _changePhoto,
                          icon: Icon(Icons.camera_alt, color: colorScheme.onPrimary),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 80),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                Divider(color: theme.dividerColor),

                _infoRow(
                  icon: Icons.lock,
                  label: "Pengguna",
                  value: userName.isEmpty ? "-" : userName,
                ),
                Divider(color: theme.dividerColor),

                _infoRow(
                  icon: Icons.person,
                  label: "Nama",
                  value: fullName.isEmpty ? "-" : fullName,
                ),
                Divider(color: theme.dividerColor),

                _infoRow(
                  icon: Icons.favorite,
                  label: "Favorite",
                  value: favoriteCandiCount <= 0
                      ? "-"
                      : favoriteCandiCount.toString(),
                  iconColor: Colors.red,
                ),
                Divider(color: theme.dividerColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? colorScheme.onBackground),
          const SizedBox(width: 10),
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(": "),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
