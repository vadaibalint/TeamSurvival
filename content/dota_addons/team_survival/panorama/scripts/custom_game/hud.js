var heatmax = 0;
var heat = 0;

(function()
{
	GameEvents.Subscribe("event_energy_change", OnEnergyChangeEvent);
	GameEvents.Subscribe("event_heat_change", OnHeatChangeEvent);
})();

function OnEnergyChangeEvent( event_data )
{
	if (event_data.energy){
		$("#energy_counter").text = event_data.energy;
	}
}

function OnHeatChangeEvent( event_data )
{
	if (event_data.heatmax){
		$.Msg("heatmax changed : ", heatmax, " -> ", event_data.heatmax)
		heatmax = event_data.heatmax;
	}

	if (event_data.heat){
		heat = event_data.heat;
		$.Msg("heat is : ", heat / heatmax * 100, "%")
		$("#heat_meter").style.width = heat / heatmax * 100 + "%";
		$("#heat_text").text = "Heat: " + heat + " / " + heatmax;
	}

}
