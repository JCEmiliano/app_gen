import 'package:flutter/material.dart';

class TemplateCard extends StatelessWidget {
  final String title;
  final Color borderColor;
  final String statusText;
  final Color statusColor;
  final Color bgColor;
  final bool isDark;
  final List<Widget> children;
  final VoidCallback? onCopy;

  const TemplateCard({
    super.key,
    required this.title,
    required this.borderColor,
    required this.statusText,
    required this.statusColor,
    required this.bgColor,
    required this.isDark,
    required this.children,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: borderColor, width: 6)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.05), 
            blurRadius: 20, 
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: borderColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onCopy != null)
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: onCopy,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Icon(Icons.copy, size: 20, color: borderColor),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: borderColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText.toUpperCase(),
                      style: TextStyle(color: borderColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

Widget buildInfoRow(List<Widget> items) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items,
  );
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool fullWidth;
  final bool isDark;

  const InfoItem(this.label, this.value, {super.key, this.fullWidth = false, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant = isDark ? const Color(0xFFa5abbd) : const Color(0xFF64748b);
    
    Widget content = Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(color: onSurfaceVariant, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: onSurface, fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
    if (fullWidth) return content;
    return Expanded(child: content);
  }
}
