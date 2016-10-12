
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.graphics.CustomShape
    {
        var _clip, _nodes, _strokeNodes, _segments, _points, _strokeSegments, _strokePoints;
        function CustomShape (clip) {
            _clip = clip;
            _nodes = new Array();
            _strokeNodes = new Array();
        }
        function addNode(x, y, customCornerRadius) {
            _nodes.push({x:x, y:y, customCornerRadius:customCornerRadius});
        }
        function clear() {
            _nodes = new Array();
            _strokeNodes = new Array();
            _clip.clear();
        }
        function get cornerRadius() {
            return(_cornerRadius);
        }
        function set cornerRadius(newRadius) {
            _cornerRadius = newRadius;
            //return(cornerRadius);
        }
        function draw() {
            _redraw();
        }
        function copySegmentsFrom(otherShape, shapeType) {
            _segments = new Array();
            if (otherShape.strokeSize > 0) {
                if (shapeType == "outer") {
                    if (otherShape.strokePosition == "outer") {
                        _segments = otherShape._strokeSegments.slice();
                    } else {
                        _segments = otherShape._segments.slice();
                    }
                } else if (otherShape.strokePosition == "outer") {
                    _segments = otherShape._segments.slice();
                } else {
                    _segments = otherShape._strokeSegments.slice();
                }
            } else {
                _segments = otherShape._segments.slice();
            }
        }
        function copyNodesFrom(otherShape) {
            _nodes = new Array();
            _nodes = otherShape._nodes.slice();
        }
        function get clip() {
            return(_clip);
        }
        function _redraw() {
            _segments = new Array();
            _points = new Array();
            _buildSegments(MAIN_PATH);
            _drawSegments(MAIN_PATH);
            if (strokeSize > 0) {
                _strokeSegments = new Array();
                _strokePoints = new Array();
                _calculateStrokeNodes();
                _buildSegments(STROKE_PATH);
                _drawSegments(STROKE_PATH);
            }
        }
        function _buildSegments(pathType) {
            if (pathType == MAIN_PATH) {
                var _local4 = _nodes;
                var _local17 = _segments;
                var _local8 = _points;
            } else {
                var _local4 = _strokeNodes;
                var _local17 = _strokeSegments;
                var _local8 = _strokePoints;
            }
            var _local3 = 0;
            while (_local3 < _local4.length) {
                var _local5 = _cornerRadius;
                if (_local4[_local3].customCornerRadius != undefined) {
                    _local5 = _local4[_local3].customCornerRadius;
                }
                var _local7 = (((_local3 - 1) >= 0) ? (_local4[_local3 - 1]) : (_local4[_local4.length - 1]));
                var _local2 = _local4[_local3];
                var _local6 = (((_local3 + 1) < _local4.length) ? (_local4[_local3 + 1]) : (_local4[0]));
                var _local10 = Math.sqrt(((_local7.x - _local2.x) * (_local7.x - _local2.x)) + ((_local7.y - _local2.y) * (_local7.y - _local2.y)));
                var _local9 = Math.sqrt(((_local2.x - _local6.x) * (_local2.x - _local6.x)) + ((_local2.y - _local6.y) * (_local2.y - _local6.y)));
                var _local23 = Math.sqrt(((_local6.x - _local7.x) * (_local6.x - _local7.x)) + ((_local6.y - _local7.y) * (_local6.y - _local7.y)));
                var _local16 = Math.acos((((_local10 * _local10) + (_local9 * _local9)) - (_local23 * _local23)) / ((2 * _local10) * _local9));
                if (((_local16 == Math.PI) || (isNaN(_local16))) || (Math.abs(_local16 - Math.PI) < 1E-5)) {
                    _local8.push({D:_local8[_local3 - 1].M, M:_local2, O:{}});
                    _local17.push({start:_local8[_local3 - 1].M, end:_local2, type:"line"});
                } else {
                    var _local22 = _local16 / 2;
                    var _local18 = Math.sin(_local22);
                    var _local24 = Math.cos(_local22);
                    var _local11 = _local18 / _local24;
                    var _local26 = _local5 / _local11;
                    var _local20 = _local5;
                    var _local19 = _local5;
                    if (_local26 > (_local10 / 2)) {
                        _local20 = (_local10 / 2) * _local11;
                    }
                    if (_local26 > (_local9 / 2)) {
                        _local19 = (_local9 / 2) * _local11;
                    }
                    _local5 = ((_local20 < _local19) ? (_local20) : (_local19));
                    var _local21 = _local5 / _local11;
                    var _local25 = _local5 / _local11;
                    var _local15 = (_local10 - _local21) / _local21;
                    var _local29 = {x:(_local7.x + (_local2.x * _local15)) / (1 + _local15), y:(_local7.y + (_local15 * _local2.y)) / (1 + _local15)};
                    var _local14 = (_local9 - _local25) / _local25;
                    var _local35 = {x:(_local6.x + (_local2.x * _local14)) / (1 + _local14), y:(_local6.y + (_local14 * _local2.y)) / (1 + _local14)};
                    var _local28 = {x:(_local29.x + _local35.x) / 2, y:(_local29.y + _local35.y) / 2};
                    var _local30 = _local5 / _local18;
                    var _local27 = _local21 * _local24;
                    var _local13 = _local27 / (_local30 - _local27);
                    var _local32 = {x:((_local28.x * (1 + _local13)) - _local2.x) / _local13, y:((_local28.y * (1 + _local13)) - _local2.y) / _local13};
                    _local2.O = _local32;
                    _local2.alpha = _local22;
                    _local2.R = _local5;
                    if (_local5 > 0) {
                        var _local12 = (1 / _local18) - 1;
                        var _local31 = {x:(_local2.x + (_local12 * _local32.x)) / (1 + _local12), y:(_local2.y + (_local12 * _local32.y)) / (1 + _local12)};
                        _local8.push({D:_local29, M:_local35, O:_local32});
                        if (_local3 > 0) {
                            _local17.push({start:_local8[_local3 - 1].M, end:_local29, type:"line"});
                        }
                        _local17.push({start:_local29, end:_local35, type:"curve", O:_local32, control:_local31, node:_local4[_local3], radius:_local5});
                        if (_local3 == (_local4.length - 1)) {
                            _local17.push({start:_local35, end:_local8[0].D, type:"line", O:_local32});
                        }
                    } else {
                        _local8.push({M:_local4[_local3]});
                        if (_local3 > 0) {
                            _local17.push({start:_local8[_local3 - 1].M, end:_local4[_local3], type:"line"});
                        }
                    }
                }
                _local3++;
            }
        }
        function _drawSegments(pathType) {
            if (pathType == MAIN_PATH) {
                var _local7 = _nodes;
                var _local3 = _segments;
                var _local8 = _points;
            } else {
                var _local7 = _strokeNodes;
                var _local3 = _strokeSegments;
                var _local8 = _strokePoints;
            }
            _clip.moveTo(_local3[0].start.x, _local3[0].start.y);
            var _local2 = 0;
            while (_local2 < _local3.length) {
                var _local4 = _local3[_local2].type;
                if (_local4 == "line") {
                    _clip.lineTo(_local3[_local2].end.x, _local3[_local2].end.y);
                } else {
                    _local4 = "curve";
                    if (_local4) {
                        var _local6 = -57.2957795130823 * Math.atan2(_local3[_local2].O.y - _local3[_local2].start.y, _local3[_local2].start.x - _local3[_local2].O.x);
                        var _local5 = -57.2957795130823 * Math.atan2(_local3[_local2].O.y - _local3[_local2].end.y, _local3[_local2].end.x - _local3[_local2].O.x);
                        drawSegment(_clip, _local3[_local2].radius, _local3[_local2].radius, _local3[_local2].O.x, _local3[_local2].O.y, 4, _local6, _local5);
                    } else {
                        _clip.curveTo(_local3[_local2].control.x, _local3[_local2].control.y, _local3[_local2].end.x, _local3[_local2].end.y);
                    }
                }
                _local2++;
            }
        }
        function drawSegment(target, rx, ry, x, y, sgm, s1, s2) {
            var _local1 = (Math.PI/180);
            if (s1 < 0) {
                s1 = s1 + 360;
            }
            if (s2 < 0) {
                s2 = s2 + 360;
            }
            var _local17 = s2 - s1;
            var _local20 = s2 > s1;
            var _local21 = Math.abs(_local17);
            if (_local21 > (360 - _local21)) {
                _local20 = !_local20;
            }
            if (_local20 && (s2 < s1)) {
                s2 = s2 + 360;
            }
            if ((!_local20) && (s2 > s1)) {
                s2 = s2 - 360;
            }
            _local17 = s2 - s1;
            var _local2 = _local17 / sgm;
            var _local8 = (rx * Math.cos(s1 * _local1)) + x;
            var _local7 = (ry * Math.sin(s1 * _local1)) + y;
            if (_local20) {
                var _local3 = s1 + _local2;
                while (_local3 < ((s1 + _local17) + 0.1)) {
                    var _local14 = (rx * Math.cos((_local3 - (_local2 / 2)) * _local1)) + x;
                    var _local13 = (ry * Math.sin((_local3 - (_local2 / 2)) * _local1)) + y;
                    var _local5 = (rx * Math.cos(_local3 * _local1)) + x;
                    var _local6 = (ry * Math.sin(_local3 * _local1)) + y;
                    var _local16 = (2 * _local14) - (0.5 * (_local8 + _local5));
                    var _local15 = (2 * _local13) - (0.5 * (_local7 + _local6));
                    target.curveTo(_local16, _local15, _local5, _local6);
                    _local8 = _local5;
                    _local7 = _local6;
                    _local3 = _local3 + _local2;
                }
            } else {
                var _local3 = s1 + _local2;
                while (_local3 > ((s1 + _local17) - 0.1)) {
                    var _local14 = (rx * Math.cos((_local3 - (_local2 / 2)) * _local1)) + x;
                    var _local13 = (ry * Math.sin((_local3 - (_local2 / 2)) * _local1)) + y;
                    var _local5 = (rx * Math.cos(_local3 * _local1)) + x;
                    var _local6 = (ry * Math.sin(_local3 * _local1)) + y;
                    var _local16 = (2 * _local14) - (0.5 * (_local8 + _local5));
                    var _local15 = (2 * _local13) - (0.5 * (_local7 + _local6));
                    target.curveTo(_local16, _local15, _local5, _local6);
                    _local8 = _local5;
                    _local7 = _local6;
                    _local3 = _local3 + _local2;
                }
            }
        }
        function _calculateStrokeNodes() {
            var _local21 = _nodes.length;
            if (strokePosition == "inner") {
                var _local22 = -strokeSize;
            } else {
                var _local22 = strokeSize;
            }
            var _local11 = 1;
            var _local3 = 0;
            while (_local3 < _local21) {
                var _local2 = _nodes[_local3];
                var _local6 = ((_local3 != 0) ? (_nodes[_local3 - 1]) : (_nodes[_local21 - 1]));
                var _local5 = ((_local3 != (_local21 - 1)) ? (_nodes[_local3 + 1]) : (_nodes[0]));
                if (_local2.alpha != undefined) {
                    var _local10 = _local2.x - _local6.x;
                    var _local9 = _local2.y - _local6.y;
                    var _local12 = Math.sqrt((_local10 * _local10) + (_local9 * _local9));
                    var _local17 = {x:_local10 / _local12, y:_local9 / _local12};
                    var _local8 = _local2.x - _local5.x;
                    var _local7 = _local2.y - _local5.y;
                    var _local19 = Math.sqrt((_local8 * _local8) + (_local7 * _local7));
                    var _local14 = {x:_local8 / _local19, y:_local7 / _local19};
                    var _local4 = {x:_local17.x + _local14.x, y:_local17.y + _local14.y};
                    var _local18 = Math.sqrt((_local4.x * _local4.x) + (_local4.y * _local4.y));
                    var _local23 = (_local10 * _local7) - (_local9 * _local8);
                    ((_local23 <= 0) ? (_local11 = 1) : (_local11 = -1));
                    var _local25 = Math.sin(_local2.alpha);
                    var _local13 = (_local11 * _local22) / _local25;
                    var _local16 = {x:(_local13 * _local4.x) / _local18, y:(_local13 * _local4.y) / _local18};
                    var _local24 = _local2.R + (_local11 * _local22);
                    _strokeNodes[_local3] = {x:_local2.x + _local16.x, y:_local2.y + _local16.y, customCornerRadius:_local24};
                } else {
                    var _local13 = -_local22;
                    var _local15 = (Math.PI/2) - Math.atan((_local5.y - _local6.y) / (_local5.x - _local6.x));
                    var _local20 = {x:_local2.x - (_local13 * Math.cos(_local15)), y:_local2.y + (_local13 * Math.sin(_local15))};
                    _strokeNodes[_local3] = {x:_local20.x, y:_local20.y};
                }
                _local3++;
            }
        }
        var MAIN_PATH = 1;
        var STROKE_PATH = 2;
        var _cornerRadius = 0;
        var strokePosition = "inner";
        var strokeSize = 0;
    }
