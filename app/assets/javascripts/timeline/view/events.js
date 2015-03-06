function events(events){
	canvas.on('mouse:over', function(options){
		if(options.target.event_id){
			// se já existir uma legenda ativa, remove-a
			var objs = canvas.getObjects();
			var legend = getActiveLegend(objs);
			if(legend) canvas.remove(legend);
			
			var legendBox = new fabric.Rect(patternLegendBox);
			var _event = getEventById(options.target.event_id, events);
			var legendText = wrapCanvasText(new fabric.Text(_event.description, patternLegendText), canvas, legendBox.getWidth()-20, legendBox.getHeight()-20, true);
			var legend = new fabric.Group([legendBox, legendText], {
				selectable: false, 
				visible: true,
				top: options.target.getTop()-70,
				left: options.target.getLeft()+70,
				hoverCursor: 'pointer'
			});
			legend.isLegend = true;
			canvas.add(legend);
			canvas.hoverCursor = 'pointer';
			canvas.renderAll();
			document.body.style.setProperty("cursor", "pointer");
		}
	});

	canvas.on('mouse:move', function(options){
		if(!options.target){
			document.body.style.setProperty("cursor", "default");
			var objs = canvas.getObjects();
			var legend = getActiveLegend(objs);
			canvas.remove(legend);
		}
	});

	canvas.on('mouse:up', function(options){
		if(options.target && options.target.event_id){
			var e = getEventById(options.target.event_id, events);
            if(e.link){
                window.location = e.link;
            }
		}
	});
}

