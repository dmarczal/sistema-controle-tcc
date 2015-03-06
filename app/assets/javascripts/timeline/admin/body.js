// var alignTop = 70;
// for(var i=0; i < jsonEvents.length; i++){
// 	// criando o box do evento e inserindo no grupo
// 	var eventBox = new fabric.Rect(patternEventBox);
// 	eventBox.setFill(patternStatusColor[jsonEvents[i].status]);
// 	var legendImage = iconsType[jsonEvents[i].type];
// 	var eventText = wrapCanvasText(new fabric.Text(jsonEvents[i].name, patternEventText), canvas, eventBox.getWidth(), eventBox.getHeight(), true);
// 	var groupEvent = new fabric.Group([eventBox, eventText, legendImage], {
// 		selectable: true,
// 		top: alignTop,
// 		left: 30,
// 		id: jsonEvents[i].id
// 	});

// 	// inserindo grupo no canvas
// 	canvas.add(groupEvent);
// 	alignTop += eventBox.getHeight()+20;
// }

function body(jsonEvents){
	var objects = canvas.getObjects();
	var currentEvents = [];
	for(var i=0; i < objects.length; i++){
		if(objects[i].event_id){
			currentEvents.push(objects[i].event_id);
            refreshEvent(objects[i], getEventById(objects[i].event_id, jsonEvents));
		}
	}

	var eventsToAdd = [];
	for(var i=0; i < jsonEvents.length; i++){
		if(currentEvents.indexOf(jsonEvents[i].id) == -1){
          if(jsonEvents[i].id != '#'){
            eventsToAdd.push(jsonEvents[i]);
          }
		}
	}

	var alignTop = 70;
	for(var i=0; i < eventsToAdd.length; i++){
		// criando o box do evento e inserindo no grupo
		var eventBox = new fabric.Rect(patternEventBox);
		// eventBox.setFill(patternStatusColor[eventsToAdd[i].status]);
		var legendImage = iconsType[eventsToAdd[i]._type];
		var eventText = wrapCanvasText(new fabric.Text(eventsToAdd[i].title, patternEventText), canvas, eventBox.getWidth(), eventBox.getHeight(), true);
		var groupEvent = new fabric.Group([eventBox, eventText, legendImage], {
			selectable: true,
			top: alignTop,
			left: 30,
		});
		groupEvent.set('event_id', eventsToAdd[i].id);

		// inserindo grupo no canvas
		canvas.add(groupEvent);
	}
}

function refreshEvent(canvas_event, event){
    var objects = canvas_event.getObjects();

    // ATUALIZAR TEXTO E LEGENDA

    canvas.renderAll();
}