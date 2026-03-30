import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../context/domain/models/context_model.dart';
import '../../domain/models/harris_relation_model.dart';

/// Draws the Harris Matrix as a layered directed graph using a simple
/// topological sort for layout. Nodes are cuts (rectangles) or fills
/// (rounded rectangles). Edges are drawn as arrows.
///
/// Uses a simplified layered layout algorithm:
/// 1. Assign layers based on topological order (above = higher layer).
/// 2. Distribute nodes evenly within each layer.
/// 3. Draw edges between node centers.
class HarrisMatrixPainter extends CustomPainter {
  HarrisMatrixPainter({
    required this.contexts,
    required this.relations,
    required this.theme,
  });

  final List<ContextModel> contexts;
  final List<HarrisRelationModel> relations;
  final ThemeData theme;

  static const double _nodeWidth = 100;
  static const double _nodeHeight = 44;
  static const double _layerSpacing = 90;
  static const double _nodeSpacing = 120;
  static const double _padding = 40;
  static const double _arrowSize = 10;

  @override
  void paint(Canvas canvas, Size size) {
    if (contexts.isEmpty) return;

    final positions = _computeLayout();
    _drawEdges(canvas, positions);
    _drawNodes(canvas, positions);
  }

  Map<String, Offset> _computeLayout() {
    // Build adjacency list from "above" and "cuts" relations
    final inDegree = <String, int>{};
    final adj = <String, List<String>>{};

    for (final ctx in contexts) {
      inDegree[ctx.id] = 0;
      adj[ctx.id] = [];
    }

    for (final rel in relations) {
      if (rel.relationType == HarrisRelationType.above ||
          rel.relationType == HarrisRelationType.cuts) {
        adj[rel.fromContextId]?.add(rel.toContextId);
        inDegree[rel.toContextId] =
            (inDegree[rel.toContextId] ?? 0) + 1;
      } else if (rel.relationType == HarrisRelationType.below ||
          rel.relationType == HarrisRelationType.cutBy) {
        adj[rel.toContextId]?.add(rel.fromContextId);
        inDegree[rel.fromContextId] =
            (inDegree[rel.fromContextId] ?? 0) + 1;
      }
    }

    // Kahn's algorithm for topological layers
    final layers = <String, int>{};
    final queue = <String>[];

    for (final id in inDegree.keys) {
      if (inDegree[id] == 0) queue.add(id);
    }

    while (queue.isNotEmpty) {
      final node = queue.removeAt(0);
      final layer = layers[node] ?? 0;
      for (final neighbor in adj[node] ?? <String>[]) {
        final newLayer = max(layer + 1, layers[neighbor] ?? 0);
        layers[neighbor] = newLayer;
        inDegree[neighbor] = (inDegree[neighbor] ?? 1) - 1;
        if (inDegree[neighbor] == 0) queue.add(neighbor);
      }
    }

    // Assign unprocessed nodes (cycles) to layer 0
    for (final ctx in contexts) {
      layers.putIfAbsent(ctx.id, () => 0);
    }

    // Group by layer
    final byLayer = <int, List<String>>{};
    for (final entry in layers.entries) {
      byLayer.putIfAbsent(entry.value, () => []).add(entry.key);
    }

    final sortedLayers = byLayer.keys.toList()..sort();
    final maxLayerCount = byLayer.values
        .map((l) => l.length)
        .fold(0, max);

    final positions = <String, Offset>{};
    for (var li = 0; li < sortedLayers.length; li++) {
      final layerIndex = sortedLayers[li];
      final nodes = byLayer[layerIndex]!;
      final layerWidth = nodes.length * _nodeSpacing;
      final startX = _padding +
          (maxLayerCount * _nodeSpacing - layerWidth) / 2;
      final y = _padding + li * _layerSpacing;
      for (var ni = 0; ni < nodes.length; ni++) {
        final x = startX + ni * _nodeSpacing;
        positions[nodes[ni]] = Offset(x, y);
      }
    }

    return positions;
  }

