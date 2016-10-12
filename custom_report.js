setTimeout(get_json(), 1000)


function get_json() {
	
	//get json
	$.ajax({
		url: "http://www.behk.org/custom_report.json",
		dataType: "json",
		success: function(data){
			report_builder(data);
		}
	});

}

function report_builder(data) {
	var view_user_id = $('#nav_menu_right').find('li').eq(5).find('a').attr('href').split('/')[1];
	var rl = [];
	rl = data;
	var html_builder = '';
	var option_builter = '';
	var found = false;
	var counter = 0;
	var has_param = false;
	var param_index = [];
	var local_sql_list = [];
	for(var i in rl) {
		if(rl[i]["view_user"].length > 0) {
			found = true;
			for(var j in rl[i]["view_user"]) {
				if(rl[i]["view_user"][j] == view_user_id) {
					//alert(rl[i]["report_name"]);
					counter++;
					option_builter += '<option value="' + counter + '">' + rl[i]["report_name"] + '</option>';
					if(rl[i]["param"] == '1') {
						has_param = true;
						param_index.push(counter.toString());
						
					}
					var temp = {};
					temp["option_index"] = counter.toString();
					temp["sql"] = rl[i]["report_sql"];
					local_sql_list.push(temp);
				}
			}
		}

		else {
			found = true;
			counter++;
			option_builter += '<option value="' + counter + '">' + rl[i]["report_name"] + '</option>';
			if(rl[i]["param"] == '1') {
				has_param = true;
				param_index.push(counter.toString());
				
			}
			var temp = {};
			temp["option_index"] = counter.toString();
			temp["sql"] = rl[i]["report_sql"];
			local_sql_list.push(temp);
		}
	}
	if(found) {
		$('textarea').css('float', 'left');
		html_builder = '<select id = "report_list" style="margin: 0 5px;"><option value="0">选择报表 - Select report</option>';
		html_builder += option_builter;
		html_builder += '</select><input placeholder="From (yyyy-mm-dd)" id = "param_1" type="text" style="margin: 0 5px; display:none;" class="date-picker" data-date-format="yyyy-mm-dd"><input placeholder="To (yyyy-mm-dd)" id = "param_2" type="text" style="margin: 0 5px; display:none;" class="date-picker" data-date-format="yyyy-mm-dd"><button type="button" class="btn red ng-binding" id="run_report">Run report</button>';
		$('textarea').after(html_builder);
	}

	$("#report_list").change(function(){
		$("#param_1").val('');
		$("#param_2").val('');
		if(param_index.indexOf($(this).val()) > -1) {
			//alert('c:' + $(this).val());
			$("#param_1").show();
			$("#param_2").show();
		}
		else {
			$("#param_1").hide();
			$("#param_2").hide();
		}
	})

	$("#run_report").click(function(){
		$("#custom_sql").val('');
		var sql = "";
		if(local_sql_list.length > 0){
			for(var s in local_sql_list){
				if(local_sql_list[s]["option_index"] == $("#report_list").val()) {
					sql = local_sql_list[s]["sql"];
					if($("#param_1").val().length>0) {
						sql = sql.replace(/param_1/g, "'" + $("#param_1").val() + "'");
					}
					if($("#param_2").val().length>0) {
						sql = sql.replace(/param_2/g, "'" + $("#param_2").val() + "'");
					}
					$("#custom_sql").val(sql);
				}
			}
		}
		$("button").eq(1).click();
	})	

	$('.date-picker').datepicker();
}