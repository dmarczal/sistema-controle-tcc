var patternEventBox = {
	fill: '#6495ED',
	rx: 2,
	ry: 2,
	originX: 'center',
	originY: 'center',
	width: 200,
	height: 60,
	selectable: false,
};

var patternLegendBox = {
	fill: '#FFFACD',
	rx: 2,
	ry: 2,
	width: 300,
	height: 80,
	originX: 'center',
	originY: 'center',
	selectable: false,
	visible: true,
}

var patternLegendText = {
	originX: 'center', 
	originY: 'center',
	fontFamily: 'Arial',
	fontSize: 12
}

var patternEventText = {
	originX: 'center', 
	originY: 'center',
	fontFamily: 'Arial',
	fontSize: 15
}

var patternStatusColor = {
	none: '#DCDCDC',
	success: '#00FF7F',
	warning: '#FFD700',
	danger: '#8B0000'
}

var iconsType = [];
var icons = ['warning', 'document', 'presentation'];
for(var i=0; i < icons.length; i++){
	var imgElement = document.getElementById('label-'+icons[i]);
	var imgInstance = new fabric.Image(imgElement, {
	  width: 30,
	  height: 30,
	  left: -100,
	  top: 00,
	});
	iconsType[icons[i]] = imgInstance;
}
