import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../context/domain/models/context_model.dart';
import '../../domain/models/harris_relation_model.dart';

/// Layout constants shared between the interactive matrix and the arrows painter.
abstract final class HarrisMatrixLayout {
  static const double nodeWidth = 120.0;
  static const double nodeHeight = 58.0;
  static const double layerSpacing = 110.0;
  static const double nodeSpacing = 148.0;
  static const double padding = 56.0;

  /// Compute node center positions from topological sort.
  static Map<String, Offset> computePositions(
    List<ContextModel> contexts,
    List<HarrisRelationModel> relations,
  ) {
    if (contexts.isEmpty) return {};

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

    for (final ctx in contexts) {
      layers.putIfAbsent(ctx.id, () => 0);
    }

    final byLayer = <int, List<String>>{};
    for (final entry in layers.entries) {
      byLayer.putIfAbsent(entry.value, () => []).add(entry.key);
    }

    final sortedLayers = byLayer.keys.toList()..sort();
    final maxLayerCount =
        byLayer.values.map((l) => l.length).fold(0, max);

    final positions = <String, Offset>{};
    for (var li = 0; li < sortedLayers.length; li++) {
      final layerIndex = sortedLayers[li];
      final nodes = byLayer[layerIndex]!;
      final layerWidth = nodes.length * nodeSpacing;
      final startX =
          padding + (maxLayerCount * nodeSpacing - layerWidth) / 2;
      final y = padding + li * layerSpacing;
      for (var ni = 0; ni < nodes.length; ni++) {
        final x = startX + ni * nodeSpacing;
        positions[nodes[ni]] = Offset(x, y);
      }
    }

    return positions;
  }

  /// Compute canvas size from positions.
  static Size canvasSize(Map<String, Offset> positions) {
    if (positions.isEmpty) return const Size(400, 300);
    var maxX = 0.0;
    var maxY = 0.0;
    for (final pos in positions.values) {
      if (pos.dx + nodeWidth > maxX) maxX = pos.dx + nodeWidth;
      if (pos.dy + nodeHeight > maxY) maxY = pos.dy + nodeHeight;
    }
    return Size(maxX + padding, maxY + padding);
  }
}

/// Draws ONLY the arrows between nodes.
///
/// Changed from previous HarrisMatrixPainter:
/// - Nodes are no longer drawn here — they are Stack-positioned widgets
/// - This painter draws only bezier curves and arrowheads
/// - This enables native GestureDetector taps on individual nodes
///
/// The grid dot background is preserved as a subtle orientation marker.
class HarrisArrowPainter extends CustomPainter {
  HarrisArrowPainter({
    required this.relations,
    required this.positions,
    required this.outlineColor,
    required this.outlineVariantColor,
    required this.selectedContextId,
    required this.primaryColor,
  });

  final List<HarrisRelationModel> relations;
  final Map<String, Offset> positions;
  final Color outlineColor;
  final Color outlineVariantColor;
  final String? selectedContextId;
  final Color primaryColor;

  static const double _arrowSize = 9.0;

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawEdges(canvas);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = outlineVariantColor.withAlpha(30)
      ..style = PaintingStyle.fill;

    const gridSpacing = 28.0;
    const dotRadius = 1.0;

    for (var x = gridSpacing; x < size.width; x += gridSpacing) {
      for (var y = gridSpacing; y < size.height; y += gridSpacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  void _drawEdges(Canvas canvas) {
    final edgePaint = Paint()
      ..color = outlineColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashedPaint = Paint()
      ..color = outlineVariantColor.withAlpha(160)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final rel in relations) {
      final fromPos = positions[rel.fromContextId];
      final toPos = positions[rel.toContextId];
      if (fromPos == null || toPos == null) continue;

      final fromPoint = Offset(
        fromPos.dx + HarrisMatrixLayout.nodeWidth / 2,
        fromPos.dy + HarrisMatrixLayout.nodeHeight,
      );
      final toPoint = Offset(
        toPos.dx + HarrisMatrixLayout.nodeWidth / 2,
        toPos.dy,
      );

      final isDashed =
          rel.relationType == HarrisRelationType.contemporaryWith ||
              rel.relationType == HarrisRelationType.equalTo;

      // Highlight edges connected to selected node
      final isHighlighted = selectedContextId != null &&
          (rel.fromContextId == selectedContextId ||
              rel.toContextId == selectedContextId);

      if (isHighlighted) {
        final highlightPaint = Paint()
          ..color = primaryColor.withAlpha(200)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        _drawBezier(canvas, fromPoint, toPoint, highlightPaint);
        _drawArrowHead(canvas, fromPoint, toPoint, highlightPaint);
      } else if (isDashed) {
        _drawDashedBezier(canvas, fromPoint, toPoint, dashedPaint);
      } else {
        _drawBezier(canvas, fromPoint, toPoint, edgePaint);
        _drawArrowHead(canvas, fromPoint, toPoint, edgePaint);
      }
    }
  }

  void _drawBezier(Canvas canvas, Offset from, Offset to, Paint paint) {
    final dy = (to.dy - from.dy).abs();
    final controlOffset = dy * 0.35 + 16;
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..cubicTo(
        from.dx,
        from.dy + controlOffset,
        to.dx,
        to.dy - controlOffset,
        to.dx,
        to.dy,
      );
    canvas.drawPath(path, paint);
  }

  void _drawDashedBezier(Canvas canvas, Offset from, Offset to, Paint paint) {
    const steps = 20;
    const dashLength = 5.0;
    const gapLength = 4.0;

    final dy = (to.dy - from.dy).abs();
    final controlOffset = dy * 0.35 + 16;

    final points = <Offset>[];
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final mt = 1 - t;
      final p1 = from;
      final p2 = Offset(from.dx, from.dy + controlOffset);
      final p3 = Offset(to.dx, to.dy - controlOffset);
      final p4 = to;
      final x = mt * mt * mt * p1.dx +
          3 * mt * mt * t * p2.dx +
          3 * mt * t * t * p3.dx +
          t * t * t * p4.dx;
      final y = mt * mt * mt * p1.dy +
          3 * mt * mt * t * p2.dy +
          3 * mt * t * t * p3.dy +
          t * t * t * p4.dy;
      points.add(Offset(x, y));
    }

    var drawn = 0.0;
    var drawing = true;
    for (var i = 0; i < points.length - 1; i++) {
      final segLen = (points[i + 1] - points[i]).distance;
      if (drawing) canvas.drawLine(points[i], points[i + 1], paint);
      drawn += segLen;
      if (drawing && drawn >= dashLength) {
        drawn = 0;
        drawing = false;
      } else if (!drawing && drawn >= gapLength) {
        drawn = 0;
        drawing = true;
      }
    }
  }

