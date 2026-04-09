import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../services/storage_service.dart';

/// Displays a row of picked image previews with add/remove controls.
/// Call [onImagesChanged] to get the current list of [Uint8List] bytes.
class ListingImagePicker extends StatefulWidget {
  final List<Uint8List> initialBytes;
  final List<String> existingUrls; // for edit mode
  final void Function(List<Uint8List> newBytes, List<String> removedUrls)
      onImagesChanged;
  final int maxImages;

  const ListingImagePicker({
    super.key,
    this.initialBytes = const [],
    this.existingUrls = const [],
    required this.onImagesChanged,
    this.maxImages = 5,
  });

  @override
  State<ListingImagePicker> createState() => _ListingImagePickerState();
}

class _ListingImagePickerState extends State<ListingImagePicker> {
  final StorageService _storageService = StorageService();
  late List<Uint8List> _pickedBytes;
  late List<String> _existingUrls;
  final List<String> _removedUrls = [];

  @override
  void initState() {
    super.initState();
    _pickedBytes = List.from(widget.initialBytes);
    _existingUrls = List.from(widget.existingUrls);
  }

  int get _totalCount => _existingUrls.length + _pickedBytes.length;
  bool get _canAddMore => _totalCount < widget.maxImages;

  Future<void> _pickImages() async {
    final remaining = widget.maxImages - _totalCount;
    if (remaining <= 0) return;

    final picked = await _storageService.pickMultipleImages(limit: remaining);
    if (picked.isEmpty) return;

    setState(() {
      _pickedBytes.addAll(picked.map((p) => p.bytes));
    });
    _notify();
  }

  void _removeExisting(String url) {
    setState(() {
      _existingUrls.remove(url);
      _removedUrls.add(url);
    });
    _notify();
  }

  void _removePicked(int index) {
    setState(() => _pickedBytes.removeAt(index));
    _notify();
  }

  void _notify() {
    widget.onImagesChanged(_pickedBytes, _removedUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Photos ($_totalCount/${widget.maxImages})',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (_canAddMore)
              Tooltip(
                message: 'Select images from gallery (max 5)',
                child: TextButton.icon(
                  onPressed: _pickImages,
                  icon:
                      const Icon(Icons.add_photo_alternate_outlined, size: 18),
                  label: const Text('Add Photos'),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (_totalCount == 0)
          // Empty state
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  style: BorderStyle.solid,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined,
                        size: 36, color: AppColors.textSecondary),
                    SizedBox(height: 8),
                    Text(
                      'Tap to add photos',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          // Image grid
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Existing URLs (edit mode)
                ..._existingUrls.map((url) => _ImageTile(
                      child: Image.network(url, fit: BoxFit.cover),
                      onRemove: () => _removeExisting(url),
                    )),

                // Newly picked bytes
                ..._pickedBytes.asMap().entries.map((entry) => _ImageTile(
                      child: Image.memory(entry.value, fit: BoxFit.cover),
                      onRemove: () => _removePicked(entry.key),
                    )),

                // Add more button
                if (_canAddMore)
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: AppColors.textSecondary),
                          SizedBox(height: 4),
                          Text(
                            'Add more',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ImageTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onRemove;

  const _ImageTile({required this.child, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: child,
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
