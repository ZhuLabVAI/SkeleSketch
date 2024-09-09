/*
vars
*/

totalNumCode = 3;
/*
3 still requires tinkering: 
	-further extension down center
	-reduce intereference of left hand / provide more detail
	-capture frills northeast of center mass
*/

//Creates the base
run("Duplicate...", " ");
rename("temp");
setOption("ScaleConversions", true);
run("8-bit");

//Get skeleton# of each piece of code
for(i=1; i<=totalNumCode; i++){
	selectWindow("temp");
	run("Duplicate...", " ");
	rename(i);
	run("code "+i);
}


//Merges all the skeleton#'s together
selectWindow("skeleton1");
run("Duplicate...", " ");
rename("Base");
for(j=1; j<=totalNumCode; j++){
	run("Add Image...", "image=skeleton"+j+" x=0 y=0 opacity=100 zero");
	rename("skeletonComb");
	selectWindow("skeletonComb");
}
run("Flatten");
rename("Final Comb");

//Fix combined skeleton (reskeletonizing overlay and converting back to 8-bit gray
run("Options...", "iterations=1 count=1 black");
setOption("BlackBackground", true);
run("8-bit");
run("Grays");
run("Dilate");
run("Fill Holes");
run("Erode");
run("Skeletonize Connector Method1");
setOption("ScaleConversions", true);
run("8-bit");
run("Grays");
run("Multiply...", "value=255");
run("Skeletonize (2D/3D)");
rename("reconnect");
run("Analyze Skeleton (2D/3D)", "prune=none");
rename("Tagged skeleton");

//Cleaner
close("skeletonComb");
close("Log");
for(k=1; k<=totalNumCode; k++){
	close(k);
	close("skeleton"+k);
}
close("Tagged skeleton");
close("Final Comb");
close("temp");

selectWindow("reconnect");
rename("Skeleton");
close("Results");