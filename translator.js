/*Global variables*/
var enStr_list = [];				// General Dictionary: translation.json
var msg_enStr_list = [];			// Message Dictionary: msg_translation.json
var variable_enStr_list = [];		// Variable Dictionary: varible_translation.json
var msg_variable_enStr_list = [];	// Message Variable Dictionary: msg_variable_translation.json
// Settings: shr_user.json					
var english_user_list = [];	
var pro_user_list = [];
var ignore = [];
var tag_list = [];
var cls_list = [];	
var id_list = [];
// Login user types
var is_trans_user = false;
var is_pro_user = false;


/*Functions that get JSON files from remote server*/
// Get general dictionary
function get_dict() {
	$.ajax({
		url: "http://www.behk.org/translation.json",
		dataType: "json",
		async: false,
		success: function(data){
			enStr_list = data;
		}
	});
}

// Get variable dictionary
function get_variable_dict() {
	$.ajax({
		url: "http://www.behk.org/varible_translation.json",
		dataType: "json",
		async: false,
		success: function(data){
			variable_enStr_list = data.sort(function(a, b) {return b.cn.length-a.cn.length});
		}
	});
}

// Get message dictionary
function get_msg_dict() {
	$.ajax({
		url: "http://www.behk.org/msg_translation.json",
		dataType: "json",
		async: false,
		success: function(data){
			msg_enStr_list = data;
		}
	});
}

// Get message variable dictionary
function get_msg_variable_dict() {
	$.ajax({
		url: "http://www.behk.org/msg_variable_translation.json",
		dataType: "json",
		async: false,
		success: function(data){
			msg_variable_enStr_list = data;
		}
	});
}

// Get settings
function get_settings() {
	$.ajax({
		url: "http://www.behk.org/shr_user.json",
		dataType: "json",
		async: false,
		success: function(data){
			english_user_list = data[0].trans;
			pro_user_list = data[0].pro;
			tag_list = data[0].tag_list;
			ignore = data[0].ignore;
			cls_list = data[0].class;
			id_list = data[0].id;
		}
	});
}


/*Functions that identify Pro and Translation user*/ 
// Check if login user is Pro User
function is_Pro(user_list) {
	if (user_list.indexOf($("#user_name").text()) >= 0) {
		return true;
	} else {
		return false;
	}
}

// Check if login user is Trans User
function is_Trans(user_list) {
	if ($("#user_name").text() != "" && user_list.indexOf($("#user_name").text()) < 0) {
        return true;
    } else {
    	return false;
    }
}


/*Hide menus for certain users*/
function hide_menu(is_pro_user) {
    if (!is_pro_user) {
        $(".s-icon-org").hide();
        $(".s-icon-emp").hide();
        $(".s-icon-comp").hide();
        $(".s-icon-holidayManage").hide();
        $(".s-icon-atsManager").hide();
        $(".s-icon-recruitment").hide();
        $(".s-icon-train").hide();
        $(".s-icon-perf").hide();
        $(".s-icon-report").hide();
        $(".s-icon-setting").hide();
        $("#messages").hide();
        $("#evaluate").hide();
        $("#feedback").hide();
        $("#forum").hide();
        $("#lan_switch").css("margin-top", "200px");
    } 
}


