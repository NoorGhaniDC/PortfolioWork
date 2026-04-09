import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PhotoSection extends StatelessWidget {
  final dynamic user;

  /// Raw bytes of the selected image — used for preview on web and native.
  final Uint8List? pendingPhotoBytes;
  final bool removePhoto;
  final VoidCallback onPickPhoto;
  final VoidCallback onRemovePhoto;

  const PhotoSection({
    super.key,
    required this.user,
    required this.pendingPhotoBytes,
    required this.removePhoto,
    required this.onPickPhoto,
    required this.onRemovePhoto,
  });

  bool get _hasPhoto {
    if (pendingPhotoBytes != null) return true;
    if (removePhoto) return false;
    return user.photoUrl != null && user.photoUrl!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                // Preview: pending bytes take priority, then existing network URL
                backgroundImage: pendingPhotoBytes != null
                    ? MemoryImage(pendingPhotoBytes!)
                    : (!removePhoto &&
                            user.photoUrl != null &&
                            user.photoUrl!.isNotEmpty)
                        ? NetworkImage(user.photoUrl!) as ImageProvider
                        : null,
                child: !_hasPhoto
                    ? Text(
                        user.username.isNotEmpty
                            ? user.username[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
              GestureDetector(
                onTap: onPickPhoto,
                child: Tooltip(
                  message: 'Click to upload a profile photo',
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'Select a photo from your device',
                child: TextButton.icon(
                  onPressed: onPickPhoto,
                  icon: const Icon(Icons.upload_outlined, size: 16),
                  label: const Text('Upload Photo'),
                ),
              ),
              if (_hasPhoto) ...[
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Delete current profile photo',
                  child: TextButton.icon(
                    onPressed: onRemovePhoto,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: AppColors.error,
                    ),
                    label: const Text(
                      'Remove',
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
