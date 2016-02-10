include("vguieditor_elements.lua")
local PANEL = {}

PANEL.SizeX = ScrW()-50
PANEL.SizeY = ScrH()-50

function PANEL:Init()
    self:SetTitle("Derma Designer")
    self:SetIcon("icon16/application_edit.png")
    self:SetSize(self.SizeX,self.SizeY)
    self:Center()
    self:MakePopup()
    
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
end

vgui.Create("vguieditor",PANEL,"DFrame")