/*Translator Functions*/
// General Translator
function translator(dt_name) {
	if (localStorage.getItem("is_trans_user") == "yes") {

		var cnStr_list = [];

		$("*").each(function(index){
			if ($(this).clone().children().remove().end().text().trim() != "" && 
				ignore.indexOf($(this).clone().children().remove().end().context.tagName) < 0 &&
				$(this).clone().children().remove().end().attr('id') != "zwm") {
				if ($(this).clone().children().remove().end().text().indexOf("温馨提示") >= 0 || $(this).clone().children().remove().end().text().indexOf("3. 使用场景") >= 0) {
					cnStr_list.push({'cn': $(this).html().trim(), 'index': index});
				} else {
					cnStr_list.push({'cn': $(this).clone().children().remove().end().text().trim(), 'index': index});
				}
				
			}
		})
		console.log(dt_name + ' <- dt name    ' + 'dictionary loading complete, total: ' + cnStr_list.length);

		// Do translation
		var count = do_translation(cnStr_list);

		// Translate iframes
		if (dt_name == 'skip') return 999;
		if ($("#resume-content").length > 0) return 999;

		if ($("#operationDialog-frame").length > 0) {
			document.getElementById("operationDialog-frame").onload=function(){
				iframe_translator("operationDialog-frame");
			}
			iframe_translator("operationDialog-frame");
		}
		if ($("#resume-001").length > 0) {
			document.getElementById("resume-001").onload=function(){
				iframe_translator("resume-001");
			}
			iframe_translator("resume-001");
		}
		if ($("#resume-002").length > 0) {
			document.getElementById("resume-002").onload=function(){
				iframe_translator("resume-002");
			}
			iframe_translator("resume-002");
		}
		if ($("#resume-003").length > 0) {
			document.getElementById("resume-003").onload=function(){
				iframe_translator("resume-003");
			}
			iframe_translator("resume-003");
		}
		if ($("#approve-bill-view").length > 0) {
			document.getElementById("approve-bill-view").onload=function(){
				iframe_translator("approve-bill-view");
			}
			iframe_translator("approve-bill-view");
		}
		if ($("#orgFillDiv").length > 0) {
			document.getElementById("orgFillDiv").onload=function(){
				iframe_translator("orgFillDiv");
			}
			iframe_translator("orgFillDiv");
		}

		return count;
	}
	return 999;
}

// iframe Translator
function iframe_translator(iframe_id) {
	if (localStorage.getItem("is_trans_user") == "yes") {

		var iframe_cnStr_list = [];
		var ele = document.getElementById(iframe_id);

		if(window.frames[iframe_id].document != undefined) {
			window.frames[iframe_id].document.body.onclick=function(event){

		    	var skip_trans = false;
				if(tag_list.indexOf(event.target.tagName) >= 0) {
					console.log($(event.target).attr("role"));
					if(event.target.tagName == "SPAN") {
						console.log("class: "+event.target.className);
						var class_list = event.target.className.split(" ");
						for(var cls in class_list) {
							console.log('cls:  '+class_list[cls]);
							if(cls_list.indexOf(class_list[cls]) >= 0) {
								console.log('skip trans');
								skip_trans = true;
								break;
							}
						}

					}
					console.log('delay trans');
					if(!skip_trans) {//defer_translator();
						//ClearAllIntervals();
						var dt_iframeclick = Object.create(DeferTranslator);
						dt_iframeclick.set_name('dt_iframeclick');
						dt_iframeclick.defer_translator();
					}
				}
				console.log('click: ' + event.target.tagName);
			}
		}
		

		
/*		$(ele.contentWindow.document).find("*").each(function(index2){
			if ($(this).clone().children().remove().end().text().trim() != "" && ignore.indexOf($(this).clone().children().remove().end().context.tagName) < 0) {
				iframe_cnStr_list.push({'cn': $(this).clone().children().remove().end().text().trim(), 'index': index2});
			}
		})

		var count = do_translation(iframe_cnStr_list);*/

	}
}

