import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: const [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
            builder: (icon, size) {
              return Container(
                constraints: BoxConstraints.tight(Size.square(size)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      Colors.primaries[icon.hashCode % Colors.primaries.length],
                ),
                child: Center(
                    child: Icon(icon, color: Colors.white, size: size * 0.6)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Dock<T extends Object> extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });

  final List<T> items;

  final Widget Function(T item, double size) builder;

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

class _DockState<T extends Object> extends State<Dock<T>> {
  late final List<T> _items = widget.items.toList();
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isHovered = index == _hoveredIndex;
          final isNeighbor = _hoveredIndex != null &&
              (index == _hoveredIndex! - 1 || index == _hoveredIndex! + 1);

          final iconSize = isHovered
              ? 64.0
              : isNeighbor
                  ? 56.0
                  : 48.0;

          return Draggable<T>(
            data: item,
            feedback: Material(
              color: Colors.transparent,
              child: widget.builder(item, iconSize),
            ),
            childWhenDragging: const SizedBox.shrink(),
            onDragStarted: () => setState(() => _hoveredIndex = null),
            child: DragTarget<T>(
              onAccept: (receivedItem) {
                setState(() {
                  final draggedIndex = _items.indexOf(receivedItem);
                  if (draggedIndex != -1) {
                    _items.removeAt(draggedIndex);
                    _items.insert(index, receivedItem);
                  }
                });
              },
              builder: (context, candidateData, rejectedData) {
                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                      top: isHovered
                          ? 0
                          : isNeighbor
                              ? 8
                              : 16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: widget.builder(item, iconSize),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
