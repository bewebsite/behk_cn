
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.graphics.StyleableShape extends com.fb.graphics.StyleableObject
    {
        var _contentShape, _contentClip, _rootClip, activateAnimationObject, _strokeSize, _strokeColor, _strokeOpacity, _strokeBlendMode, _strokePosition, _contentColor, _strokeClip, _dropShadowClip, _dropShadowShape, _innerShadowClip, _innerShadowShape, _gradientMaskClip, _gradientMaskShape, _drawGradient, _dropShadowDepth, _innerShadowDepth, _gradientMaskDepth, _strokeDepth, _strokeShape;
        function StyleableShape (clip) {
            super(clip);
            _contentShape = new com.fb.graphics.CustomShape(_contentClip);
        }
        function get contentClip() {
            return(_contentClip);
        }
        function draw() {
            redrawShape();
        }
        function get width() {
            return(_rootClip._width);
        }
        function get height() {
            return(_rootClip._height);
        }
        function get cornerRadius() {
            return(_cornerRadius);
        }
        function set cornerRadius(newRadius) {
            _cornerRadius = newRadius;
            _drawCornerRadius();
            //return(cornerRadius);
        }
        function cornerRadiusTo(newRadius, duration, delay) {
            activateAnimationObject("_cornerRadius", _drawCornerRadius, "shapeRadius", newRadius, duration, delay);
        }
        function addPoint(x, y, customCornerRadius) {
            _contentShape.addNode(x, y, customCornerRadius);
        }
        function get strokeSize() {
            return(_strokeSize);
        }
        function set strokeSize(newSize) {
            _strokeSize = newSize;
            _drawStroke();
            //return(strokeSize);
        }
        function strokeSizeTo(newSize, duration, delay) {
            activateAnimationObject("_strokeSize", _drawStroke, "stroke", newSize, duration, delay);
        }
        function get strokeColor() {
            return(_strokeColor);
        }
        function set strokeColor(newColor) {
            _strokeColor = newColor;
            _drawStrokeColor();
            //return(strokeColor);
        }
        function strokeColorTo(newColor, duration, delay) {
            activateAnimationObject("_strokeColor", _drawStrokeColor, "strokeColor", newColor, duration, delay);
        }
        function get strokeOpacity() {
            return(_strokeOpacity);
        }
        function set strokeOpacity(newOpacity) {
            _strokeOpacity = newOpacity;
            _drawStrokeOpacity();
            //return(strokeOpacity);
        }
        function strokeOpacityTo(newOpacity, duration, delay) {
            activateAnimationObject("_strokeOpacity", _drawStrokeOpacity, "strokeOpacity", newOpacity, duration, delay);
        }
        function get strokeBlendMode() {
            return(_strokeBlendMode);
        }
        function set strokeBlendMode(newBlendMode) {
            _strokeBlendMode = newBlendMode;
            _drawStrokeBlendMode();
            //return(strokeBlendMode);
        }
        function get strokePosition() {
            return(_strokePosition);
        }
        function set strokePosition(newPosition) {
            _strokePosition = newPosition;
            _drawStroke();
            //return(strokePosition);
        }
        function movePoint(pointIndex, newX, newY) {
            var _local2 = _contentShape._nodes[pointIndex];
            _local2.x = newX;
            _local2.y = newY;
        }
        function pointX(pointIndex, newX) {
            _contentShape._nodes[pointIndex].x = newX;
        }
        function pointY(pointIndex, newY) {
            _contentShape._nodes[pointIndex].y = newY;
        }
        function getPoint(pointIndex) {
            return(_contentShape._nodes[pointIndex]);
        }
        function movePointTo(pointIndex, newX, newY, duration, delay) {
            activateAnimationObject("point_X__" + pointIndex, redrawShape, "points", newX, duration, delay);
            activateAnimationObject("point_Y__" + pointIndex, redrawShape, "points", newY, duration, delay);
        }
        function _drawCornerRadius() {
            _contentShape.__set__cornerRadius(_cornerRadius);
            redrawShape();
        }
        function redrawShape() {
            _contentClip.clear();
            _contentClip.lineStyle(0, 0, 0);
            _contentClip.beginFill(_contentColor, 100);
            _contentShape.draw();
            _contentClip.endFill();
            if (_strokeClip != undefined) {
                _drawStroke();
            }
            redrawFilterClips();
        }
        function redrawFilterClips() {
            if (_dropShadowClip != undefined) {
                _copyShape(_dropShadowShape, _contentShape, _dropShadowClip, "outer");
            }
            if (_innerShadowClip != undefined) {
                _copyShape(_innerShadowShape, _contentShape, _innerShadowClip, "inner");
            }
            if (_gradientMaskClip != undefined) {
                _copyShape(_gradientMaskShape, _contentShape, _gradientMaskClip, "inner");
                _drawGradient();
            }
        }
        function _createDropShadowClip() {
            if (_dropShadowClip == undefined) {
                _dropShadowClip = _rootClip.createEmptyMovieClip("dropShadow", _dropShadowDepth);
                _dropShadowShape = new com.fb.graphics.CustomShape(_dropShadowClip);
                _copyShape(_dropShadowShape, _contentShape, _dropShadowClip, "outer");
            }
        }
        function _createInnerShadowClip() {
            if (_innerShadowClip == undefined) {
                _innerShadowClip = _rootClip.createEmptyMovieClip("innerShadow", _innerShadowDepth);
                _innerShadowShape = new com.fb.graphics.CustomShape(_innerShadowClip);
                _copyShape(_innerShadowShape, _contentShape, _innerShadowClip, "inner");
            }
        }
        function _createGradientMaskClip() {
            if (_gradientMaskClip == undefined) {
                _gradientMaskClip = _rootClip.createEmptyMovieClip("gradientMask", _gradientMaskDepth);
                _gradientMaskShape = new com.fb.graphics.CustomShape(_gradientMaskClip);
                _copyShape(_gradientMaskShape, _contentShape, _gradientMaskClip, "inner");
            }
        }
        function _createStrokeClip() {
            if (_strokeClip == undefined) {
                _strokeClip = _rootClip.createEmptyMovieClip("stroke", _strokeDepth);
                _strokeShape = new com.fb.graphics.CustomShape(_strokeClip);
                _strokeShape.copyNodesFrom(_contentShape);
            }
        }
        function _drawStroke() {
            _createStrokeClip();
            _strokeShape.__set__cornerRadius(_cornerRadius);
            _strokeShape.strokeSize = _strokeSize;
            _strokeShape.strokePosition = _strokePosition;
            _strokeShape.copyNodesFrom(_contentShape);
            _strokeClip.clear();
            _strokeClip.lineStyle(0, 0, 0);
            _strokeClip.beginFill(0, 100);
            _strokeShape.draw();
            _strokeClip.endFill();
            redrawFilterClips();
        }
        function _drawStrokeOpacity() {
            _createStrokeClip();
            _strokeClip._alpha = _strokeOpacity;
        }
        function _drawStrokeColor() {
            _createStrokeClip();
            var _local2 = new Color(_strokeClip);
            _local2.setRGB(_strokeColor);
        }
        function _drawStrokeBlendMode() {
            _createStrokeClip();
            _strokeClip.blendMode = _strokeBlendMode;
        }
        function _copyShape(destination, source, drawClip, shapeType) {
            if (_strokeClip != undefined) {
                source = _strokeShape;
            }
            destination.copySegmentsFrom(source, shapeType);
            drawClip.clear();
            drawClip.lineStyle(0, 0, 0);
            drawClip.beginFill(0, 100);
            destination._drawSegments(1);
            drawClip.endFill();
        }
        var _cornerRadius = 0;
    }
