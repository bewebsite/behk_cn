
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.graphics.StyleableLabel extends com.fb.graphics.StyleableObject
    {
        var _contentTextField, _contentClip, _text, __set__color, colorTo, _fontName, _dropShadowClip, _dropShadowTextField, _innerShadowClip, _innerShadowTextField, _gradientMaskClip, _gradientMaskTextField, _rootClip, _dropShadowDepth, _innerShadowDepth, _gradientMaskDepth, _strokeClip;
        function StyleableLabel (clip) {
            super(clip);
            _contentTextField = _contentClip.createTextField("contentText", 0, 0, 0, _width, _height);
            _contentTextField.addListener(this);
            _contentTextField.onSetFocus = mx.utils.Delegate.create(this, onSetFocus);
            _contentTextField.onKillFocus = mx.utils.Delegate.create(this, onKillFocus);
            Key.addListener(this);
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function setFocus() {
            Selection.setFocus(_contentTextField);
        }
        function get textWidth() {
            return(_contentTextField.textWidth);
        }
        function get textHeight() {
            return(_contentTextField.textHeight);
        }
        function get maxChars() {
            return(_maxChars);
        }
        function set maxChars(numberOfChars) {
            _maxChars = numberOfChars;
            _drawTextField();
            //return(maxChars);
        }
        function get restrict() {
            return(_restrict);
        }
        function set restrict(restrictChars) {
            _restrict = restrictChars;
            _drawTextField();
            //return(restrict);
        }
        function get antiAliasType() {
            return(_antiAliasType);
        }
        function set antiAliasType(newType) {
            _antiAliasType = newType;
            _drawTextField();
            //return(antiAliasType);
        }
        function get text() {
            return(_text);
        }
        function set text(newText) {
            _text = newText;
            _drawTextField();
            //return(text);
        }
        function setSize(newWidth, newHeight) {
            _width = newWidth;
            _height = newHeight;
            _drawTextField();
        }
        function get width() {
            return(_width);
        }
        function set width(newWidth) {
            _width = newWidth;
            _drawTextField();
            //return(width);
        }
        function get height() {
            return(_height);
        }
        function set height(newHeight) {
            _height = newHeight;
            _drawTextField();
            //return(height);
        }
        function get fontSize() {
            return(_fontSize);
        }
        function set fontSize(newSize) {
            _fontSize = newSize;
            _drawTextFormat();
            //return(fontSize);
        }
        function get fontColor() {
            return(_fontColor);
        }
        function set fontColor(newColor) {
            _fontColor = newColor;
            __set__color(_fontColor);
            //return(fontColor);
        }
        function fontColorTo(newColor, duration, delay) {
            colorTo(newColor, duration, delay);
        }
        function get fontName() {
            if (_fontName != undefined) {
                return(_fontName);
            } else {
                return(_contentTextField.getTextFormat().font);
            }
        }
        function set fontName(newName) {
            _fontName = newName;
            _drawTextFormat();
            //return(fontName);
        }
        function get embedFonts() {
            return(_embedFonts);
        }
        function set embedFonts(embed) {
            _embedFonts = embed;
            _drawTextField();
            _drawTextFormat();
            //return(embedFonts);
        }
        function get type() {
            return(_type);
        }
        function set type(newType) {
            _type = newType;
            _drawTextField();
            //return(type);
        }
        function get multiline() {
            return(_multiline);
        }
        function set multiline(isMultiline) {
            _multiline = isMultiline;
            _drawTextField();
            //return(multiline);
        }
        function get selectable() {
            return(_selectable);
        }
        function set selectable(isSelectable) {
            _selectable = isSelectable;
            _drawTextField();
            //return(selectable);
        }
        function get wordWrap() {
            return(_wordWrap);
        }
        function set wordWrap(wrap) {
            _wordWrap = wrap;
            _drawTextField();
            //return(wordWrap);
        }
        function get align() {
            return(_align);
        }
        function set align(newAlign) {
            _align = newAlign;
            _drawTextFormat();
            //return(align);
        }
        function get autoSize() {
            return(_autoSize);
        }
        function set autoSize(doAutoSize) {
            _autoSize = doAutoSize;
            _drawTextField();
            //return(autoSize);
        }
        function get length() {
            return(_contentTextField.text.length);
        }
        function set bold(isBold) {
            _bold = isBold;
            _drawTextFormat();
            //return(bold);
        }
        function get bold() {
            return(_bold);
        }
        function _drawTextField() {
            applyTextFieldSettings(_contentTextField);
            if (_dropShadowClip != undefined) {
                applyTextFieldSettings(_dropShadowTextField);
            }
            if (_innerShadowClip != undefined) {
                applyTextFieldSettings(_innerShadowTextField);
            }
            if (_gradientMaskClip != undefined) {
                applyTextFieldSettings(_gradientMaskTextField);
            }
        }
        function _drawTextFormat() {
            applyTextFormatSettings(_contentTextField);
            if (_dropShadowClip != undefined) {
                applyTextFormatSettings(_dropShadowTextField);
            }
            if (_innerShadowClip != undefined) {
                applyTextFormatSettings(_innerShadowTextField);
            }
            if (_gradientMaskClip != undefined) {
                applyTextFormatSettings(_gradientMaskTextField);
            }
        }
        function _createDropShadowClip() {
            if (_dropShadowClip == undefined) {
                _dropShadowClip = _rootClip.createEmptyMovieClip("dropShadowText", _dropShadowDepth);
                _dropShadowTextField = _dropShadowClip.createTextField("dropShadowText", 0, 0, 0, _width, _height);
                _dropShadowTextField.addListener(this);
                applyTextFieldSettings(_dropShadowTextField);
                applyTextFormatSettings(_dropShadowTextField);
            }
        }
        function _createInnerShadowClip() {
            if (_innerShadowClip == undefined) {
                _innerShadowClip = _rootClip.createEmptyMovieClip("innerShadowText", _innerShadowDepth);
                _innerShadowTextField = _innerShadowClip.createTextField("innerShadowText", 0, 0, 0, _width, _height);
                _innerShadowTextField.addListener(this);
                applyTextFieldSettings(_innerShadowTextField);
                applyTextFormatSettings(_innerShadowTextField);
            }
        }
        function _createGradientMaskClip() {
            if (_gradientMaskClip == undefined) {
                _gradientMaskClip = _rootClip.createEmptyMovieClip("gradientMaskText", _gradientMaskDepth);
                _gradientMaskTextField = _gradientMaskClip.createTextField("gradientMaskText", 0, 0, 0, _width, _height);
                _gradientMaskTextField.addListener(this);
                applyTextFieldSettings(_gradientMaskTextField);
                applyTextFormatSettings(_gradientMaskTextField);
            }
        }
        function _createStrokeClip() {
            if (_strokeClip == undefined) {
            }
        }
        function applyTextFormatSettings(targetTextField) {
            var _local2 = new TextFormat();
            _local2.size = _fontSize;
            _local2["color"] = _fontColor;
            _local2.font = _fontName;
            _local2.align = _align;
            _local2.bold = _bold;
            targetTextField.setTextFormat(_local2);
            targetTextField.setNewTextFormat(_local2);
        }
        function applyTextFieldSettings(targetTextField) {
            targetTextField.text = _text;
            targetTextField.type = _type;
            targetTextField.selectable = _selectable;
            targetTextField.wordWrap = _wordWrap;
            targetTextField.multiline = _multiline;
            targetTextField._width = _width;
            targetTextField._height = _height;
            targetTextField.embedFonts = _embedFonts;
            targetTextField.autoSize = _autoSize;
            targetTextField.antiAliasType = _antiAliasType;
            targetTextField.maxChars = _maxChars;
            targetTextField.restrict = _restrict;
        }
        function onChanged(changedTextField) {
            _text = changedTextField.text;
            _drawTextField();
            _drawTextFormat();
        }
        function onSetFocus(oldFocus) {
            dispatchEvent({type:"onSetFocus", oldFocus:oldFocus});
        }
        function onKillFocus(newFocus) {
            dispatchEvent({type:"onKillFocus", newFocus:newFocus});
        }
        function onKeyDown() {
            dispatchEvent({type:"onKeyDown"});
        }
        function onKeyUp() {
            dispatchEvent({type:"onKeyUp"});
        }
        var _width = 100;
        var _height = 25;
        var _fontSize = 12;
        var _fontColor = 0;
        var _embedFonts = false;
        var _type = "input";
        var _multiline = false;
        var _selectable = false;
        var _wordWrap = false;
        var _align = "left";
        var _antiAliasType = "normal";
        var _autoSize = false;
        var _maxChars = null;
        var _restrict = null;
        var _bold = false;
    }
