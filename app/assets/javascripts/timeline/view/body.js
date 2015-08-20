function body(events){
	var alignTop = 70;
	var objs = canvas.getObjects();
	for(var i in objs){
		objs[i].set('selectable', false);
		if(objs[i].event_id){
			var _event = getEventById(objs[i].event_id, events);
			if(_event.status == "reprovado"){
				objs[i].item(1).set('fill', "#FFF")
			}
			objs[i].item(0).set('fill',patternStatusColor[_event.status] ? patternStatusColor[_event.status] : patternStatusColor['none']);
		}
	}
	canvas.renderAll();
}