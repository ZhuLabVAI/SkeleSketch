/*
Input: Orignial image
Output: Skeletonized image (skeleton2)
*/

run("Subtract Background...", "rolling=200 sliding disable");
run("Multiply...", "value=4.5");
run("Gamma...", "value=1.50");
run("Unsharp Mask...", "radius=3 mask=0.70");

run("Despeckle", "");
run("Sharpen", "");
run("Sharpen", "");
run("Despeckle", "");
run("Subtract...", "value=100");
run("Sharpen", "");
run("Multiply...", "value=255");
run("Despeckle", "");

run("Gaussian Blur...", "sigma=1.5");
run("Sharpen", "");
run("Sharpen", "");
run("Despeckle", "");
run("Despeckle", "");
run("Sharpen", "");
run("Sharpen", "");
run("Multiply...", "value=3");

run("Despeckle", "");
run("Despeckle", "");
run("Despeckle", "");

run("Subtract...", "value=100");
run("Multiply...", "value=255");

run("Gaussian Blur...", "sigma=1.5");
run("Subtract...", "value=100");
run("Sharpen", "");
run("Sharpen", "");
run("Sharpen", "");
run("Multiply...", "value=255");
run("Despeckle", "");

rename("skeleton2");
close("skeletonized2");