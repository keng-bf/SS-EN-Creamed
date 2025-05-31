function NSP_check_saved(argument0) {
	return (argument0[|2] != 0);
}
function NSP_evaluate(argument0) {
	var nspListStr, nspListPar,
	    nspToken = global.nspToken;
	var rv, succ;

	if (argument0 == "") return "";

	nspListStr = ds_list_create();
	nspListPar = ds_list_create();

	succ = nsp_convert_to_list(argument0, nspListStr, nspListPar);

	if (!succ) {

	  NSP_notify("SCRIPT: NSP_evaluate. ERROR: String will not be evaluated because it could not be converted.");

	  ds_list_destroy(nspListStr);
	  ds_list_destroy(nspListPar);
  
	  return nspToken[NSP_TOK.abort];
  
	  }

	rv = nsp_evaluate_list(0, ds_list_size(nspListStr)-1, nspListStr, nspListPar);

	//SQ:
	if is_string(rv) and nsp_is_string(rv)
	 rv=string_copy(rv,2,string_length(rv)-2);

	ds_list_destroy(nspListStr);
	ds_list_destroy(nspListPar);

	return rv;



}
function NSP_evaluate_saved(argument0) {
	var nspListStr = ds_list_create(),
	    nspListPar = ds_list_create();
	    nspToken   = global.nspToken;
	var rv;

	if (argument0[|2] == 0) {

	  ds_list_destroy(nspListStr);
	  ds_list_destroy(nspListPar);

	  NSP_notify("SCRIPT: NSP_evaluate_saved. ERROR: Input did not pass validation.");
	  return nspToken[NSP_TOK.abort];

	  }

	ds_list_copy(nspListStr, argument0[|0]);
	ds_list_copy(nspListPar, argument0[|1]);

	rv = nsp_evaluate_list(0, ds_list_size(nspListStr)-1, nspListStr, nspListPar);

	//SQ:
	if (is_string(rv) and nsp_is_string(rv))
	 rv = string_copy(rv, 2, string_length(rv)-2);

	ds_list_destroy(nspListStr);
	ds_list_destroy(nspListPar);

	return rv;



}
function NSP_execute_saved(argument0) {
	var nspListStr = ds_list_create(),
	    nspListPar = ds_list_create(),
	    rv;

	if (argument0[|2] == 0) {

	  ds_list_destroy(nspListStr);
	  ds_list_destroy(nspListPar);
  
	  NSP_notify("SCRIPT: NSP_execute_saved. ERROR: Input did not pass validation.");
	  return undefined;

	  }
    
	ds_list_copy(nspListStr, argument0[|0]);
	ds_list_copy(nspListPar, argument0[|1]);

	rv = nsp_execute_master(0, ds_list_size(nspListStr)-1, false, nspListStr, nspListPar);

	ds_list_destroy(nspListStr);
	ds_list_destroy(nspListPar);

	return rv;



}
function NSP_execute_string(argument0) {
	var nspListStr, nspListPar, rv, succ;

	if (argument0 == "") return undefined;

	nspListStr = ds_list_create();
	nspListPar = ds_list_create();

	succ = nsp_convert_to_list(argument0, nspListStr, nspListPar);

	if (!succ) {

	  NSP_notify("SCRIPT: NSP_execute_string. ERROR: String will not be executed because it could not be converted.");

	  ds_list_destroy(nspListStr);
	  ds_list_destroy(nspListPar);
  
	  return undefined;
  
	  }
  
	rv = nsp_execute_master(0, ds_list_size(nspListStr)-1, false, nspListStr, nspListPar);

	ds_list_destroy(nspListStr);
	ds_list_destroy(nspListPar);

	return rv;



}
function NSP_free(argument0) {
	var;

	global.nspToken=0;
	if (global.nspDsMap<>-1 and ds_exists(global.nspDsMap,ds_type_map))
	 ds_map_destroy(global.nspDsMap);

	if argument0==true {

	 repeat (ds_list_size(global.nspListSaved)) begin
 
	  NSP_free_saved(global.nspListSaved[|0]);
 
	 end;

	 }
 
	ds_list_destroy(global.nspListSaved);



}
function NSP_free_saved(argument0) {
	if(argument0 == undefined){
		return 0;
	}
	var index;

	ds_list_destroy(argument0[|0]);
	ds_list_destroy(argument0[|1]);
	ds_list_destroy(argument0);

	index=ds_list_find_index(global.nspListSaved,argument0);
	ds_list_delete(global.nspListSaved,index);



}
function NSP_notify() {
	global.nsp_errorcount ++
	//*** Do not change this part ***//
	if (argument_count > 1) {
 
	 argument[0] += " FAULTY CODE: " + nsp_list_to_string(argument[1], argument[2], argument[3], "^");
  
	 }
 
	// You can use argument[0] (string) from now on to report an error in any way.
	// Default implementation: show_error(argument[0], false);
	if(global.nsp_errorcount < 10){
		show_message_async(argument[0]);
	} else {
		
	}

}
function NSP_save(argument0) {
	var rv, list_1, list_2, list_3;

	list_1 = ds_list_create();
	list_2 = ds_list_create();
	list_3 = ds_list_create();

	rv = nsp_convert_to_list(argument0, list_1, list_2);

	list_3[|2] = rv;
	list_3[|1] = list_2;
	list_3[|0] = list_1;

	ds_list_add(global.nspListSaved, list_3);

	return list_3;



}