// Do translation
function do_translation(cnStr_list) {
	var count = 0;
	for (var i in cnStr_list) {
		var is_translated = false;
		// Text contains RETURN's
		if (cnStr_list[i]['cn'].indexOf('\n') >= 0) {
			var temp_list = [];
			temp_list = cnStr_list[i]['cn'].split('\n');
			for(var k in temp_list) {
				for (var j in enStr_list) {
					if (temp_list[k].trim() == enStr_list[j]['cn']) {
						//console.log(j+': '+$('*').eq(cnStr_list[i]['index']).html());
						//$('*').eq(cnStr_list[i]['index']).html($('*').eq(cnStr_list[i]['index']).html().replace(temp_list[k].trim(), enStr_list[j]['en']));
						$('*').eq(cnStr_list[i]['index'])[0].innerHTML = $('*').eq(cnStr_list[i]['index'])[0].innerHTML.replace(temp_list[k].trim(), enStr_list[j]['en']);
						count += 1;
						is_translated = true;
					}		
				}
			}
		} else {
			for (var j in enStr_list) {
				// Full match
				if (cnStr_list[i]['cn'] == enStr_list[j]['cn']) {
					console.log('match found.:' + cnStr_list[i]['cn'] + ' : ' + enStr_list[j]['en']);
					// HARDCODE HERE! Deal with Valid & Activate
					if (cnStr_list[i]['cn'] == "启用" && $('*').eq(cnStr_list[i]['index'])[0].tagName == "BUTTON") {
						//$('*').eq(cnStr_list[i]['index']).html($('*').eq(cnStr_list[i]['index']).html().replace(cnStr_list[i]['cn'], "Activate"));
						$('*').eq(cnStr_list[i]['index'])[0].innerHTML = $('*').eq(cnStr_list[i]['index'])[0].innerHTML.replace(cnStr_list[i]['cn'], "Activate");
					}
					// Replace CN with EN
					else {
						// HARDCODE HERE! Deal with >>
						if ($('*').eq(cnStr_list[i]['index']).html().indexOf("&gt;") >= 0) {
							$('*').eq(cnStr_list[i]['index']).html($('*').eq(cnStr_list[i]['index']).text().replace(cnStr_list[i]['cn'], enStr_list[j]['en']));
							//$('*').eq(cnStr_list[i]['index'])[0].innerHTML = $('*').eq(cnStr_list[i]['index'])[0].innerHTML.replace(cnStr_list[i]['cn'], enStr_list[j]['en']);
						} else {
							//$('*').eq(cnStr_list[i]['index']).html($('*').eq(cnStr_list[i]['index']).html().replace(cnStr_list[i]['cn'], enStr_list[j]['en']));
							if ($('*').eq(cnStr_list[i]['index'])[0].tagName == "DD") {
								$('*').eq(cnStr_list[i]['index'])[0].insertAdjacentHTML('beforeend', enStr_list[j]['en']);
							} else {
								$('*').eq(cnStr_list[i]['index'])[0].innerHTML = $('*').eq(cnStr_list[i]['index'])[0].innerHTML.replace(cnStr_list[i]['cn'], enStr_list[j]['en']);
							}
						}
						
					}
					count += 1;
					is_translated = true;
				}		
			}
		}
		// Translate variables
		if (!is_translated) {
			var str_temp = cnStr_list[i]['cn'];
			var is_replaced = false;
			for (var k in variable_enStr_list) {
				
				if (cnStr_list[i]['cn'].indexOf(variable_enStr_list[k]['cn']) >= 0) {
					str_temp = str_temp.replace(variable_enStr_list[k]['cn'], variable_enStr_list[k]['en']);
					is_replaced = true;
				}
				
			}
			if (is_replaced) {

				//$('*').eq(cnStr_list[i]['index']).html($('*').eq(cnStr_list[i]['index']).html().replace(cnStr_list[i]['cn'], str_temp));
				$('*').eq(cnStr_list[i]['index'])[0].innerHTML = $('*').eq(cnStr_list[i]['index'])[0].innerHTML.replace(/&nbsp;/g, ' ').replace(cnStr_list[i]['cn'].replace(/&nbsp;/g, ' '), str_temp);
				count += 1;
			}
		}
	}
	return count;
}

// Message Translator
function msg_translator(msg) {
	if (localStorage.getItem("is_trans_user") == "yes" && msg != null) {
		if (msg.indexOf("<br>") >= 0 || msg.indexOf("<br/>") >= 0 || msg.indexOf("</br>") >= 0) {
			// Message contains <br>
			// Translate variables
			for (var m in msg_variable_enStr_list) {
				if (msg.indexOf(msg_variable_enStr_list[m]['cn']) >= 0) {
					msg = msg.replace(msg_variable_enStr_list[m]['cn'], msg_variable_enStr_list[m]['en']);
				}
			}
		} else {
			var is_translated = false;
			for (var i in msg_enStr_list) {
				if (msg == msg_enStr_list[i]['cn']) {
					msg = msg_enStr_list[i]['en'];
					is_translated = true;
				}
			}
			// Try Message Variable Dictionary
			if (!is_translated) {
				for (var m in msg_variable_enStr_list) {
					if (msg.indexOf(msg_variable_enStr_list[m]['cn']) >= 0) {
						msg = msg.replace(msg_variable_enStr_list[m]['cn'], msg_variable_enStr_list[m]['en']);
					}
				}
			}
		}
	}
	return msg;
}

// Message button Translator
function msg_btn_translator(msg) {
	if (localStorage.getItem("is_trans_user") == "yes") {
		msg = msg.replace("<br>", "");
		var en_list = [{'cn': '确认', 'en': 'Confirm'}, {'cn': '取消', 'en': 'Cancel'}];
		for (var i in en_list) {
			if (msg == en_list[i]['cn']) {
				msg = en_list[i]['en'];
			}
		}
	} 
	return msg;
}


