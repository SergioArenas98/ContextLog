import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../../context/domain/models/context_model.dart';
import '../../domain/models/harris_relation_model.dart';

/// Draws the Harris Matrix as a layered directed graph.
///
/// Layout: Kahn's BFS topological sort assigns layer positions.
/// Nodes: cuts = sharp rectangles, fills = rounded rectangles (stadium).
/// Edges: cubic bezier curves with arrowheads; contemporary/equal = dashed.
/// Legend: drawn in the top-left corner of the canvas.
class HarrisMatrixPainter extends CustomPainter {
  HarrisMatrixPainter({
    required this.contexts,
    required this.relations,
    required this.theme,
  });

  final List<ContextModel> contexts;
  final List<HarrisRelationModel> relations;
  final ThemeData theme;

  static const double _nodeWidth = 130;
  static const double _nodeHeight = 68;
  static const double _layerSpacing = 120;
  static const double _nodeSpacing = 160;
  static const double _padding = 64;
  static const double _arrowSize = 10;

  @override
  void paint(Canvas canvas, Size size) {
    if (contexts.isEmpty) return;

    final positions = _computeLayout();
    _drawGrid(canvas, size);
    _drawEdges(canvas, positions);
    _drawNodes(canvas, positions);
    _drawLegend(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.colorScheme.outlineVariant.withAlpha(50)
      ..style = PaintingStyle.fill;

    const gridSpacing = 32.0;
    const dotRadius = 1.5;

    for (var x = gridSpacing; x < size.width; x += gridSpacing) {
      for (var y = gridSpacing; y < size.height; y += gridSpacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  Map<String, Offset> _computeLayout() {
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
      final layerWidth = nodes.length * _nodeSpacing;
      final startX =
          _padding + (maxLayerCount * _nodeSpacing - layerWidth) / 2;
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
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashedPaint = Paint()
      ..color = theme.colorScheme.outline.withAlpha(140)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final rel in relations) {
      final fromPos = positions[rel.fromContextId];
      final toPos = positions[rel.toContextId];
      if (fromPos == null || toPos == null) continue;

      final fromPoint = Offset(
        fromPos.dx + _nodeWidth / 2,
        fromPos.dy + _nodeHeight,
      );
      final toPoint = Offset(
        toPos.dx + _nodeWidth / 2,
        toPos.dy,
      );

      final isDashed =
          rel.relationType == HarrisRelationType.contemporaryWith ||
              rel.relationType == HarrisRelationType.equalTo;

      if (isDashed) {
        _drawDashedBezier(canvas, fromPoint, toPoint, dashedPaint);
      } else {
        _drawBezier(canvas, fromPoint, toPoint, edgePaint);
        _drawArrowHead(canvas, fromPoint, toPoint, edgePaint);
      }
    }
  }

  void _drawBezier(Canvas canvas, Offset from, Offset to, Paint paint) {
    final dy = (to.dy - from.dy).abs();
    final controlOffset = dy * 0.4 + 20;
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
    // Approximate with a polyline sampled from the bezier
    const steps = 20;
    const dashLength = 6.0;
    const gapLength = 4.0;

    final dy = (to.dy - from.dy).abs();
    final controlOffset = dy * 0.4 + 20;

    final points = <Offset>[];
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final mt = 1 - t;
      final p1 = Offset(from.dx, from.dy);
      final p2 = Offset(from.dx, from.dy + controlOffset);
      final p3 = Offset(to.dx, to.dy - controlOffset);
      final p4 = Offset(to.dx, to.dy);
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
      if (drawing) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
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

  void _drawNodes(Canvas canvas, Map<String, Offset> positions) {
    final fillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (final ctx in contexts) {
      final pos = positions[ctx.id];
      if (pos == null) continue;

      final rect = Rect.fromLTWH(pos.dx, pos.dy, _nodeWidth, _nodeHeight);
      final isCut = ctx is CutModel;

      // Drop shadow
      final shadowPaint = Paint()
        ..color = Colors.black.withAlpha(40)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      final shadowRect = rect.translate(0, 3);
      if (isCut) {
        canvas.drawRect(shadowRect, shadowPaint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(shadowRect, const Radius.circular(34)),
          shadowPaint,
        );
      }

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
        final rrect =
            RRect.fromRectAndRadius(rect, const Radius.circular(34));
        canvas.drawRRect(rrect, fillPaint);
        canvas.drawRRect(rrect, borderPaint);
      }

      // Two-line label: context number on top, type on bottom
      final labelColor = isCut
          ? theme.colorScheme.onPrimaryContainer
          : theme.colorScheme.onTertiaryContainer;

      // Line 1 — context number
      textPainter.text = TextSpan(
        text: 'C${ctx.contextNumber}',
        style: TextStyle(
          color: labelColor,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          height: 1.1,
        ),
      );
      textPainter.layout(maxWidth: _nodeWidth - 12);
      textPainter.paint(
        canvas,
        Offset(
          pos.dx + (_nodeWidth - textPainter.width) / 2,
          pos.dy + _nodeHeight / 2 - textPainter.height - 1,
        ),
      );

      // Line 2 — type label
      final cutCtx = isCut ? ctx as CutModel : null;
      final typeLabel = isCut
          ? 'Cut${cutCtx!.cutType != null ? ' · ${cutCtx.cutType!.displayName}' : ''}'
          : 'Fill';
      textPainter.text = TextSpan(
        text: typeLabel,
        style: TextStyle(
          color: labelColor.withAlpha(200),
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
          height: 1.2,
        ),
      );
      textPainter.layout(maxWidth: _nodeWidth - 12);
      textPainter.paint(
        canvas,
        Offset(
          pos.dx + (_nodeWidth - textPainter.width) / 2,
          pos.dy + _nodeHeight / 2 + 1,
        ),
      );
    }
  }

  void _drawLegend(Canvas canvas, Size size) {
    const legendX = 12.0;
    const legendY = 12.0;
    const legendWidth = 108.0;
    const legendHeight = 72.0;
    const itemH = 24.0;

    // Background
    final bgPaint = Paint()
      ..color = theme.colorScheme.surface.withAlpha(220)
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = theme.colorScheme.outlineVariant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final bgRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(legendX, legendY, legendWidth, legendHeight),
      const Radius.circular(8),
    );
    canvas.drawRRect(bgRect, bgPaint);
    canvas.drawRRect(bgRect, borderPaint);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    // Cut sample
    final cutFill = Paint()
      ..color = theme.colorScheme.primaryContainer
      ..style = PaintingStyle.fill;
    final cutBorder = Paint()
      ..color = theme.colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final cutRect = const Rect.fromLTWH(legendX + 8, legendY + 10, 24, 14);
    canvas.drawRect(cutRect, cutFill);
    canvas.drawRect(cutRect, cutBorder);

    textPainter.text = TextSpan(
      text: 'Cut',
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(legendX + 38, legendY + 10 + (14 - textPainter.height) / 2));

    // Fill sample
    final fillFillPaint = Paint()
      ..color = theme.colorScheme.tertiaryContainer
      ..style = PaintingStyle.fill;
    final fillBorder = Paint()
      ..color = theme.colorScheme.tertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final fillRect =
        const Rect.fromLTWH(legendX + 8, legendY + 10 + itemH, 24, 14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(fillRect, const Radius.circular(7)),
      fillFillPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(fillRect, const Radius.circular(7)),
      fillBorder,
    );

    textPainter.text = TextSpan(
      text: 'Fill',
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(legendX + 38, legendY + 10 + itemH + (14 - textPainter.height) / 2),
    );

    // Dashed line for contemporary/equal
    final dashedPaint = Paint()
      ..color = theme.colorScheme.outline.withAlpha(140)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    const lineY = legendY + 10 + itemH * 2 + 7;
    var x = legendX + 8.0;
    while (x < legendX + 32) {
      canvas.drawLine(Offset(x, lineY), Offset(min(x + 5, legendX + 32), lineY), dashedPaint);
      x += 9;
    }

    textPainter.text = TextSpan(
      text: '= / ~',
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(legendX + 38, lineY - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(HarrisMatrixPainter oldDelegate) =>
      oldDelegate.contexts != contexts || oldDelegate.relations != relations;
}
