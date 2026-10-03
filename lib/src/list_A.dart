import 'package:flutter/material.dart';

class AListBuilder extends StatefulWidget {
  final List<Map<String, String>> levelObj;
  final Function(String selectedTitle)? onPressed;
  final double? itemHeight;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? listPadding;
  final EdgeInsetsGeometry? itemMargin;
  final TextAlign? itemAlignment;
  AListBuilder({
    super.key,
    required this.levelObj,
    this.onPressed,
    this.itemHeight = 100,
    this.backgroundColor,
    this.textStyle,
    this.listPadding,
    this.itemMargin,
    this.itemAlignment,
  });
  @override
  State<AListBuilder> createState() => _AListBuilderState();
}

class _AListBuilderState extends State<AListBuilder> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (widget.levelObj.isEmpty) return const Center(child: Text('暂无内容'));
    return ListView.builder(
      padding: widget.listPadding ?? const EdgeInsets.all(12),
      itemCount: widget.levelObj.length,
      itemBuilder: (context, index) {
        final entry = widget.levelObj[index];
        final title = entry['title'] ?? '';
        final image = entry['image'];
        final fallback = Icon(
          Icons.image_outlined,
          color: scheme.onSurfaceVariant,
        );
        final leading = SizedBox(
          width: 48,
          height: 48,
          child: image == null || image.isEmpty
              ? fallback
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => fallback,
                  ),
                ),
        );
        return Container(
          margin: widget.itemMargin ?? const EdgeInsets.only(bottom: 12),
          constraints: BoxConstraints(
            minHeight: (widget.itemHeight ?? 48).clamp(48, double.infinity),
          ),
          child: Material(
            color: widget.backgroundColor ?? scheme.surface,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onPressed == null
                  ? null
                  : () => widget.onPressed?.call(title),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    leading,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: widget.itemAlignment ?? TextAlign.start,
                        style:
                            widget.textStyle ??
                            Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    if (widget.onPressed != null) ...[
                      const SizedBox(width: 12),
                      const Icon(Icons.chevron_right),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
