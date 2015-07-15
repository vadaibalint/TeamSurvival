function OnResourceChangeEvent( event_data )
{
	if (event_data.energy){
		$("#energy_counter").text = event_data.energy;
	}
}
 
GameEvents.Subscribe( "event_resource_change", OnResourceChangeEvent);
