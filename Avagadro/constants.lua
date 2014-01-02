local constants

constants.screen={
	width=1280,
	height=720,
}

constants.view={
	x=constants.screen.width/10,
	y=constants.screen.height/10,
	width=4*constants.screen.width/5,
	height=4*constants.screen.height/5,
}

constants.map={
	columns=27,
	rows=27,
	cellWidth=32,
	cellHeight=32,
}

constants.mapView={
	x=constants.view.x,
	y=constants.view.y,
	width=constants.map.columns*constants.map.cellWidth,
	height=constants.map.row*constants.map.cellHeight,
}

return constants