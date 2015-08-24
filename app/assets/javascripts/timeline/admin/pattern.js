patternEventBox = {
	fill: '#DCDCDC',
	rx: 2,
	ry: 2,
	originX: 'center',
	originY: 'center',
	width: 200,
	height: 60,
	selectable: true,
};

patternEventText = {
	originX: 'center',
	originY: 'center',
	fontFamily: 'Arial',
	fontSize: 15,
}

patternStatusColor = {
	none: '#DCDCDC',
	success: '#00FF7F',
	warning: '#FFD700',
	danger: '#8B0000'
}

iconsType = [];
icons = ['important', 'document', 'presentation'];
for(var i=0; i < icons.length; i++){
	var imgElement = document.getElementById('label-'+icons[i]);
	var imgInstance = new fabric.Image(imgElement, {
	  width: 30,
	  height: 30,
	  left: -100,
	  top: 00,
	}, "anonymous");
	iconsType[icons[i]] = imgInstance;
}
