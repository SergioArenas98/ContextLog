import 'package:flutter/material.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../context/domain/models/context_model.dart';
import '../../domain/models/harris_relation_model.dart';
import 'harris_matrix_painter.dart';

/// Interactive Harris Matrix — nodes are tappable widgets, not just paint.
///
/// Changed from previous HarrisMatrixPainter (static canvas):
/// - Nodes are now positioned Widget instances with GestureDetectors
/// - The CustomPainter draws ONLY the arrows between nodes
/// - Tapping a node calls [onNodeTap] with the context ID
/// - A selected node gets an amber highlight ring
/// - Panning and zooming are preserved via InteractiveViewer
class HarrisInteractiveMatrix extends StatefulWidget {
  const HarrisInteractiveMatrix({
    super.key,
    required this.contexts,
    required this.relations,
    required this.onNodeTap,
    this.selectedContextId,
  });

  final List<ContextModel> contexts;
  final List<HarrisRelationModel> relations;
  final void Function(String contextId) onNodeTap;
  final String? selectedContextId;

  @override
  State<HarrisInteractiveMatrix> createState() =>
      _HarrisInteractiveMatrixState();
}

class _HarrisInteractiveMatrixState extends State<HarrisInteractiveMatrix> {
  late Map<String, Offset> _positions;
  late Size _canvasSize;

  @override
  void initState() {
    super.initState();
    _computeLayout();
  }

  @override
  void didUpdateWidget(HarrisInteractiveMatrix oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contexts != widget.contexts ||
        oldWidget.relations != widget.relations) {
      _computeLayout();
    }
  }

  void _computeLayout() {
    _positions = HarrisMatrixLayout.computePositions(
      widget.contexts,
      widget.relations,
    );
    _canvasSize = HarrisMatrixLayout.canvasSize(_positions);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppColors.of(context);

    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(160),
      minScale: 0.25,
      maxScale: 4.0,
      child: SizedBox(
        width: _canvasSize.width,
        height: _canvasSize.height,
        child: Stack(
          children: [
            // ── Arrows layer (CustomPainter, behind nodes) ──────────────
            Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: HarrisArrowPainter(
                    relations: widget.relations,
                    positions: _positions,
                    outlineColor: theme.colorScheme.outline,
                    outlineVariantColor: theme.colorScheme.outlineVariant,
                    selectedContextId: widget.selectedContextId,
                    primaryColor: colors.primary,
                  ),
                  size: _canvasSize,
                ),
              ),
            ),

            // ── Node widgets (tappable, above arrows) ───────────────────
            for (final ctx in widget.contexts)
              if (_positions.containsKey(ctx.id))
                Positioned(
                  left: _positions[ctx.id]!.dx,
                  top: _positions[ctx.id]!.dy,
                  width: HarrisMatrixLayout.nodeWidth,
                  height: HarrisMatrixLayout.nodeHeight,
                  child: _MatrixNode(
                    context_: ctx,
                    isSelected: widget.selectedContextId == ctx.id,
                    onTap: () => widget.onNodeTap(ctx.id),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

// ── Matrix node widget ────────────────────────────────────────────────────────

class _MatrixNode extends StatefulWidget {
  const _MatrixNode({
    required this.context_,
    required this.isSelected,
    required this.onTap,
  });

  final ContextModel context_;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_MatrixNode> createState() => _MatrixNodeState();
}

class _MatrixNodeState extends State<_MatrixNode> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final ctx = widget.context_;
    final isCut = ctx is CutModel;
    final accentColor = isCut ? colors.cut : colors.fill;
    final surfaceColor = isCut ? colors.cutSurface : colors.fillSurface;
    final textColor = isCut ? colors.cutText : colors.fillText;
    final num = ctx.contextNumber.toString().padLeft(3, '0');
    final typeLabel = isCut ? 'CUT' : 'FILL';

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        decoration: BoxDecoration(
          color: _pressed
              ? surfaceColor.withAlpha(220)
              : surfaceColor,
          borderRadius: isCut
              ? AppRadius.xsBorderRadius
              : AppRadius.fullBorderRadius,
          border: Border.all(
            color: widget.isSelected
                ? colors.primary
                : accentColor.withAlpha(180),
            width: widget.isSelected ? 2.0 : 1.5,
          ),
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withAlpha(80),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
              : AppElevation.none,
        ),
        child: Stack(
          children: [
            // Selected indicator — amber top stripe
            if (widget.isSelected)
              Positioned(
                top: 0,
                left: isCut ? 0 : 6,
                right: isCut ? 0 : 6,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: isCut
                        ? const BorderRadius.vertical(top: Radius.circular(AppRadius.xs))
                        : AppRadius.fullBorderRadius,
                  ),
                ),
              ),
            // Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    num,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: -0.5,
                      height: 1,
                      color: widget.isSelected ? colors.primary : textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    typeLabel,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                      letterSpacing: 1.5,
                      color: (widget.isSelected ? colors.primary : accentColor)
                          .withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
