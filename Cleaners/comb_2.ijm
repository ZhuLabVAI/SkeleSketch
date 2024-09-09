name = getTitle;

/*
selectWindow(name);
run("layer 1");
title1 = getTitle;
*/

selectWindow(name);
run("layer 2");
title2 = getTitle;

/*
run("Add Image...", "image="+title1+" x=0 y=0 opacity=100 zero");
run("Flatten");
close(title2);
close(title1);
*/

rename("Layer2");

// layer 1 seems to be having issues (not working as intented, resulting in worse images than expected)