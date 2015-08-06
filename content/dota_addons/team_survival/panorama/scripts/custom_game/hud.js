var energymax = 0;	var energy = 0;
var heatmax = 0;	var heat = 0;
var foodmax = 0;	var food = 0;
var watermax = 0;	var water = 0;

(function()
{
	GameEvents.Subscribe("event_resource_change", OnResourceChangeEvent);
})();

function OnResourceChangeEvent( event_data )
{
	RefreshEnergy(event_data);
	RefreshHeat(event_data);
	RefreshFood(event_data);
	RefreshWater(event_data);
}

function RefreshEnergy( event_data )
{
	if (typeof event_data.energymax !== "undefined"){
		energymax = event_data.energymax;
	}

	if (typeof event_data.energy !== "undefined"){
		energy = event_data.energy;
		$("#energy_text").text = "Energy: " + energy + " / " + energymax;
		$("#energy_meter").style.width = energy / energymax * 100 + "%";
	}
}

function RefreshHeat( event_data )
{
	if (typeof event_data.heatmax !== "undefined"){
		heatmax = event_data.heatmax;
	}

	if (typeof event_data.heat !== "undefined"){
		heat = event_data.heat;
		$("#heat_text").text = "Heat: " + heat + " / " + heatmax;
		$("#heat_meter").style.width = heat / heatmax * 100 + "%";
	}
}

function RefreshFood( event_data )
{
	if (typeof event_data.foodmax !== "undefined"){
		foodmax = event_data.foodmax;
	}

	if (typeof event_data.food !== "undefined"){
		food = event_data.food;
		$("#food_text").text = "Food: " + food + " / " + foodmax;
		$("#food_meter").style.width = food / foodmax * 100 + "%";
	}
}

function RefreshWater( event_data )
{
	if (typeof event_data.watermax !== "undefined"){
		watermax = event_data.watermax;
	}

	if (typeof event_data.water !== "undefined"){
		water = event_data.water;
		$("#water_text").text = "Water: " + water + " / " + watermax;
		$("#water_meter").style.width = water / watermax * 100 + "%";
	}
}