  void _drawArrowHead(Canvas canvas, Offset from, Offset to, Paint paint) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final angle = atan2(dy, dx);

    final arrowPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - _arrowSize * cos(angle - pi / 7),
        to.dy - _arrowSize * sin(angle - pi / 7),
      )
      ..lineTo(
        to.dx - _arrowSize * cos(angle + pi / 7),
        to.dy - _arrowSize * sin(angle + pi / 7),
      )
      ..close();

    final fillPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    canvas.drawPath(arrowPath, fillPaint);
  }

  @override
  bool shouldRepaint(HarrisArrowPainter oldDelegate) =>
      oldDelegate.relations != relations ||
      oldDelegate.positions != positions ||
      oldDelegate.selectedContextId != selectedContextId;
}

// ── Legacy alias kept for matrix_tab.dart which uses the old class name ────────
// matrix_tab.dart uses HarrisMatrixPainter — we keep the old interface.
class HarrisMatrixPainter extends CustomPainter {
  HarrisMatrixPainter({
    required this.contexts,
    required this.relations,
    required this.theme,
  });

  final List<ContextModel> contexts;
  final List<HarrisRelationModel> relations;
  final ThemeData theme;

  late final Map<String, Offset> _positions =
      HarrisMatrixLayout.computePositions(contexts, relations);

  @override
  void paint(Canvas canvas, Size size) {
    final arrowPainter = HarrisArrowPainter(
      relations: relations,
      positions: _positions,
      outlineColor: theme.colorScheme.outline,
      outlineVariantColor: theme.colorScheme.outlineVariant,
      selectedContextId: null,
      primaryColor: theme.colorScheme.primary,
    );
    arrowPainter.paint(canvas, size);
    _drawNodes(canvas);
  }

  void _drawNodes(Canvas canvas) {
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (final ctx in contexts) {
      final pos = _positions[ctx.id];
      if (pos == null) continue;

      final rect = Rect.fromLTWH(
        pos.dx,
        pos.dy,
        HarrisMatrixLayout.nodeWidth,
        HarrisMatrixLayout.nodeHeight,
      );
      final isCut = ctx is CutModel;

      fillPaint.color = isCut
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.tertiaryContainer;
      borderPaint.color = isCut
          ? theme.colorScheme.primary
          : theme.colorScheme.tertiary;

      if (isCut) {
        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, borderPaint);
      } else {
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(29));
        canvas.drawRRect(rrect, fillPaint);
        canvas.drawRRect(rrect, borderPaint);
      }

      final labelColor = isCut
          ? theme.colorScheme.onPrimaryContainer
          : theme.colorScheme.onTertiaryContainer;

      textPainter.text = TextSpan(
        text: 'C${ctx.contextNumber}',
        style: TextStyle(
          color: labelColor,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
          height: 1.1,
        ),
      );
      textPainter.layout(maxWidth: HarrisMatrixLayout.nodeWidth - 12);
      textPainter.paint(
        canvas,
        Offset(
          pos.dx + (HarrisMatrixLayout.nodeWidth - textPainter.width) / 2,
          pos.dy + HarrisMatrixLayout.nodeHeight / 2 - textPainter.height - 1,
        ),
      );

      final cutCtx = isCut ? ctx as CutModel : null;
      final typeLabel = isCut
          ? 'Cut${cutCtx!.cutType != null ? ' · ${cutCtx.cutType!.displayName}' : ''}'
          : 'Fill';
      textPainter.text = TextSpan(
        text: typeLabel,
        style: TextStyle(
          color: labelColor.withAlpha(180),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          height: 1.2,
        ),
      );
      textPainter.layout(maxWidth: HarrisMatrixLayout.nodeWidth - 12);
      textPainter.paint(
        canvas,
        Offset(
          pos.dx + (HarrisMatrixLayout.nodeWidth - textPainter.width) / 2,
          pos.dy + HarrisMatrixLayout.nodeHeight / 2 + 1,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(HarrisMatrixPainter oldDelegate) =>
      oldDelegate.contexts != contexts || oldDelegate.relations != relations;
}