  void _drawEdges(Canvas canvas, Map<String, Offset> positions) {
    final edgePaint = Paint()
      ..color = theme.colorScheme.outline
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashedPaint = Paint()
      ..color = theme.colorScheme.outline.withAlpha(153)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (final rel in relations) {
      final from = positions[rel.fromContextId];
      final to = positions[rel.toContextId];
      if (from == null || to == null) continue;

      final fromCenter = Offset(
        from.dx + _nodeWidth / 2,
        from.dy + _nodeHeight / 2,
      );
      final toCenter = Offset(
        to.dx + _nodeWidth / 2,
        to.dy + _nodeHeight / 2,
      );

      final isDashed = rel.relationType == HarrisRelationType.contemporaryWith ||
          rel.relationType == HarrisRelationType.equalTo;

      if (isDashed) {
        _drawDashedLine(canvas, fromCenter, toCenter, dashedPaint);
      } else {
        canvas.drawLine(fromCenter, toCenter, edgePaint);
        _drawArrowHead(canvas, fromCenter, toCenter, edgePaint);
      }
    }
  }

  void _drawArrowHead(
    Canvas canvas,
    Offset from,
    Offset to,
    Paint paint,
  ) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final angle = atan2(dy, dx);

    final arrowPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - _arrowSize * cos(angle - pi / 6),
        to.dy - _arrowSize * sin(angle - pi / 6),
      )
      ..lineTo(
        to.dx - _arrowSize * cos(angle + pi / 6),
        to.dy - _arrowSize * sin(angle + pi / 6),
      )
      ..close();

    canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset from,
    Offset to,
    Paint paint,
  ) {
    const dashLength = 6.0;
    const gapLength = 4.0;
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final unitX = dx / distance;
    final unitY = dy / distance;

    var drawn = 0.0;
    var drawing = true;
    while (drawn < distance) {
      final segLength = drawing ? dashLength : gapLength;
      final end = min(drawn + segLength, distance);
      if (drawing) {
        canvas.drawLine(
          Offset(from.dx + unitX * drawn, from.dy + unitY * drawn),
          Offset(from.dx + unitX * end, from.dy + unitY * end),
          paint,
        );
      }
      drawn = end;
      drawing = !drawing;
    }
  }

  void _drawNodes(Canvas canvas, Map<String, Offset> positions) {
    final cutFillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (final ctx in contexts) {
      final pos = positions[ctx.id];
      if (pos == null) continue;

      final rect = Rect.fromLTWH(pos.dx, pos.dy, _nodeWidth, _nodeHeight);

      final isCut = ctx is CutModel;

      cutFillPaint.color = isCut
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.tertiaryContainer;

      borderPaint.color = isCut
          ? theme.colorScheme.primary
          : theme.colorScheme.tertiary;

      // Cuts = rectangle, fills = rounded rect
      if (isCut) {
        canvas.drawRect(rect, cutFillPaint);
        canvas.drawRect(rect, borderPaint);
      } else {
        final rrect =
            RRect.fromRectAndRadius(rect, const Radius.circular(22));
        canvas.drawRRect(rrect, cutFillPaint);
        canvas.drawRRect(rrect, borderPaint);
      }

      // Label: context number + type
      final labelColor = isCut
          ? theme.colorScheme.onPrimaryContainer
          : theme.colorScheme.onTertiaryContainer;

      textPainter.text = TextSpan(
        children: [
          TextSpan(
            text: 'C${ctx.contextNumber}\n',
            style: TextStyle(
              color: labelColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          TextSpan(
            text: isCut ? 'Cut' : 'Fill',
            style: TextStyle(
              color: labelColor.withAlpha(179),
              fontSize: 10,
            ),
          ),
        ],
      );
      textPainter.layout(maxWidth: _nodeWidth - 8);
      textPainter.paint(
        canvas,
        Offset(
          pos.dx + (_nodeWidth - textPainter.width) / 2,
          pos.dy + (_nodeHeight - textPainter.height) / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(HarrisMatrixPainter oldDelegate) =>
      oldDelegate.contexts != contexts || oldDelegate.relations != relations;
}
