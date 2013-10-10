local theDirections = {}
theDirections.count = 4
theDirections.deltas = {{x=0,y=-1},{x=1,y=0},{x=0,y=1},{x=-1,y=0}}
theDirections.opposites = {3,4,1,2}
theDirections.rights = {2,3,4,1}
theDirections.lefts = {4,1,2,3}
return theDirections