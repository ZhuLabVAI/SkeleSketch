/*
Input: Orignial image
Output: Skeletonized image (skeleton1)
*/

run("Subtract Background...", "rolling=200 sliding disable");
run("Multiply...", "value=4.5");

run("Subtract...", "value=100");
run("Sharpen", "");
run("Despeckle", "");
run("Sharpen", "");
run("Despeckle", "");
run("Sharpen", "");
run("Despeckle", "");
run("Multiply...", "value=255");

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

rename("skeleton1");
close("skeletonized1");