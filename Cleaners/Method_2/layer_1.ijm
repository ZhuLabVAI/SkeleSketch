//Main body and detail (brightest areas)
/*
Try to make create a mask of only the brightest % of pixels
- Grab data from the histogram (bracket size, number of pixels, count for bracket)
- subtract the count from total until you reach % of total pixels
*/

setBatchMode("hide");

//General data of the image
lowerBound = 0.85
upperBound = 1
run("Duplicate..."," ");
rename("temp");
selectWindow("temp");

//Setting up 'histogram', calculate number of pixels to remove
bins = 512;
getHistogram(values, counts, bins);
total = 0;
for(i=0; i<bins; i++) {
	total += counts[i];
}
removedPixelsUpper = total*(1-upperBound);
removedPixelsLower = total*lowerBound;

//Get min and max of pixel value (used to calculate bin size)
run("Measure");
run("Set Measurements...", "min redirect=None decimal=0");
min = getResult("Min");
max = getResult("Max");
step = (max-min)/bins;
close("Results");

//Find the threshold
actualRemovedPixelsLower = 0;
actualRemovedPixelsUpper = 0;
thresholdLower = min;
thresholdUpper = max;
index = 0;
while(actualRemovedPixelsLower < removedPixelsLower){
	actualRemovedPixelsLower += counts[index];
	thresholdLower += step;
	index++;
}
index = bins-1;
while(actualRemovedPixelsUpper < removedPixelsUpper){
	actualRemovedPixelsUpper += counts[index];
	thresholdUpper -= step;
	index--;
}

//Setting Threshold, Cleaning, Skeletonize+Connect
selectWindow("temp");
setThreshold(thresholdLower, thresholdUpper, "raw");
run("Convert to Mask");
close("Threshold");
run("Despeckle");

setBatchMode("exit and display");

run("Skeletonize Connector");
rename("skel1");
setOption("ScaleConversions", true);
run("8-bit");
run("Grays");
run("Multiply...", "value=255");
run("Dilate");
run("Fill Holes");
run("Erode");
run("Skeletonize (2D/3D)");
rename("Layer1");
close("skel1");
close("temp");