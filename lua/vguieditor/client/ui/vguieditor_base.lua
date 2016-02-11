local cprint = function(txt) LocalPlayer():PrintMessage(3,txt) end
local PANEL = {}

PANEL.SizeX = ScrW()-150
PANEL.SizeY = ScrH()-150

function PANEL:Init()
    self:SetTitle("Derma Designer")
    self:SetIcon("icon16/application_edit.png")
    self:SetSize(self.SizeX,self.SizeY)
    self:Center()
    self:MakePopup()

    self.proj_elements = {}

    self.btnMaxim:SetDisabled(false)
    function self.btnMaxim:DoClick()
        if self.Maximised == false then
            self.Maximised = true
            self:SetSize(ScrW(),ScrH())
        else
            self.Maximised = false
            self:SetSize(self.SizeX,self.SizeY)
        end
    end

    self.menu = vgui.Create("DMenuBar",self)
    self.menu:Dock(TOP)
    self.menu:DockMargin(-3,-6,-3,0)
    self.menu.file = self.menu:AddOrGetMenu("File")
    self.menu.file:AddOption("New",function() cprint("dermadesigner new") end):SetIcon("icon16/page_white_add.png")
    self.menu.file:AddOption("Open",function() cprint("dermadesigner open") end):SetIcon("icon16/folder_page_white.png")
    self.menu.file:AddSpacer()
    self.menu.file:AddOption("Save",function() cprint("dermadesigner save") end):SetIcon("icon16/disk.png")
    self.menu.file:AddSpacer()
    self.menu.file:AddOption("Run",function() cprint("dermadesigner run") end):SetIcon("icon16/application_go.png")
    self.menu.file:AddSpacer()
    self.menu.file:AddOption("Exit",function() self:Close() end):SetIcon("icon16/cross.png")

    self.project = vgui.Create("DFrame",self)
    self.project:Dock(LEFT)
    self.project:DockMargin(-4,-1,0,-4)
    self.project:SetWide(250)
    self.project:ShowCloseButton(false)
    self.project:SetTitle("Project")
    self.project:SetIcon("icon16/application_side_tree.png")
    self.tree = vgui.Create("DTree",self.project)
    self.tree:Dock(FILL)
    self.tree:DockMargin(-4,-4,-4,0)
    self.tree.root = self.tree:AddNode("DFrame")
    self.tree.root:SetRoot(true)
    self.tree.root:SetIcon("icon16/application.png")
    self.prop = vgui.Create("DProperties",self.project)
    self.prop:Dock(BOTTOM)
    self.prop:DockMargin(-4,0,-4,-4)

    self.canvas = vgui.Create("DFrame",self)
    self.canvas:SetTitle("Canvas")
	self.canvas:Dock(FILL)
	self.canvas:DockMargin(0,0,0,-4)
	self.canvas:ShowCloseButton(false)

    self.rightpan = vgui.Create("EditablePanel",self)
    self.rightpan:Dock(RIGHT)
    self.rightpan:DockMargin(0,-1,-4,-4)
    self.rightpan:SetWide(300)
    self.elements = vgui.Create("DFrame",self.rightpan)
    self.elements:Dock(FILL)
    self.elements:SetTitle("Elements")
    self.elements:SetIcon("icon16/application_side_list.png")
    self.elements:ShowCloseButton(false)
    self.icons = vgui.Create("DFrame",self.rightpan)
    self.icons:SetTall(300)
    self.icons:Dock(BOTTOM)
    self.icons:SetTitle("Icon Browser")
    self.icons:SetIcon("icon16/application_view_icons.png")
    self.icons:ShowCloseButton(false)
    local path_pnl = vgui.Create("EditablePanel",self.icons)
	path_pnl:Dock(TOP)
	path_pnl:DockMargin(4,0,4,4)
	path_pnl:SetTall(24)
	local path = vgui.Create("DTextEntry",path_pnl)
	path:SetText("")
	path:Dock(FILL)
	path:SetEditable(false)
	local copy = vgui.Create("DButton",path_pnl)
	copy:Dock(RIGHT)
	copy:SetWide(24)
	copy:SetImage("icon16/page_copy.png")
	copy:SetText("")
	function copy:DoClick()
		SetClipboardText(path:GetText())
	end
	local browser = vgui.Create("DIconBrowser",self.icons)
	browser:Dock(FILL)
	browser:DockMargin(4,0,4,4)
	function browser:OnChange()
		path:SetText(self:GetSelectedIcon())
	end

end

vgui.Register("vguieditor",PANEL,"DFrame")

concommand.Add("vguieditor",function()
	vgui.Create("vguieditor")
end)