-- Motorolla GM340
Metrostroi.DefineSystem("81_motorollagm340")
TRAIN_SYSTEM.DontAccelerateSimulation = true
function TRAIN_SYSTEM:Initialize()
          self.State = -1 
          self.Channel = 1 
          self.RChannel = 0
          self.DefaultChannel = math.random(1,4) 
          self.Lamp1 = false 
          self.Lamp2 = false  
          self.Lamp3 = false 
          self.NoVB = math.random()>0.5
          self.Voice = 1 
          self.TriggerNames = {"Motorolla_C1","Motorolla_C2","Motorolla_C3","Motorolla_C4","Motorolla_R1","Motorolla_R2","Motorolla_VoiceToggleSwitch","Motorolla_On"}
          for i = 1, 4 do 
          self.Train:LoadSystem("Motorolla_C" .. i,"Relay","Switch")
          end 
          self.Train:LoadSystem("Motorolla_R1","Relay","Switch")
          self.Train:LoadSystem("Motorolla_R2","Relay","Switch")
          self.Train:LoadSystem("Motorolla_On","Relay","Switch")
          self.Train:LoadSystem("Motorolla_VoiceToggleSwitch","Relay","Switch",{maxvalue=4,defaultvalue=1,bass=true})
          self.Triggers = {}
          for k,v in pairs(self.TriggerNames) do
              self.Triggers[v] = false
          end
end
function TRAIN_SYSTEM:Inputs()
    return {}
end 
function TRAIN_SYSTEM:Outputs()
    return {}
end
function TRAIN_SYSTEM:Trigger( n, v )
         local n = n:gsub("Motorolla_","")
         local Train = self.Train 
         if self.State == 1 then
            for i = 1, 4 do  
                if n == "C" .. i then 
                   self.RChannel = -1
                   self.Channel = i
                end 
            end 
            if n == "R1" or n == "R2" then 
                 self.RChannel = n == "R1" and 1 or 2 
                 self.Channel = -1
            end 
            if n == "VoiceToggleSwitch" then 
               self.Voice = Train.Motorolla_VoiceToggleSwitch.Value
            end 
        end 
end 
function TRAIN_SYSTEM:Think()
         local Train = self.Train 
         local Power =  Train:GetNW2Bool("VPR")
         if Power and self.State == -1 and not self.MotorollaStart then 
            self.MotorollaStart = CurTime()+0.1
         end 
         if Power and self.State == -1 and self.MotorollaStart and CurTime()-self.MotorollaStart > 1 then 
            self.State = 1 
            self.SetChannel = CurTime()+1 
            self.Channel = -2
            Train:PlayOnce("motorolla_on", "cabin", 1)
         end 
         if Power and self.State == 1 and self.SetChannel and CurTime()-self.SetChannel > 1 then 
                 self.Channel = self.DefaultChannel
                 self.SetChannel = nil 
         end 
         self.Voice = Train.Motorolla_VoiceToggleSwitch.Value
         if not Power and self.State ~= -1 then self.State = -1 self.MotorollaStart = nil self.Channel = -1 self.RChannel = -1 self.Voice = 1 self.Lamp1 = false self.Lamp2 = false self.Lamp3 = false end 
         for i = 1, 4 do 
         Train:SetNW2Bool("Motorolla_Channel" .. i, self.Channel == i)
         end 
         Train:SetNW2Bool("Motorolla_RChannel1", self.RChannel == 1)
         Train:SetNW2Bool("Motorolla_RChannel2", self.RChannel == 2)
         Train:SetNW2Int("Motorolla_Voice", self.Voice)
         Train:SetNW2Bool("MotorollaStart",self.MotorollaStart and CurTime()-self.MotorollaStart>1)
         if Train:GetNW2Bool( "MotorollaStart" ) then self.MotorollaStart = nil end 
         self.Lamp1 = Train:GetNW2Bool("VPR:Work") and CurTime()%1>0.5 and self.State == 1 
         self.Lamp3 = not Train:GetNW2Bool("VPR:Work") and CurTime()%1>0.6 and self.State == 1 and not self.Lamp2 or self.Channel == -2
         for i=1,3 do Train:SetNW2Bool("Motorolla_Lamp" .. i, self["Lamp" .. i] == true) end 
         if Power and self.State == 1 then
			for k,v in pairs(self.TriggerNames) do
				if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
					self:Trigger(v,Train[v].Value > 0.5)
					self.Triggers[v] = Train[v].Value > 0.5
				end
			end
		end
end 
