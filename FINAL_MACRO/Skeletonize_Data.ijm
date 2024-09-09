//Sample Skeletonize (choose a current method to show for demonstration)
officialName = getTitle();
zoom = getZoom()*100;

//
run("comb 2");
selectWindow(officialName);
setOption("ScaleConversions", true);
run("8-bit");
run("comb 1");
selectWindow("Skeleton");

//Combine and clean skeletons

run("Add Image...", "image=Layer2 x=0 y=0 opacity=100 zero");
run("Flatten");
close("Skeleton");
close("Layer2");
rename("Skeleton");
setOption("ScaleConversions", true);
run("8-bit");
run("Grays");
run("Dilate");
run("Fill Holes");
run("Skeletonize (2D/3D)");
run("Set... ", "zoom="+zoom+" x=0 y=0");

//create a preview
run("Analyze Skeleton (2D/3D)", "prune=none");
close("Results");
run("Merge Channels...", "c1=[Tagged skeleton] c2=["+officialName+"] create keep");
close("Tagged skeleton");
selectWindow("Composite");
run("Set... ", "zoom="+zoom+" x=0 y=0");
selectWindow(officialName);
run("Set... ", "zoom="+zoom+" x=0 y=0");
close("Skeleton");