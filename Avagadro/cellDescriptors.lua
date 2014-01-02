local cellDescriptors={
	[0]={frame=20,cw=0,ccw=0,links={false,false,false,false},ignoreLinks=true},
	[1]={frame=1,cw=1,ccw=1,links={false,false,false,false},ignoreLinks=false},
	[2]={frame=2,cw=3,ccw=9,links={true,false,false,false},ignoreLinks=false},
	[3]={frame=3,cw=5,ccw=2,links={false,true,false,false},ignoreLinks=false},
	[4]={frame=4,cw=7,ccw=10,links={true,true,false,false},ignoreLinks=false},
	[5]={frame=5,cw=9,ccw=3,links={false,false,true,false},ignoreLinks=false},
	[6]={frame=6,cw=11,ccw=11,links={true,false,true,false},ignoreLinks=false},
	[7]={frame=7,cw=13,ccw=4,links={false,true,true,false},ignoreLinks=false},
	[8]={frame=8,cw=15,ccw=12,links={true,true,true,false},ignoreLinks=false},
	[9]={frame=9,cw=2,ccw=5,links={false,false,false,true},ignoreLinks=false},
	[10]={frame=10,cw=4,ccw=13,links={true,false,false,true},ignoreLinks=false},
	[11]={frame=11,cw=6,ccw=6,links={false,true,false,true},ignoreLinks=false},
	[12]={frame=12,cw=8,ccw=14,links={true,true,false,true},ignoreLinks=false},
	[13]={frame=13,cw=10,ccw=7,links={false,false,true,true},ignoreLinks=false},
	[14]={frame=14,cw=12,ccw=15,links={true,false,true,true},ignoreLinks=false},
	[15]={frame=15,cw=14,ccw=8,links={false,true,true,true},ignoreLinks=false},
	[16]={frame=16,cw=16,ccw=16,links={true,true,true,true},ignoreLinks=false},
	[17]={frame=17,cw=17,ccw=17,links={false,false,false,false},ignoreLinks=true}
}
cellDescriptors.getFrame = function (theValue)
	return cellDescriptors[theValue].frame
end
return cellDescriptors