/*Interval Translator*/
var DeferTranslator = {
	_name : '',
	_int : null,
	_timer : 0,
	_max : 2,

	get_name : function() {
		return this._name;
	},

	set_name : function(e) {
		this._name = e;
	},

	get_max : function() {
		return this._max;
	},

	set_max : function(e) {
		this._max = e;
	},

	get_int : function() {
		return this._int;
	},

	defer_translator : function() {
		if (localStorage.getItem("is_trans_user") == "yes") {
			var timer = this._timer;
			var name = this._name;
			var max = this._max;
			var translated_num = 0;

			var int = setInterval(function() {
				// Translate page
				translated_num = translator(name+' '+int);
				console.log('interval: ' + name + ' times: ' + timer + ' translated: ' + translated_num);

				if (timer >= max || translated_num > 1) {
					window.clearInterval(int);
					console.log('timer stopped: ' + name);
				}
				timer++;
				console.log('interval completed:' + timer);
				console.log('translated.' + translated_num);
			}, 500);
			this._int = int;
		}
	}
};


/*Clear all intervals*/
function ClearAllIntervals() {
    for(var i in localStorage.getItem('running_interval')) {
    	window.clearInterval(localStorage.getItem('running_interval')[i]);
    }
}


/*Add language switch*/
function append_lan() {

	if (is_trans_user) {
		var str_html = "<div id='lan_switch'><i style='background: url(\"http:\/\/www.behk.org\/cn.png\") no-repeat;'></i>中文</div>";
	} else {
		var str_html = "<div id='lan_switch'><i style='background: url(\"http:\/\/www.behk.org\/en.png\") no-repeat;'></i>ENG</div>";
	}
	$('#forum').after(str_html);

	$("#lan_switch").click(function(){
		if (is_trans_user) {
			localStorage.setItem("is_trans_user", "no");
		} else {
			localStorage.setItem("is_trans_user", "yes");
		}
		window.location.href =window.location .href;
	});
}

/*Init*/
$(window).load(function(){ 
	// Global variables
	get_dict();					// General Dictionary
	get_msg_dict();				// Message Dictionary
	get_variable_dict();		// Variable Dictionary
	get_msg_variable_dict();	// Message Variable Dictionary
	get_settings();				// Variables for Settings

	//is_trans_user = is_Trans(english_user_list);
	is_pro_user = is_Pro(pro_user_list);

	if (localStorage.getItem("is_trans_user") == null) {
		localStorage.setItem("is_trans_user", "yes");
	}
	if (localStorage.getItem("is_trans_user") == "yes") {
		is_trans_user = true;
	}
	// Append language switch to sidebar
	append_lan();

	// Hide menu if necessary
	hide_menu(is_pro_user);

	var dt_homepage = Object.create(DeferTranslator);
	dt_homepage.set_name('dt_homepage');
	dt_homepage.defer_translator();

	// Bind <body> click event
	document.body.onmousedown = function(event){

		console.log('element got clicked: ' + event.target.tagName);
    	var skip_trans = false;
		if(tag_list.indexOf(event.target.tagName) >= 0) {
			// Stop timer when elements in 'tag_list' clicked
			// Ignore when CLASS of SPAN in 'cls_list'
			
			if(["SPAN"].indexOf(event.target.tagName) >= 0) {
				console.log('ignore when CLASS of SPAN in: ' + cls_list);
				var class_list = event.target.className.split(" ");
				for(var cls in class_list) {
					if(cls_list.indexOf(class_list[cls]) >= 0) {
						console.log('skip trans on: ' + class_list[cls]);
						skip_trans = true;
					}
				}
			} else if(["I"].indexOf(event.target.tagName) >= 0) {
				console.log('ignore when ID of I in: ' + id_list);
				if(id_list.indexOf(event.target.id) >= 0) {
					console.log('skip trans on: ' + event.target.id);
					skip_trans = true;
				}
				
			}

			if(!skip_trans) {
				var dt_bodyclick = Object.create(DeferTranslator);
				dt_bodyclick.set_name('dt_bodyclick');
				dt_bodyclick.defer_translator();
			}
		}
	};
});