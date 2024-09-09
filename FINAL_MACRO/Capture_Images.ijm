/*
IMAGES:
- Base			- Original (base) image
- Labeled		- Original image with numbering of samples
- #				- Individual files of choosen regions

VARIABLES
- officialName	- General name
- folder 		- Pathway to designated folder for image

OBJECTIVE:
	Allows for the capturing of images and placing them into an organized file
*/

setTool("rectangle");

//Saves and edits the name into a cleaner form that is recognizable
officialName = getTitle();
officialName = officialName.substring(0,officialName.length()-4);

//Create Labeled and folder to store files
run("Duplicate...", " ");
rename(officialName + "-Labeled");
location = getDirectory("Select a directory (Where you would like to save the images)");
folder = location + officialName + "-Images";
File.makeDirectory(folder);
run("RGB Color");

//Start image selection
num = 1;
stop = false;
print("Create a rectangle around the cell and its arms\n\n'Space': capture image of sample\n'Shift': finished collecting samples");
while(!stop) {
	//Setup of macro keys
	interruptMacro = isKeyDown("shift");
	captureMacro = isKeyDown("space");
	
	//Capture:
	//If 'space' is pressed, save selected image and label onto Labeled
	if (captureMacro == true) {
		setBatchMode("hide");
		getSelectionBounds(x, y, w, h);
		run("Duplicate...", " ");
		saveAs("Tiff", folder+"/"+officialName+"-"+num+".tif");
		close();
		setBatchMode("exit and display");
		print("captured "+officialName+"-"+num);
		setKeyDown("none");
		setFont("SansSerif", 30, " antialiased");
		setColor("red");
		drawString(num, x+(2*w/5), y+(3*h/4));
		num++;
		wait(500);
	}
	
	//Stop:
	//If 'shift' is pressed, exit image selection
    if (interruptMacro == true) {
        print("Stopped");
        setKeyDown("none");
		
		//Saves Labeled and Base to same folder as other files to allow for easy access
		saveAs("Tiff", folder+"/"+officialName+"-Labeled.tif");
		close();
		saveAs("Tiff", folder+"/"+officialName+"-Base.tif");
		close();
		print("Finished");
		stop = true;
		wait(1500);
		print("\\Clear");
		print("All files are saved here:\n'"+folder+"'\n\nOpen them individually to begin skeletonizing");
		break;
    }
}
showMessage("Open files from the folder to begin skeletonizing and collecting data\n(Open the first image then hit [F2] to begin)");