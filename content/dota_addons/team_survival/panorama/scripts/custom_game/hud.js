var energymax = 0;
var energy = 0;
var heatmax = 0;
var heat = 0;

(function()
{
	GameEvents.Subscribe("event_energy_change", OnEnergyChangeEvent);
	GameEvents.Subscribe("event_heat_change", OnHeatChangeEvent);
})();

function OnEnergyChangeEvent( event_data )
{
	if (typeof event_data.energymax !== "undefined"){
		energymax = event_data.energymax;
	}

	if (typeof event_data.energy !== "undefinde"){
		energy = event_data.energy;
		$("#energy_text").text = "Energy: " + energy + " / " + energymax;
		$("#energy_meter").style.width = energy / energymax * 100 + "%";
	}

}

function OnHeatChangeEvent( event_data )
{
	if (typeof event_data.heatmax !== "undefined"){
		heatmax = event_data.heatmax;
	}

	if (typeof event_data.heat !== "undefinde"){
		heat = event_data.heat;
		$("#heat_text").text = "Heat: " + heat + " / " + heatmax;
		$("#heat_meter").style.width = heat / heatmax * 100 + "%";
	}

}
