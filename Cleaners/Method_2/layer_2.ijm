/*
Use a blurring method to connect details
	- Blurs can now be used as details are detected in layer 1
*/

setBatchMode("hide");

run("Duplicate..."," ");
rename("temp");

run("Find Edges");

//Get min and max of pixel value (used to calculate bin size)
run("Measure");
run("Set Measurements...", "min redirect=None decimal=0");
min1 = getResult("Min");
max1 = getResult("Max");
bins1 = max1-min1+1;
close("Results");
//Setting up 'histogram', calculate number of pixels to remove
perc1 = 0.6;
getHistogram(values1, counts1, bins1);
total1 = 0;
for(i=0; i<bins1; i++) {
	total1 += counts1[i];
}

//Find the threshold
value1 = min1;
index1 = 0;
count1 = 0;
while((count1/total1) < perc1){
	count1 += counts1[index1];
	value1++;
	index1++;
}
run("Subtract...",value1);
run("Despeckle");

//Get min and max of pixel value (used to calculate bin size)
run("Measure");
run("Set Measurements...", "min redirect=None decimal=0");
min2 = getResult("Min");
max2 = getResult("Max");
close("Results");

//Setting up 'histogram', calculate number of pixels to remove
perc2 = 0.85;
bins2 = max2-min2+1;
getHistogram(values2, counts2, bins2);
total2 = 0;
for(j=0; j<bins2; j++) {
	total2 += counts2[j];
}
//Find the threshold
value2 = min2;
index2 = 0;
count2 = 0;
while((count2/total2) < perc2){
	count2 += counts2[index2];
	value2++;
	index2++;
}
setThreshold(value2, max2, "raw");
setOption("BlackBackground", true);
run("Convert to Mask");

run("Gaussian Blur...","sigma=3");
run("Despeckle");
run("Sharpen");

//Get min and max of pixel value (used to calculate bin size)
run("Measure");
run("Set Measurements...", "min redirect=None decimal=0");
min3 = getResult("Min");
max3 = getResult("Max");
close("Results");

//Setting up 'histogram', calculate number of pixels to remove
perc3 = 0.7;
bins3 = max3-min3+1;
getHistogram(values3, counts3, bins3);
total3 = 0;
for(k=0; k<bins3; k++) {
	total3 += counts3[k];
}
//Find the threshold
value3 = min3;
index3 = 0;
count3 = 0;
while((count3/total3) < perc3){
	count3 += counts3[index3];
	value3++;
	index3++;
}
setThreshold(value3, max3, "raw");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Despeckle");

setBatchMode("exit and display");

run("Skeletonize Connector");
rename("Layer2");
setOption("ScaleConversions", true);
run("8-bit");
run("Grays");
run("Multiply...", "value=255");
close("temp");