	gds flatglob "*_example_*";	gds flatten true;	gds read ./user_project_wrapper.gds;	load user_project_wrapper -dereference;	select top cell;	extract no all;	extract do local;	extract;	ext2spice lvs;	ext2spice user_project_wrapper.ext;	feedback save extract_user_project_wrapper.log;	exit;
