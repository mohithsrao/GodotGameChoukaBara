# Build Status:
![Godot Project Export and Release](https://github.com/mohithsrao/GodotGameChoukaBara/workflows/Godot%20Project%20Export%20and%20Release/badge.svg)

[Playable Link](https://mohithsrao.github.io/GodotGameChoukaBara/)

# GodotGame - ChoukaBara
First game in Godot to learn the engine and create some game mechanics.

The game to be created is an old indian board game called Chouka-Bara 

The game is going to be in 2D and built in the godot Game engine

#Reference Project 

	https://kidscancode.org/godot_recipes/2d/grid_movement/
	
#Reference Game Assets
	http://untamed.wild-refuge.net/rmxpresources.php?characters
	https://kenney.nl/assets/platformer-characters
	https://kenney.nl/assets/toon-characters-1

#Used GitHub Actions
	To Build Godot: https://github.com/marketplace/actions/build-godot
	To Create Release: https://github.com/marketplace/actions/create-a-release
	To Upload Artifacts to release: https://github.com/actions/upload-release-asset
	To get change Log: https://github.com/marketplace/actions/generate-changelog 
	To get Previous Release Tag: https://github.com/marketplace/actions/get-latest-release-of-repository
	To increase version number: https://github.com/marketplace/actions/increment-semantic-version

#Addons Used
	(WAT - Unit Testing Framework)[https://wat.readthedocs.io/en/latest/pages/getting_started/introduction.html] for unit testing
		- to run tests go to godot engins installed localton and execute th command 
			godot.windows.opt.tools.64.exe -v --path <Path to project.godot>  "<Path to project.godot>\addons\WAT\cli.tscn" -run_all
		- Example "godot.windows.opt.tools.64.exe -v --path "D:\Godot\Projects\ChouksBara\GodotGameChoukaBara\ChoukaBaraGame"  "D:\Godot\Projects\ChouksBara\GodotGameChoukaBara\ChoukaBaraGame\addons\WAT\cli.tscn" -run_all"
	gd-YAFSM for using Finite State Machines