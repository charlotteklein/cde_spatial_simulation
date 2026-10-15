/**
* Name: 01_Savannah_ABM_CA_model
* Based on the internal skeleton template. 
* Author: chark
* Tags: class1, savannah_ABM_CA_sim
*/

model Savannah_ABM_CA_model

//====================================================
// GLOBAL SECTION
// Contains global variables and initializes the
// lion and zebra populations at the start.
//====================================================
global {

	int my_variable <- 1;
	float my_speed <- 0.5;

	init {
		create lion number:20 {
			speed <- my_speed;
		}

		create zebra number:20 {
			speed <- my_speed;
		}
	}
}

//====================================================
// AGENTS SECTION
// Defines the lion and zebra species, including
// movement, interactions, and visualization.
//====================================================

species lion skills:[moving] {

	reflex move {
		do wander;
	}

	reflex hunt {
		zebra victim <- one_of (zebra where (each distance_to self < 2));

		if (victim != nil) {
			ask victim {
				do die;
			}
		}
	}

	aspect default {
		draw circle(3) color:#orange;
	}
}

species zebra skills:[moving] {

	reflex move {
		do wander;
	}

	aspect default {
		draw triangle(2) color:#white;
	}
}

//====================================================
// CA SECTION
// Cellular Automata grid representing grassland.
// Each cell contains biomass that grows over time.
//====================================================

grid my_CA width:100 height:100 {
	float biomass <- rnd(10.0);
	
	reflex growth {
		biomass <- biomass + 0.1;
	}

	aspect default {
		draw square(1) color: rgb(0, min(255, int(biomass * 25)), 0);
	}
}

//====================================================
// SIMULATION PART
// Defines the experiment, parameters, outputs,
// and graphical display of the model.
//====================================================

experiment hello_world type: gui {

	parameter "my Variable" var: my_variable;
	parameter "My Speed" var: my_speed;

	output {

		display map {

			species my_CA;
			species lion aspect:default;
			species zebra aspect:default;

		}
	}
}