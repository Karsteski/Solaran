shader_type spatial;

instance uniform vec3 grid_colour = vec3(0.5, 0.0, 0.0);

varying vec3 world_position;

const float gridSize = 3.5;

void vertex() {
	world_position = VERTEX;
}


void fragment(){
	vec3 pos = world_position;
	pos /= gridSize;
	pos += gridSize * 20.0;

	//to offset a bug that appears when one of the coordinate is close to 0
	//can be tweaked if the bug is visible
	pos.y += 1.0*float(fract(float(int(pos.x*2.0))/2.0));
	pos.z += float(fract(float(int(pos.y*2.0))/2.0));

	vec3 colour = vec3(fract(float(int(pos.z*2.0))/2.0));

	ROUGHNESS = colour.x/2.0 + 0.2;
	ALBEDO = colour * grid_colour;
}
