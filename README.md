# SkeleSketch
FIJI macro that allows for efficient and accurate analysis of morphological properties of neurons and glial cells

1. Move the unzipped 'CustomMacro' to the macro folder on ImageJ
	File Path: Fiji.app > scripts > Plugins

2. Install these dependencies on ImageJ
	(Help > Update... > Manage Update Sites > 'select dependecies' > Apply and Close > Apply Changes)
	- ImageJ
	- Fiji
	- Java-8
	- 3D ImageJ Suite
	- BoneJ
	- IJPB-plugins
	- Neuroanatomy
	- ResultsToExcel
	- TrackMate-MorphoLib

3. Restart ImageJ (close and reopen)

4. Run this file (README) on ImageJ
	Location: Plugins > CustomMacros (Located towards the bottom) > README

---Instructions---

1. Open an image on ImageJ

2. Click 'F1' to begin sample capture from base image (Follow instructions provided)

3. Click 'F2' to begin skeletonization and editing (Follow instructions provided)

---Warnings---

* UPDATES: Any updates/changes requires the restart of ImageJ
** ADDITIONS/EDITS: Any new macros or changing of macro keybinds requires the removal of previous keybinds
*/

//Shortcut Installation
//run("Add Shortcut... ", "shortcut=0 command=[Image Opener]");
run("Add Shortcut... ", "shortcut=F1 command=[Capture Images]");
run("Add Shortcut... ", "shortcut=F2 command=[Edit Finalize]");
