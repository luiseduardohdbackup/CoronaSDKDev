local cellDescriptors={}
local generator=require "generator"
cellDescriptors.generators={
	helium={[1]=1},
	hydrogen={[2]=1,[3]=1,[5]=1,[9]=1},
	oxygen={[4]=1,[6]=1,[7]=1,[10]=1,[11]=1,[13]=1},
	nitrogen={[8]=1,[12]=1,[14]=1,[15]=1},
	carbon={[16]=1},
	mystery={[17]=1}
}
cellDescriptors.generateAtom=function(atom)
	return generator.generate(cellDescriptors.generators[atom])
end
cellDescriptors.descriptors={
	[0]={frame=20,cw=0,ccw=0,rotations={},links={false,false,false,false},ignoreLinks=true,special="empty"},
	[1]={frame=1,cw=1,ccw=1,rotations={},links={false,false,false,false},ignoreLinks=false},
	[2]={frame=2,cw=3,ccw=9,rotations={3,5,9},links={true,false,false,false},ignoreLinks=false},
	[3]={frame=3,cw=5,ccw=2,rotations={2,5,9},links={false,true,false,false},ignoreLinks=false},
	[4]={frame=4,cw=7,ccw=10,rotations={7,10,13},links={true,true,false,false},ignoreLinks=false},
	[5]={frame=5,cw=9,ccw=3,rotations={2,3,9},links={false,false,true,false},ignoreLinks=false},
	[6]={frame=6,cw=11,ccw=11,rotations={11},links={true,false,true,false},ignoreLinks=false},
	[7]={frame=7,cw=13,ccw=4,rotations={4,10,13},links={false,true,true,false},ignoreLinks=false},
	[8]={frame=8,cw=15,ccw=12,rotations={12,14,15},links={true,true,true,false},ignoreLinks=false},
	[9]={frame=9,cw=2,ccw=5,rotations={2,3,5},links={false,false,false,true},ignoreLinks=false},
	[10]={frame=10,cw=4,ccw=13,rotations={4,7,13},links={true,false,false,true},ignoreLinks=false},
	[11]={frame=11,cw=6,ccw=6,rotations={6},links={false,true,false,true},ignoreLinks=false},
	[12]={frame=12,cw=8,ccw=14,rotations={8,14,15},links={true,true,false,true},ignoreLinks=false},
	[13]={frame=13,cw=10,ccw=7,rotations={4,7,10},links={false,false,true,true},ignoreLinks=false},
	[14]={frame=14,cw=12,ccw=15,rotations={8,12,15},links={true,false,true,true},ignoreLinks=false},
	[15]={frame=15,cw=14,ccw=8,rotations={8,12,14},links={false,true,true,true},ignoreLinks=false},
	[16]={frame=16,cw=16,ccw=16,rotations={},links={true,true,true,true},ignoreLinks=false},
	[17]={frame=17,cw=17,ccw=17,rotations={},links={false,false,false,false},ignoreLinks=true,special="mystery"}
}
cellDescriptors.getFrame = function (theValue)
	return cellDescriptors.descriptors[theValue].frame
end
cellDescriptors.getCW=function(theValue)
	return cellDescriptors.descriptors[theValue].cw
end
cellDescriptors.getCCW=function(theValue)
	return cellDescriptors.descriptors[theValue].ccw
end
cellDescriptors.getLinks=function(theValue)
	return cellDescriptors.descriptors[theValue].links
end
cellDescriptors.getRotations=function(theValue)
	return cellDescriptors.descriptors[theValue].rotations
end
cellDescriptors.getIgnoreLinks=function(theValue)
	return cellDescriptors.descriptors[theValue].ignoreLinks
end
cellDescriptors.getSpecial=function(theValue)
	return cellDescriptors.descriptors[theValue].special
end
cellDescriptors.isEmpty = function(theValue)
	return cellDescriptors.getSpecial(theValue)=="empty"
end
return cellDescriptors