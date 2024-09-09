/*
IMAGES:
- Skeleton		- The final skeleton after edits
- Composite		- Overlay created during editing

VARIABLES"
- officialName	- Default name, allows for better naming

OBJECTIVE:
	Allows for preview of edits made to skeleton and collection of data from the skeleton
*/

//Save name and change for macros
print("\\Clear");
officialName = getTitle();
officialName = officialName.substring(0,officialName.length()-4);
rename(officialName);

run("Skeletonize Data");

//Print Instructions
print("Create edits if required (Set Color Picker, the eye dropper)\n'White' to draw and 'Black' to erase [Precision is not required, brush tool is usable]");
print("------------------------------------------------");
print("'Space': preview edits\n'Shift': collect the data from the skeleton");
print("WARNING: Make sure the Excel file is closed before saving data");
editing = true;
indicator = officialName.indexOf("-");
picNum = officialName.substring(indicator+1,officialName.length());

//Editing and Finalization
while(editing) {
	//Setup of macro keys
	previewMacro = isKeyDown("space");
	finishedMacro = isKeyDown("shift");
	
	//Preview:
	//If 'space' is pressed, create a preview of the skeleton over the base image
	if (previewMacro == true) {
		// Composite is alreay made
		zoom = getZoom()*100;
		run("Split Channels");
		selectWindow("C1-Composite");
		run("Skeletonize (2D/3D)");
		run("Analyze Skeleton (2D/3D)", "prune=none");
		close("Results");
		run("Merge Channels...", "c1=[Tagged skeleton] c2=C2-Composite create");
		close("C1-Composite");
		selectWindow("Composite");
		run("Set... ", "zoom="+zoom+" x=0 y=0");
		setKeyDown("none");
		wait(500);
	}
	
	//Finished:
	//If 'shift' is pressed, analyze and save data
    if (finishedMacro == true) {
		showMessage("Close the excel sheet if open");
        //Cleaning and relabeling for data table
		run("Split Channels");
		close("C2-Composite");
		selectWindow("C1-Composite");
		run("8-bit");
		run("Multiply...", "value=255");
		rename(officialName+"(Skeleton)");
		run("Analyze Skeleton (2D/3D)", "prune=none show");
		close("Tagged Skeleton");
		close("Results");
		run("Set Measurements...", "min redirect=None decimal=5");
		Table.rename("Branch information", "Results");
		
		//Store data into table
		pathway = File.directory+officialName.substring(0,officialName.length()-2)+"-Data.xlsx";
		run("Read and Write Excel", "no_count_column file=["+pathway+"] sheet=["+officialName+"] dataset_label=["+officialName+"]");
		
		//Finalize and inform user
		print("------------------------------------------------\nData Collected");
        setKeyDown("none");
		close("Results");
		saveAs("Tiff", File.directory+getTitle);
		close(officialName+"(Skeleton).tif");
		
		//Opens next image in the folder if it exists, exits loops if all images have been gone through
		nextImg = File.directory+officialName.substring(0,officialName.length()-1)+(picNum+1)+".tif";
		if(File.exists(nextImg)){
			while (nImages>0) { 
				selectImage(nImages); 
				close(); 
			} 
			open(nextImg);
			run("Set... ", "zoom="+zoom+" x=0 y=0");
			picNum ++;
			officialName = getTitle();
			officialName = officialName.substring(0,officialName.length()-4);
			rename(officialName);
			run("Skeletonize Data");
		} else {
			while (nImages>0) { 
				selectImage(nImages); 
				close(); 
			} 
			editing = false;
			wait(500);
			close("Log");
			break;
		}
	}
}