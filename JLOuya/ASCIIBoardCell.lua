local asciiBoardCell = {}
asciiBoardCell.createCell = function(character,foreground,background)
	local boardCell = {}
	boardCell.character = character
	boardCell.foreground = foreground
	boardCell.background = background
	boardCell.dirty = true
	function boardCell:setCharacter(character)
		if character~=self.character then
			self.character=character
			self:invalidate()
		end
	end
	function boardCell:setForeground(foreground)
		if foreground~=self.foreground then
			self.foreground=foreground
			self:invalidate()
		end
	end
	function boardCell:setBackground(background)
		if background~=self.background then
			self.background=background
			self:invalidate()
		end
	end
	function boardCell:set(cell)
		self:setCharacter(cell.character)
		self:setForeground(cell.foreground)
		self:setBackground(cell.background)
	end
	function boardCell:invalidate()
		self:setDirty(true)
	end
	function boardCell:validate()
		self:setDirty(false)
	end
	function boardCell:setDirty(dirty)
		self.dirty=dirty
	end
	return boardCell
end
return asciiBoardCell