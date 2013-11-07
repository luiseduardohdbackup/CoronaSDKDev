local storyboard = require( "storyboard" )
local widget = require("widget")
local scene = storyboard.newScene()

function scene:updateInventory()
    local group = self.view
	if self.inventoryView~=nil then
		self.inventoryView:removeSelf()
		self.inventoryView=nil
	end
	self.inventoryView = widget.newTableView({
		left=160,
		top=0,
		width=320,
		height=320,
		backgroundColor={0,0,0},
		onRowRender=function(event)
			local theImage = display.newImage(event.row,"Items/"..event.row.params.value.image..".png",0,event.row.contentHeight/2-16)
			local theText = display.newText({parent=event.row,text=event.row.params.value.name,x=136,y=event.row.contentHeight/2,font="8bitoperator JVE",fontSize=28,width=208,align="left"})
			theText:setTextColor(255,255,255)
			local theButton = widget.newButton({
				left=240,
				top=0,
				width=80,
				height=event.row.contentHeight,
				label="Take"
			})
			event.row:insert(theButton)
		end
	})
	group:insert(self.inventoryView)
	local thePlayer = self.gameData.maze.player
	local theRoom = self.gameData.maze.columns[thePlayer.position.column][thePlayer.position.row]
	print(self.inventoryView.numChildren)
	if theRoom.items~=nil then
		for i,v in ipairs(theRoom.items) do
			self.inventoryView:insertRow({
				params={index=i,value=v},
				rowHeight=32,
				rowColor={
					default={0,0,0,255},
					over={0,0,0,255}
				},
				lineColor={255,255,255,255}
			})
		end
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
	self.gameData = event.params
	
	self.inventoryButton = display.newImage(group,"EmptyButton.png")
	self.inventoryButton.x = 140
	self.inventoryButton.y = 340
	self.inventoryButton:addEventListener("tap",self)
end

function scene:tap(event)
	if event.target == self.inventoryButton then
		storyboard.gotoScene("play")
	end
end


-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local group = self.view
	self:updateInventory()
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        local group = self.view
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
        local group = self.view
end


-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
        local group = self.view
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
end


-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene
end


-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
        local group = self.view
        local overlay_name = event.sceneName  -- name of the overlay scene
end



---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene