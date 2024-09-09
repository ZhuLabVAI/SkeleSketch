run("Invert");
run("Sharpen");
run("Sharpen");

run("Minimum...", "radius=2.5");
run("Gaussian Blur...", "sigma=2.5");
run("Invert");

setOption("BlackBackground", true);
setAutoThreshold("Default dark no-reset");
run("Convert to Mask");
run("Erode");
run("Erode");
run("Despeckle");
rename("skeleton3");