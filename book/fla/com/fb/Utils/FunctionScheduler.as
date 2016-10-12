
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.FunctionScheduler
    {
        var _tasksList, _taskInterval;
        function FunctionScheduler () {
            _tasksList = new Array();
        }
        function add(objectReference, functionName, msec_delay) {
            var _local4 = new Object();
            _local4.thisObject = objectReference;
            _local4.functionName = functionName;
            _local4.delay = msec_delay;
            _local4.arguments = new Array();
            var _local3 = 3;
            while (_local3 < arguments.length) {
                _local4.arguments.push(arguments[_local3]);
                _local3++;
            }
            _tasksList.push(_local4);
        }
        function start() {
            _executeFunction();
        }
        function reset() {
            if (_taskInterval) {
                clearInterval(_taskInterval);
            }
            _tasksList = new Array();
        }
        function _executeFunction() {
            if (_taskInterval) {
                clearInterval(_taskInterval);
            }
            var _local2 = _tasksList[0];
            var _local3 = _local2.thisObject;
            var _local4 = _local3[_local2.functionName];
            var _local5 = _local2.delay;
            _local4.apply(_local3, _local2.arguments);
            _tasksList.splice(0, 1);
            if (_tasksList.length > 0) {
                _taskInterval = setInterval(this, "_executeFunction", _local5);
            }
        }
    }
