-- Metrostroi Subway Simulator
-- Copyright vasyapetrovpvp (https://steamcommunity.com/id/vasyapetrovpvp/)
-- 2020 - 2023
-- Прошивка всех разновидностей блока информатора, используемого в Киевском метрополитене
Metrostroi.DefineSystem("81_717kkl_informator")
TRAIN_SYSTEM.DontAccelerateSimulation = true
local ANNOUNCER_CACHE_LIMIT = 30
-- Инит блока
function TRAIN_SYSTEM:Initialize()
    self.LineOut = 0	
    self.Schedule = {}		
	self.Line = 1
	self.Path = false
	self.Voice = 1
	self.State = -1
	self.Inf540 = false -- Версия РИ с 2к и 5к 
	self.Train:LoadSystem("INF_Prev", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Stop", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Next", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("R_Program1", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_TabloNext", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_TabloPrev", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Play", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("R_ASNPOn", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Do1", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Do2", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Do3", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_Do4", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_81", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_10", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_11", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_VoiceP", "Relay", "Switch", {
		bass = true
	})
	self.Train:LoadSystem("INF_VoiceN", "Relay", "Switch", {
		bass = true
	})
	for i = 1, 9 do
		self.Train:LoadSystem("INF_" .. i, "Relay", "Switch", {
			bass = true
		})
	end
	self.UseDopButtons = 0
    self.TriggerNames = {
		"INF_1",
		"INF_2",
		"INF_3",
		"INF_4",
		"INF_5",
		"INF_6",
		"INF_7",
		"INF_8",
		"INF_9",
		"INF_81",
		"INF_10",
		"INF_11",
		"INF_Do1",
		"INF_Do2",
		"INF_Do3",
		"INF_Do4",
		"INF_Prev",
		"INF_Stop",
		"INF_Next",
		"INF_Play",
		"INF_VoiceP",
		"INF_VoiceN",
		"R_Program1",
		"INF_TabloPrev",
		"INF_TabloNext",
    }
    self.Triggers = {}
	for k,v in pairs(self.TriggerNames) do
		self.Triggers[v] = false
	end
	self.SoundStates = {[4]=false,[5]=false,[6]=false}
	self.Arrived = false
end
if TURBOSTROI then return end
-- : Реализовать разновидности прошивок РИ
function TRAIN_SYSTEM:Init540Inf()
         self.Inf540Init = true 
		 self.Ver540 = math.random(1,4) -- 1 версия: Дефолт с функцией озвучивания в кабину, 2 версия дефолт без функции озвучивания в кабину, 3 версия русский текст, 4 версия самостоятельное проигрывания напрямку руху, перва яверсия
		 self.Connect540LSD = math.random()>0.6 -- Подключение 15 провода (пропуск ОДЗ при закрытых дверях)
		 local dates = { "27.04.16", "13.12.11", "30.05.13" } 
		 self.VersionDate540 = dates[math.random(1,3)]
end 
function TRAIN_SYSTEM:Inputs()
    return {}
end 
function TRAIN_SYSTEM:Outputs()
    return {"K1","K2","LineOut"}
end
if SERVER then
	util.AddNetworkString("metrostroi_infkiev_announcer")
	function TRAIN_SYSTEM:TriggerInput(name,value)
		if name == "Sync" then
			self:ToDefault()
			self:ResetAll()			
			self:SyncASNP()
		elseif name == "540" then  -- Информатор 540 версии
			self.Inf540 = true
			if self.Inf540 then self:Init540Inf() end   
		elseif name == "IsSBLTrain" then  -- Доп. сообщения СБЛ
			self.InfSBL = true 
		elseif name == "IsSPL" then -- СПЛ 
			self.InfSPL = true 
		elseif name == "IsTerrain" then -- Воздуншщая тревога
			self.IsTerrain = value 
		elseif name == "Line" and Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then
			self.Line = math.min(value,#Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)])	
		elseif name ~= "Line" then
			self[name] = value		

		end
	end
	function TRAIN_SYSTEM:Trigger(name,value)
		local name = name:gsub("INF_","")
		local Train = self.Train
		local char = tonumber(name)
		if self.Error then return end  

		if self.State == 2 then 
			if self.Do1 then 
				if self.ToReset1 and self.ToReset2 and name == "Next" and not self.Path then 
					self.Path = true 
					self:SyncASNP() 
					self:ToDefault()
					self.ToReset1 = false 
					self.ToReset2 = false 
					self.State = 5
				end 
				if self.ToReset1 and self.ToReset2 and name == "Prev" and self.Path then 
					self.Path = false 
					self:SyncASNP() 
					self:ToDefault()
					self.ToReset2 = false 
					self.ToReset1 = false 
					self.State = 5
				end 
			end 
		end 
		if self.State == 2 and value then
			if char and char >= 4 then 
					self:InitSpeaker() 
				    if self.LineOut>0 then Train.Announcer:Reset() end 
					local rec = (not self.old and "kievrec" or "kievrec_old")..char..(self.SoundStates[char] == nil and "" or (self.SoundStates[char] and "2" or "1")) 
		            self:AnnQueue("click")
					self:AnnQueue(rec) 
		            self:AnnQueue("click") 
					if char == 6 or (char == 7 and self.IsTerrain) then
						self:AnnQueue(-1)					 
					end
		
					if char == 7 then self.ToReset1 = true end 
					if char == 4 then self.ToReset2 = true end 

					if self.SoundStates[char] ~= nil then
						self.SoundStates[char] = not self.SoundStates[char]
					end
					self.UseDopButtons = self.UseDopButtons + 1 
					self.LastUse = CurTime()
			end 
			if name == "VoiceP" then 
				if self.Voice >= 0.1 then 
					self.Voice = self.Voice - 0.3
					self:CabQueue{"kievrec_oldp"}
				end
			end
			if name == "VoiceN" then
				if self.Voice < 4 then 
					self.Voice = self.Voice + 0.3
					self:CabQueue{"kievrec_oldp"}
				end
			end
			-- Кнопки с функцией памяти, 4 максимум
			if name == "Do1" and not (self.Do2 or self.Do3 or self.Do4)  then 
			    self.Do1 = not self.Do1
				self.Lamp1 = self.Do1
				self:InitSpeaker()
				if self.LineOut>0 then return end 
				if self.Do1 then 
				self:AnnQueue("click")
				self:AnnQueue("kievdo_1")
				self:AnnQueue("click")
				end 
			end 
			if name == "Do2" and not (self.Do1 or self.Do3 or self.Do4) then 
			     self.Do2 = not self.Do2 
				 self.Lamp2 = self.Do2 
				 self:InitSpeaker()
				 if self.LineOut>0 then return end 
				 if self.Do2 then 
					self:AnnQueue("click")
					self:AnnQueue("kievdo_2")
					self:AnnQueue("click")
				 end 
			end  
			if name == "Do3" and not (self.Do1 or self.Do2 or self.Do4) then 
				self.Do3 = not self.Do3 
				self.Lamp3 = self.Do3
				self:InitSpeaker()
				if self.LineOut>0 then return end 
				if self.Do3 then 
				   self:AnnQueue("click")
				   self:AnnQueue("kievdo_3")
				   self:AnnQueue("click")
				end 
			end 
			if name == "Do4" and not (self.Do1 or self.Do2 or self.Do3) then 
				self.Do4 = not self.Do4
				self.Lamp4 = self.Do4
				self:InitSpeaker()
				if self.LineOut>0 then return end 
				if self.Do4 then 
				   self:AnnQueue("click")
				   self:AnnQueue("kievdo_4")
				   self:AnnQueue("click")
				end
			end 
			-- Основные кнопки работы информатора
			if name == "R_Program1" or name == "Play" then
				self:Play(self.Arrived,nil,nil,self.LineOut>0)  
				self:Next()
				self.ToReset1 = false 
				self.ToReset2 = false 
			end 
			if name == "Stop" then
				Train.Announcer:Reset()
			end
			if name == "Prev" and not self.ToReset2 then
				self:Prev()
				if not self.Inf540 and not self.inf2003 then
				if self.LineOut>0 then self:CabReset() 	Train.Announcer:Reset() end 
				self:Play(self.Arrived, nil, true, self.LineOut>0)
				else
				if self.LineOut>0 then self:CabReset() 	Train.Announcer:Reset() end 
				end 
			end 
			if name == "Next" and not self.ToReset2 then
				self:Next()
				if not self.Inf540 and not self.inf2003 then 
				if self.LineOut>0 then self:CabReset() 	Train.Announcer:Reset() end 
				self:Play(self.Arrived, nil, true, self.LineOut>0)
				else
				if self.LineOut>0 then self:CabReset() 	Train.Announcer:Reset() end 
				end 
				self:UpdateBoards()
			end 
		end
	end
    function TRAIN_SYSTEM:CabQueue(tbl)
 		if not self.AnnTable then self.AnnTable = self.Train.Announcer.AnnTable end
		if not Metrostroi[self.AnnTable] then return end
		if istable(tbl) then 
        for k, v in pairs(tbl) do
            local tbl = Metrostroi[self.AnnTable][self.Train:GetNW2Int("Announcer", 1)]
            if v~=-2 then  
                table.insert(self.Schedule, tbl[v] or v)
            else
                self:CabReset()
            end
		end
	end 
    end
    function TRAIN_SYSTEM:CabReset()
        if #self.Schedule > 0 then
            self.Schedule = {}
            self.AnnounceTimer = nil
            if self.BuzzWork then self:CabQueue{"buzz_end"} end
        end
        self:CabWriteMessage("_STOP")
	end	
	
	function TRAIN_SYSTEM:CANReceive(source,sourceid,target,targetid,textdata,numdata)
		if sourceid == self.Train:GetWagonNumber() then return end
		if textdata == "Path" then self.Path = numdata > 0 end
		if textdata == "Line" then self.Line = numdata end
		if textdata == "FirstStation" then self.FirstStation = numdata end
		if textdata == "LastStation" then self.LastStation = numdata end		
	    if textdata == "Activate" then
			self:ToDefault()
			self:ResetAll()
		end
	end	
	function TRAIN_SYSTEM:SyncASNP()
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Path",self.Path and 0 or 1)
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Line",self.Line)
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"FirstStation",self.FirstStation)
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"LastStation",self.LastStation)
		self.Train:CANWrite("ASNP",self.Train:GetWagonNumber(),"ASNP",nil,"Activate")
	end	
    function TRAIN_SYSTEM:CabWriteMessage(msg)
        net.Start("metrostroi_cis_announcer", true)
        net.WriteEntity(self.Train)
        net.WriteString(msg)
        net.Broadcast()
    end		
	-- Работа с громкоговорителем кабины
	function TRAIN_SYSTEM:CabinQueue(msg,skip)
		if skip then
			self:CabReset()
			self.Train:SetNW2Int("Inf:Station",self.Station)
			self.Train:SetNW2Bool("Inf:Arrived",self.Arrived)			
		end
		if msg and type(msg) ~= "table" then
			self:CabQueue{msg}
		else
			self:CabQueue(msg)
		end
	end			
	-- Работа с громкоговорителем салона
	function TRAIN_SYSTEM:AnnQueue(msg,skip)
		local Announcer = self.Train.Announcer
		if skip then
			Announcer:Reset()
			self.Train:SetNW2Int("Inf:Station",self.Station)
			self.Train:SetNW2Bool("Inf:Arrived",self.Arrived)			
		end
		if msg and type(msg) ~= "table"  then
			Announcer:Queue{msg}
		else
			Announcer:Queue(msg)
		end
	end
	-- Функции перемотки
	function TRAIN_SYSTEM:Prev()
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		if tbl.Loop then
			if not self.Arrived then
				if self.Path then
					self.Station = self.Station + 1
				else
					self.Station = self.Station - 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
				end
				--self.Station = 1
				self.Arrived = true
			else
				self.Arrived = false
			end
		else
			if not self.Arrived and self.Station ~= (self.Path and self.LastStation or self.FirstStation) then
				if self.Path then
					self.Station = math.min(self.LastStation,self.Station + 1)
				else
					self.Station = math.max(self.FirstStation,self.Station - 1)
				end
				self.Arrived = true
			else
				if self.Station == (self.Path and self.LastStation or self.FirstStation) and not self.Arrived then
					self.Station = self.Path and self.FirstStation or self.LastStation
				else
					self.Arrived = false
				end
			end
		end
		if self.Station == (self.Path and self.FirstStation or self.LastStation) and self.Arrived then
			self:Prev()
		end				
		self:UpdateBoards()
	end	
	function TRAIN_SYSTEM:Next()
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		if tbl.Loop then
			if self.Arrived then
				if self.Path then
					self.Station = self.Station - 1
				else
					self.Station = self.Station + 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and #tbl or 1
				end
				if self.Station == 0 or self.Station > #tbl then
					self.Station = self.Station == 0 and (self.LastStation > 0 and self.LastStation or #tbl) or 1
				end
				self.Arrived = false
				--self.Station = 1
			else
				self.Arrived = true
			end
		else
			if self.Arrived then
				if self.Station ~= (self.Path and self.FirstStation or self.LastStation) then
					if self.Path then
						self.Station = math.max(self.FirstStation,self.Station - 1)
					else
						self.Station = math.min(self.LastStation,self.Station + 1)
					end
					self.Arrived = false
				else
					self:ToDefault()
				end
			else
				self.Arrived = true
			end
		end
		if self.Station == (self.Path and self.FirstStation or self.LastStation) and self.Arrived and not self.Inf540 and not self.inf2003 then
			-- self:Next()
		end				
		self:UpdateBoards()
	end	
	-- Действия, выполняемые после настройки и активации информатора
	function TRAIN_SYSTEM:ToDefault()
		local num = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and #Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line] or 1
		self.FirstStation = 1
		self.LastStation = num
		self.Station = self.Path and self.LastStation or self.FirstStation
		self.Arrived = not (self.Inf540 or self.inf2003) 
	end
	-- Логика работы пуска записи
	function TRAIN_SYSTEM:Play(dep,not_last,cab,skip)
		local message = {}
		if not cab then
		if not self.Arrived and self.Train.Screen then 
		self.Train.Screen:TriggerCode(self.Station, dep, self.Path)
		self.TriggeredCode = nil
		else 
		self.TriggeredCode = CurTime()+6.3
		end 
	    end 
		self:InitSpeaker()
		self:PKDMConnect()
		
		self.SoundStates = {[4]=false,[5]=false,[6]=false,[81]=false,[9]=false}
		local tbl =  ( Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line] or {} )
		local stbl = tbl[self.Station]
		local last,lastst
		local path = self.Path and 2 or 1
		if tbl.Loop then
			last = self.LastStation
			lastst = not dep and self.LastStation > 0 and self.Station == last and tbl[last].arrlast
		else
			last = self.Path and self.FirstStation or self.LastStation
			lastst = not dep and self.Station == last and tbl[last].arrlast
		end
		if dep then
			message = stbl.dep[path]		
		elseif self.Station ~= (self.Path and self.LastStation or self.FirstStation) then
			if lastst then
				message = stbl.arrlast[path]
			else
				message = stbl.arr[path]
			end
		end
		if not cab then  
		message[0] = math.Rand(0.4,0.75)
		else 
		message[0] = nil 
		end 
		if message and istable(message) and message[1] and message[1]=="doors_closing" and (self.Train.KD and self.Train.KD.Value==1 or self.Train.TMS and self.Train.TMS.LSD==true) then  
		   message[1] = message[3] 
		   message[2] = nil 
		   message[3] = nil
		  if self.Train.Screen then self.Train.Screen:TriggerCode(self.Station, dep, self.Path) end
		else 
			if dep and message[1]~="doors_closing" and (self.Train.KD and self.Train.KD.Value==0 or self.Train.TMS and not self.Train.TMS.LSD) then msold = message[1];message[1] = "doors_closing";message[2]=3;message[3]=msold end 
		end 

		if not dep and self.Station == (self.Path and self.LastStation or self.FirstStation) and not tbl.Loop then
			if self.Inf540 or self.inf2003 then self:AnnQueue({not self.Path and "t_gd" or "gd_t"}) else self:AnnQueue(-1); self:Next() end 
		end  
	
		if lastst and not stbl.ignorelast then self:AnnQueue(-1); self:Next() end

	    if not cab then
		if self.old and self.Train:GetClass():find("502") then 
				self:CabQueue{"kievrec_oldp", skip}
		end
		self:AnnQueue{"click"}
		self:AnnQueue(message,skip) 
		self:AnnQueue{"click"}
		for i=1,4 do 
			if not self.Arrived and self["Do"..i] and not self.Inf540 then 
				 self:AnnQueue{"click"}
                 self:AnnQueue({0.2,"kievdo_"..i})
				 self:AnnQueue{"click"}
			end 
			if self.Arrived and self["Do"..i] and self.Inf540 then 
				self:AnnQueue{"click"}
				self:AnnQueue({0.2,"kievdo_"..i})
				self:AnnQueue{"click"}
		   end 
		end 
		else 
		if message and istable(message) and message[1] == "doors_closing" then message[1]=message[3];message[2]=nil;message[3]=nil end
		self.R_E = CurTime()+4.2 
		self:CabQueue{"click"}
		self:CabQueue(message,skip)
		self:CabQueue{"click"}
		end 
		local stbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line][self.Station]
		if self.LastStation > 0 and not dep and self.Station ~= last and tbl[last].not_last and (stbl.have_inrerchange or math.abs(last-self.Station) <= 3) then
			local ltbl = tbl[last]
			if stbl.not_last_c then
				local patt = stbl.not_last_c[path]
				if not cab then
				self:AnnQueue(ltbl[patt] or ltbl.not_last)
				end 
			else
				if not cab then 
				self:AnnQueue(ltbl.not_last)
				end 
			end
		end
		self:UpdateBoards()
	end
	function TRAIN_SYSTEM:UpdateBoards()
		if not self.PassSchemeWork then return end
		local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)][self.Line]
		local stbl = tbl.LED
		local last = self.Path and self.FirstStation or self.LastStation

		local curr = 0
		if self.Path then
			for i=#stbl,self.Station+1,-1 do
				if stbl[i] then
					curr = curr + stbl[i]
				end
			end
		else
			for i=1,self.Station-1 do
				if stbl[i] then
					curr = curr + stbl[i]
				end
			end
		end
		local nxt = 0
		if self.Arrived then
			curr = curr + stbl[self.Station]
		else
			nxt = stbl[self.Station]
		end
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"PassSchemes",nil,"Current",curr)
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"PassSchemes",nil,"Arrival",nxt)
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"PassSchemes",nil,"Path",self.Path)
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"Tickers",nil,"Next",not self.Arrived)
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"Tickers",nil,"Curr",tbl[self.Station][2])
		self.Train:CANWrite("Inf",self.Train:GetWagonNumber(),"Tickers",nil,"Last",tbl[last] and tbl[last].not_last and tbl[last][2])
	end	
	function TRAIN_SYSTEM:AddMessage(name,tbl)
		Metrostroi.AnnouncementsASNP[name] = tbl
		Metrostroi[self.Train.Announcer.AnnTable][self.Train:GetNW2Int("Announcer", 1)][name] = tbl
	end	
	function TRAIN_SYSTEM:InitSpeaker()
		local Train = self.Train
		if not Metrostroi.AnnouncementsASNP then Metrostroi.AnnouncementsASNP = {} end
		if not Metrostroi[Train.Announcer.AnnTable] then Metrostroi[Train.Announcer.AnnTable] = {} end
		if not Metrostroi[Train.Announcer.AnnTable][Train:GetNW2Int("Announcer",1)] then Metrostroi[Train.Announcer.AnnTable][Train:GetNW2Int("Announcer",1)] = {} end
		-- Объявления с функцией повторения
		-- ВЕРСИЯ СБЛ
		if self.InfSBL then 
		self:AddMessage("kievdo_1", {"kyiv_announce/sbl/special/to_darnytsia.mp3",2.5}) -- До Дарницы
		if not self.IsTerrain then self:AddMessage("kievdo_2", {"kyiv_announce/sbl/special/to_svyatoshin.mp3",2.5}) end  -- До Святошина 
		self:AddMessage("kievdo_3", {"kyiv_announce/sbl/special/institut.mp3",5.5}) -- Хрещатик закрыт
		self:AddMessage("kievdo_4", {"kyiv_announce/sbl/special/to_khreshatyk.mp3",2.5}) -- До Хрещатика 
		elseif self.InfSPL then 
		self:AddMessage("kievdo_1", {"kyiv_announce/new/special/goes_luk.mp3",2.5}) -- До Дарницы
		self:AddMessage("kievdo_2", {"kyiv_announce/new/special/goes_har.mp3",2.5}) -- До Святошина
		self:AddMessage("kievdo_3", {"kyiv_announce/new/special/goes_bor.mp3",5.5}) -- Хрещатик закрыт
		self:AddMessage("kievdo_4", {"kyiv_announce/new/special/to_khreshatyk.mp3",2.5}) -- До Хрещатика 
		else
		self:AddMessage("kievdo_1", {"kyiv_announce/inf_2024/maidan_1.mp3",7.9}) -- майдан на пересдаку
		self:AddMessage("kievdo_" .. (self.Inf540 and "3" or "2"), {"kyiv_announce/inf_2024/olimp_1.mp3",4.9}) -- олимп закрыта
		self:AddMessage("kievdo_" .. (self.Inf540 and "2" or "3"), {"kyiv_announce/inf_2024/to_vasylkivska.mp3",2.5}) -- до васильковской 
		self:AddMessage("kievdo_4", {"kyiv_announce/inf_2024/maidan_2.mp3",5.5}) -- майдан закрыт
		end 

		self:AddMessage("kiev_540_click", {"kyiv_announce/otl/special/click_kyiv.mp3",0.5}) -- Старт
		-- Диагностика
		self:AddMessage("kiev_540_start", {"kyiv_announce/new/00_1.mp3",2}) -- Старт
		self:AddMessage("kiev_diag_start", {"kyiv_announce/inf_2024/inf_diag_start.mp3",2.5}) -- Старт
		self:AddMessage("kiev_diag_ok", {"kyiv_announce/inf_2024/inf_diag_success.mp3",4.5}) -- Без ошибок
		self:AddMessage("kiev_diag_error", {"kyiv_announce/inf_2024/inf_diag_error.mp3",2.3}) -- С ошибкой
		self:AddMessage("kiev_diag_fatalerror", {"kyiv_announce/otl/special/inf_diag_fatalerror.mp3",10.5}) -- Пиздец бля ...
		-- Обычные ДОПы
		self:AddMessage("kievdoors",{"kyiv_announce//dveri.mp3",2.689}) -- притулятися до дверей
		self:AddMessage("kievrec41",{"kyiv_announce/inf_2024/bistro1.mp3",3.030}) -- швидше 1 
		self:AddMessage("kievrec42",{"kyiv_announce/inf_2024/bistro2.mp3",5.6}) -- швидше 2
		self:AddMessage("kievrec51",{"kyiv_announce/inf_2024/cleardoors1.mp3",3.448}) -- видпустить 1
		self:AddMessage("kievrec52",{"kyiv_announce/inf_2024/cleardoors2.mp3",3.448}) -- видпустить 2 
		self:AddMessage("kievrec62",{"kyiv_announce/inf_2024/last2.mp3",4.526}) -- выйдить 1 
		self:AddMessage("kievrec61",{"kyiv_announce/inf_2024/last1.mp3",4.7}) -- выйдить 2 
		self:AddMessage("kievrec811", {"kyiv_announce/inf_2024/otpr1.mp3",3.373}) -- за декилько хвилин 1 
		self:AddMessage("kievrec812", {"kyiv_announce/inf_2024/otpr2.mp3",3.373}) -- за декильво хвилин 2 
		if self.InfSBL and self.IsTerrain then 
		self:AddMessage("kievdo_2", {"kyiv_announce/sbl/special/to_arsenalna.mp3",4.6})
		self:AddMessage("kievrec7", {"kyiv_announce/inf_2024/airraid.mp3",12.6}) -- повитряна 
		else 
		self:AddMessage("kievrec7", {"kyiv_announce/inf_2024/texnical.mp3",3.6}) -- технична
		end
	
		self:AddMessage("kievrec8", {"kyiv_announce/inf_2024/bez.mp3",1.280}) -- маневры
		self:AddMessage("kievrec91", {"kyiv_announce/inf_2024/odz1.mp3",2.272}) -- одз 1
		self:AddMessage("kievrec92", {"kyiv_announce/inf_2024/odz2.mp3",2.272}) -- одз 2 
		self:AddMessage("kievrec10", {"kyiv_announce/sbl/special/maidan_closed.mp3",9.3}) -- Майдан на Пересадку
		self:AddMessage("kievrec11", {"kyiv_announce/inf_2024/doorsz.mp3",4.6}) -- Прислоняться к дверям небезопасно
		self:AddMessage("kievrec_oldp", {"kyiv_announce/sbl/special/pilik.mp3",0.9}) -- пилик

		-- Для 2003 и 540 
		self:AddMessage("kiev_ready_new_1", {"kyiv_announce/special/inf_ready_new.mp3",3})
		self:AddMessage("kiev_ready_new_2", {"kyiv_announce/special/inf_ready.mp3",3})
        -- Старый информатор с дохлым динамиком
		self:AddMessage("kievrec0_old", {"kyiv_announce/rri/special/ready_rri.mp3",2.3})
		self:AddMessage("maskkiev_old",{"kyiv_announce/special/mask.mp3",4.5})
		self:AddMessage("kievrec_old41",{"kyiv_announce/rri/special/bistro1.mp3",3.030})
		self:AddMessage("kievrec_old42",{"kyiv_announce/rri/special/bistro2.mp3",5.6})
		self:AddMessage("kievrec_old51",{"kyiv_announce/rri/special/cleandoors1.mp3",2.246})
		self:AddMessage("kievrec_old52",{"kyiv_announce/rri/special/cleandoors2.mp3",3.448})
		self:AddMessage("kievrec_old61",{"kyiv_announce/rri/special/last2.mp3",7.526})
		self:AddMessage("kievrec_old62",{"kyiv_announce/rri/special/last1.mp3",3.5})
		self:AddMessage("kievrec_old811", {"kyiv_announce/rri/special/otpr1.mp3",2.373})
		self:AddMessage("kievrec_old812", {"kyiv_announce/rri/special/otpr2.mp3",2.373})
		self:AddMessage("kievrec_old7", {"kyiv_announce/rri/special/texnical.mp3",3.6})
		self:AddMessage("kievrec_old8", {"kyiv_announce/special/bez.mp3",1.280})
		self:AddMessage("kievrec_old91", {"kyiv_announce/rri/special/odz1.mp3",2.272})
		self:AddMessage("kievrec_old92", {"kyiv_announce/rri/special/odz2.mp3",2.272})
	end
	function TRAIN_SYSTEM:ResetAll()
		self.Train.Announcer:Reset()		
		self:CabReset()
		self.Lamp1 = false 
		self.Lamp2 = false
		self.Lamp3 = false 
		self.Lamp4 = false 
		self.LockedDoors = false
		self.Error = false
	end
	function TRAIN_SYSTEM:PKDMConnect()
			 local Train = self.Train 
			 if not Train.PKDM then return end
			 if not self.State == 2 then 
				Error("This announce is not ready")
				return 
			 end
			 if not Train.PKDM.Power then return end 
			 local tbl = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)]
			 local stbl = tbl[self.Line] and tbl[self.Line][self.Station]  
			 Train.PKDM.PKDM_LeftDoors = stbl.right_doors and 0 or 1
			 Train.PKDM.PKDM_RightDoors = stbl.right_doors and 1 or 0
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train 
		self.IsKyivSounds = Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] and (Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)].name:find("Kyiv") or Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)].name:find("Киевского") or Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)].name:find("Kiev") or Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)].name:find("KYIV"))
		self.old = Train:GetNW2Int("RadioInf",0) == 1 or Train:GetNW2Int("Inform",1) == 2 and Train:GetClass():find("spl") or Train:GetNW2Int("Inf",1)==1 and (Train:GetClass():find("502") or Train:GetClass():find("ezh"))
        self.inf2003 = Train:GetClass():find("spl") and Train:GetNW2Int("RadioInf",1) == 2 or (Train:GetClass():find("sbl") and Train:GetNW2Int("Inform",1)==2) or false 
		if self.State == 5 then
			self.Lamp1 = CurTime()%1 > 0.5 
			if not self.Outt then 
				self.Outt = CurTime()+2
				self:CabReset()
			end 
			if self.Outt and CurTime()-self.Outt > 0.5 and #self.Schedule == 0 then 
				self:ResetAll()
				self:CabinQueue{self.Path and "gd_t_c" or "t_gd_c"}
			end 
			if self.Outt and CurTime()-self.Outt > 1.8 then 
				self.State = 2
				self.Outt = nil 
			end 
		end 

		local PowerEKM = Train:GetClass():find("7080") and Train.QF19_2.Value*Train.Radio.Value*(Train:ReadTrainWire(3)+Train.VBVag.Value) > 0 or false 
		local Power = PowerEKM or Train.R_ASNPOn.Value>0
		if self.TriggeredCode and CurTime()-self.TriggeredCode> 1 and self.Train.Screen then 
			local d = self.Path and self.Station+1 or self.Station-1
			self.Train.Screen:TriggerCode(d, true, self.Path) 
			self.TriggeredCode = nil
		end  
		if self.State == 2 and not self.IsKyivSounds then
			self.State = -1 
		end	
		if self.inf2003 then 
             if not Power and self.State ~= -1 then self:ResetAll() self.InfTimer = nil self.State = -1 self.Lamp1 = false end 
			 if Power and self.State == -1 then 
				     self:InitSpeaker()
					 self.State = 1
			 end 
			 if Power and self.State == 1 then 
			    if self.IsKyivSounds then  
				self:CabinQueue{"click1","buzz_start"}
				self:CabinQueue{"kiev_ready_new_1"} 
				self:CabinQueue{"buzz_end","click2"}
				self:ToDefault()
				self:SyncASNP() 
				self.State = 2 
				end 
			 end  
		end 
		if self.State == 2 and not self.Error and self.LastUse and CurTime()-self.LastUse<60 and self.UseDopButtons > 40 then 
			self.Error = true 
			self.UseDopButtons = 0
		end
		if not Power and self.State ~= -1 or not Power and self.old and self.InfTimer then self:ResetAll() self.InfTimer = nil self.State = -1 self.Lamp1 = false end 
		if self.old then  
		  if Power and self.State == -1 then 
			  self:InitSpeaker()
			  self:CabinQueue{"click1","buzz_start"}
			  self:CabinQueue{"kievrec0_old"}
			  self:CabinQueue{"buzz_end","click2"}
              self.State = 1 
			  self.Lamp1 = true 
			  self.RRIStart = nil 
		  end 
	      if Power and self.State == 1 and #self.Schedule == 0 then self.Lamp1 = CurTime()%1>0.4 end 
		  if Power and self.State == 1 and not self.RRIStart then 
				self.RRIStart = CurTime()+math.Rand(4,6)
		  end 
		  if Power and self.State == 1 and self.RRIStart and CurTime()-self.RRIStart>1 then 
                 self.State = 2 
				 self:ToDefault()
				 self:SyncASNP() 
				 self.Lamp1 = false 
		  end 
		end 
		if not self.old and not self.Inf540 and self.R_E and CurTime()-self.R_E>1 and #self.Schedule>0 then self:CabReset();self.R_E=nil; end  
		if self.Inf540 then 
			if not Metrostroi.ASNPSetup[self.Train:GetNW2Int("Announcer",1)] then self.State = -2 end 
			if not Power and self.State ~= -1 then self:ResetAll()  self.State = -1 end
			if Power and self.State == -1 then self.State = Metrostroi.ASNPSetup and 0 or -2 self.InfTimer = CurTime() end
			if self.State == 0 and self.InfTimer and CurTime()-self.InfTimer > 1 then self:InitSpeaker() self.State = 1  self.InfTimer = CurTime(); self:CabinQueue{"kiev_540_click","kiev_540_click","kiev_540_click"}  end
			if self.State == 1 and CurTime()-self.InfTimer > 2.8 and #self.Schedule == 0 and CurTime()-self.InfTimer < 3.6 and self.IsKyivSounds then self:CabinQueue{"click1"} self:CabinQueue("kiev_540_start") self:CabinQueue{"click1"} end
			if self.State == 1 and CurTime()-self.InfTimer > 5.5 then self:ToDefault() self:SyncASNP() self.State = self.IsKyivSounds and 2 or 4 self.InfTimer = nil end
			if self.State == 1 then
				self.Lamp1 = CurTime()-self.InfTimer > 2 and CurTime()-self.InfTimer < 2.7 or CurTime()-self.InfTimer > 0 and CurTime()-self.InfTimer < 0.66
				self.Lamp2 = CurTime()-self.InfTimer > 2 and CurTime()-self.InfTimer < 2.7 or CurTime()-self.InfTimer > 0.66 and CurTime()-self.InfTimer < 1.33
				self.Lamp3 = CurTime()-self.InfTimer > 2 and CurTime()-self.InfTimer < 2.7 or CurTime()-self.InfTimer > 1.33 and CurTime()-self.InfTimer < 1.7
			end
		end 
		if not self.old and not self.Inf540 and not self.inf2003 then 
		   if not Power and self.State ~= -1 then 
			self.Lamp1 = false
			self.DiagStatus = -1
			self.State = -1 
			self:ResetAll() 
		   end 
		   if Power and self.State == -1 and not self.InfTimer then  
			  self.InfTimer = CurTime()+4 
			  self.State = 1
			  self.Lamp1 = true
			  self.NextLoad = nil
			  self:InitSpeaker()
		   end 
		   if Power and self.State == 1 and self.InfTimer and CurTime()-self.InfTimer<1 then self.Lamp1 = CurTime()%1>0.7; self:ToDefault() end 
		   if Power and self.State == 1 and self.InfTimer and CurTime()-self.InfTimer>1 and not self.NextLoad then 
			if not self.fatal then 
				self:CabinQueue{"click1","buzz_start"}
				self:CabinQueue{"kiev_diag_start"}
				self:CabinQueue{"buzz_end","click2"}
				self.NextLoad = CurTime()+math.Rand(5.05,9.9) 
				self.DiagStatus = -1
			else 
				self:CabinQueue{"click1","buzz_start"}
				self:CabinQueue{"kiev_diag_fatalerror"}
				self:CabinQueue{"buzz_end","click2"}
				self.NextLoad = CurTime()+100
				self.DiagStatus = -1
			end
		   end  
		   if Power and self.State == 1 and self.NextLoad and CurTime()-self.NextLoad>1 and self.DiagStatus == -1 then 
			self.NextLoad = CurTime()+8
			self.DiagStatus = not self.Do1 and not self.Do2 and not self.Do3 and not self.Do4 and self.IsKyivSounds and 1 or 0 
			if self.DiagStatus == 1 then 
			self:CabinQueue{"click1","buzz_start"}
			self:CabinQueue{"kiev_diag_ok"}
			self:CabinQueue{self.Path and "gd_t_c" or "t_gd_c"}
			self:CabinQueue{"buzz_end","click2"}
			else 
			for i = 1 , 4 do 
                  self["Lamp" .. i ] = self["Do" .. i]
				  self["Do"..i] = false 
				  Power = false 
			end 
			self:CabinQueue{"click1","buzz_start"}
			self:CabinQueue{"kiev_diag_error"}
			self:CabinQueue{"buzz_end","click2"}
			end 
		   end 
		   if Power and self.State == 1 and self.NextLoad and CurTime()-self.NextLoad<1 or self.DiagStatus ~= 1 and Power then 
			  self.Lamp1 = self.DiagStatus == 0 and CurTime()%1>math.Rand(0.7,15) or CurTime()%1>math.Rand(0.5,0.65)
		   end 
		   if Power and self.State == 1 and self.NextLoad and CurTime()-self.NextLoad>1 and self.DiagStatus == 1 then  
			  self.Lamp1 = false
			  self.State = 2 
			  self:SyncASNP() 
			  self.InfTimer = nil
			  self.SoundStates = {[4]=false,[5]=false,[6]=true,[81]=false,[9]=false}
		   end 
	    end 	  
		Train:SetNW2Bool("InfLamp1",self.Lamp1)
		Train:SetNW2Bool("InfLamp2",self.Lamp2)
		Train:SetNW2Bool("InfLamp3",self.Lamp3)
		Train:SetNW2Bool("InfLamp4",self.Lamp4)
        Train:SetNW2Bool("Inf:Power",Power)
		Train:SetNW2Int("INFState",self.State)
		Train:SetNW2Int("Inf:Voice", self.Voice)
		if self.InfTimer then
			Train:SetPackedRatio("INFTimer",CurTime()-(self.InfTimer or 0))
		end
		if Power and self.State > -1 then
			for k,v in pairs(self.TriggerNames) do
				if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
					self:Trigger(v,Train[v].Value > 0.5)
					self.Triggers[v] = Train[v].Value > 0.5
				end
			end
		end
		if #self.Schedule == 0 then 
		self:Trigger("Stop", not self.Inf540 and Train.R_UNch and Train.R_UNch.Value==0)
		end 
		Train:SetNW2Int("Inf:Line",self.Line)
		Train:SetNW2Int("Inf:FirstStation",self.FirstStation)
		Train:SetNW2Int("Inf:LastStation",self.LastStation)
		Train:SetNW2Bool("Inf:Path",self.Path)		
		Train:SetNW2Bool("Inf:IsKyiv", self.IsKyivSounds)
		Train:SetNW2Bool("Inf:Error", self.Error)
		self.LineOut = #Train.Announcer.Schedule+#self.Schedule>0 and 1 or 0
		if self.LineOut == 0 then
			Train:SetNW2Int("Inf:Station",self.Station)
			Train:SetNW2Bool("Inf:Arrived",self.Arrived)
		end
		Train:SetNW2Bool("Inf:Playing",self.LineOut>0)		
		--CabAnnouncer
        while #self.Schedule > 0 and (not self.AnnounceTimer or CurTime() - self.AnnounceTimer > 0) do
            local tbl = table.remove(self.Schedule, 1)
            if type(tbl) == "number" then
                self.AnnounceTimer = CurTime() + tbl
            elseif tbl == "noise_start" then
                self.NoiseWork = true
            elseif tbl == "noise_end" then
                self.NoiseWork = false
            elseif tbl == "buzz_start" then
                self.BuzzWork = true
            elseif tbl == "buzz_end" then
                self.BuzzWork = false
            elseif type(tbl) == "table" then
                self:CabWriteMessage(tbl[1])
                self.AnnounceTimer = CurTime() + tbl[2]
            else
                -- ErrorNoHalt("Announcer error in message "..tbl.."\n")
            end
        end
        if #self.Schedule == 0 and self.AnnounceTimer and CurTime() - self.AnnounceTimer > 0 then
            self.AnnounceTimer = nil
            if self.BuzzWork then self:CabQueue{"buzz_end"} end
        end
        if #self.Schedule > ANNOUNCER_CACHE_LIMIT then
            self:CabReset()
        end
	end
end
if CLIENT then
    local function createFont(name,font,size)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = 500,
            blursize = false,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
            scanlines = false,
        })
    end
	createFont("Infkiev","Liquid Crystal Display",30,400)
	createFont("TextKyiv","Calibri",30,400)
	createFont("KnigaRemonta","Times New Roman",30,400)
	createFont("Route540","bmt09",120,500)
	createFont("RouteNumber540","Moscow metro 1 v2 round",120,500)
   

	local function utf8charbytes (s, i)
		-- argument defaults
		i = i or 1
	 
		-- argument checking
		if type(s) ~= "string" then
			error("bad argument #1 to 'utf8charbytes' (string expected, got ".. type(s).. ")")
		end
		if type(i) ~= "number" then
			error("bad argument #2 to 'utf8charbytes' (number expected, got ".. type(i).. ")")
		end
	 
		local c = s:byte(i)
	 
		-- determine bytes needed for character, based on RFC 3629
		-- validate byte 1
		if c > 0 and c <= 127 then
			-- UTF8-1
			return 1
	 
		elseif c >= 194 and c <= 223 then
			-- UTF8-2
			local c2 = s:byte(i + 1)
	 
			if not c2 then
				error("UTF-8 string terminated early")
			end
	 
			-- validate byte 2
			if c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
	 
			return 2
	 
		elseif c >= 224 and c <= 239 then
			-- UTF8-3
			local c2 = s:byte(i + 1)
			local c3 = s:byte(i + 2)
	 
			if not c2 or not c3 then
				error("UTF-8 string terminated early")
			end
	 
			-- validate byte 2
			if c == 224 and (c2 < 160 or c2 > 191) then
				error("Invalid UTF-8 character")
			elseif c == 237 and (c2 < 128 or c2 > 159) then
				error("Invalid UTF-8 character")
			elseif c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
	 
			-- validate byte 3
			if c3 < 128 or c3 > 191 then
				error("Invalid UTF-8 character")
			end
	 
			return 3
	 
		elseif c >= 240 and c <= 244 then
			-- UTF8-4
			local c2 = s:byte(i + 1)
			local c3 = s:byte(i + 2)
			local c4 = s:byte(i + 3)
	 
			if not c2 or not c3 or not c4 then
				error("UTF-8 string terminated early")
			end
	 
			-- validate byte 2
			if c == 240 and (c2 < 144 or c2 > 191) then
				error("Invalid UTF-8 character")
			elseif c == 244 and (c2 < 128 or c2 > 143) then
				error("Invalid UTF-8 character")
			elseif c2 < 128 or c2 > 191 then
				error("Invalid UTF-8 character")
			end
		   
			-- validate byte 3
			if c3 < 128 or c3 > 191 then
				error("Invalid UTF-8 character")
			end
	 
			-- validate byte 4
			if c4 < 128 or c4 > 191 then
				error("Invalid UTF-8 character")
			end
	 
			return 4
	 
		else
			error("Invalid UTF-8 character")
		end
	end	
	utf8_lc_uc = {["a"] = "A", 	["b"] = "B", 	["c"] = "C", 	["d"] = "D", 	["e"] = "E", 	["f"] = "F", 	["g"] = "G", 	["h"] = "H", 	["i"] = "I", 	["j"] = "J", 	["k"] = "K", 	["l"] = "L", 	["m"] = "M", 	["n"] = "N", 	["o"] = "O", 	["p"] = "P", 	["q"] = "Q", 	["r"] = "R", 	["s"] = "S", 	["t"] = "T", 	["u"] = "U", 	["v"] = "V", 	["w"] = "W", 	["x"] = "X", 	["y"] = "Y", 	["z"] = "Z", 	["µ"] = "Μ", 	["à"] = "À", 	["á"] = "Á", 	["â"] = "Â", 	["ã"] = "Ã", 	["ä"] = "Ä", 	["å"] = "Å", 	["æ"] = "Æ", 	["ç"] = "Ç", 	["è"] = "È", 	["é"] = "É", 	["ê"] = "Ê", 	["ë"] = "Ë", 	["ì"] = "Ì", 	["í"] = "Í", 	["î"] = "Î", 	["ï"] = "Ï", 	["ð"] = "Ð", 	["ñ"] = "Ñ", 	["ò"] = "Ò", 	["ó"] = "Ó", 	["ô"] = "Ô", 	["õ"] = "Õ", 	["ö"] = "Ö", 	["ø"] = "Ø", 	["ù"] = "Ù", 	["ú"] = "Ú", 	["û"] = "Û", 	["ü"] = "Ü", 	["ý"] = "Ý", 	["þ"] = "Þ", 	["ÿ"] = "Ÿ", 	["ā"] = "Ā", 	["ă"] = "Ă", 	["ą"] = "Ą", 	["ć"] = "Ć", 	["ĉ"] = "Ĉ", 	["ċ"] = "Ċ", 	["č"] = "Č", 	["ď"] = "Ď", 	["đ"] = "Đ", 	["ē"] = "Ē", 	["ĕ"] = "Ĕ", 	["ė"] = "Ė", 	["ę"] = "Ę", 	["ě"] = "Ě", 	["ĝ"] = "Ĝ", 	["ğ"] = "Ğ", 	["ġ"] = "Ġ", 	["ģ"] = "Ģ", 	["ĥ"] = "Ĥ", 	["ħ"] = "Ħ", 	["ĩ"] = "Ĩ", 	["ī"] = "Ī", 	["ĭ"] = "Ĭ", 	["į"] = "Į", 	["ı"] = "I", 	["ĳ"] = "Ĳ", 	["ĵ"] = "Ĵ", 	["ķ"] = "Ķ", 	["ĺ"] = "Ĺ", 	["ļ"] = "Ļ", 	["ľ"] = "Ľ", 	["ŀ"] = "Ŀ", 	["ł"] = "Ł", 	["ń"] = "Ń", 	["ņ"] = "Ņ", 	["ň"] = "Ň", 	["ŋ"] = "Ŋ", 	["ō"] = "Ō", 	["ŏ"] = "Ŏ", 	["ő"] = "Ő", 	["œ"] = "Œ", 	["ŕ"] = "Ŕ", 	["ŗ"] = "Ŗ", 	["ř"] = "Ř", 	["ś"] = "Ś", 	["ŝ"] = "Ŝ", 	["ş"] = "Ş", 	["š"] = "Š", 	["ţ"] = "Ţ", 	["ť"] = "Ť", 	["ŧ"] = "Ŧ", 	["ũ"] = "Ũ", 	["ū"] = "Ū", 	["ŭ"] = "Ŭ", 	["ů"] = "Ů", 	["ű"] = "Ű", 	["ų"] = "Ų", 	["ŵ"] = "Ŵ", 	["ŷ"] = "Ŷ", 	["ź"] = "Ź", 	["ż"] = "Ż", 	["ž"] = "Ž", 	["ſ"] = "S", 	["ƀ"] = "Ƀ", 	["ƃ"] = "Ƃ", 	["ƅ"] = "Ƅ", 	["ƈ"] = "Ƈ", 	["ƌ"] = "Ƌ", 	["ƒ"] = "Ƒ", 	["ƕ"] = "Ƕ", 	["ƙ"] = "Ƙ", 	["ƚ"] = "Ƚ", 	["ƞ"] = "Ƞ", 	["ơ"] = "Ơ", 	["ƣ"] = "Ƣ", 	["ƥ"] = "Ƥ", 	["ƨ"] = "Ƨ", 	["ƭ"] = "Ƭ", 	["ư"] = "Ư", 	["ƴ"] = "Ƴ", 	["ƶ"] = "Ƶ", 	["ƹ"] = "Ƹ", 	["ƽ"] = "Ƽ", 	["ƿ"] = "Ƿ", 	["ǅ"] = "Ǆ", 	["ǆ"] = "Ǆ", 	["ǈ"] = "Ǉ", 	["ǉ"] = "Ǉ", 	["ǋ"] = "Ǌ", 	["ǌ"] = "Ǌ", 	["ǎ"] = "Ǎ", 	["ǐ"] = "Ǐ", 	["ǒ"] = "Ǒ", 	["ǔ"] = "Ǔ", 	["ǖ"] = "Ǖ", 	["ǘ"] = "Ǘ", 	["ǚ"] = "Ǚ", 	["ǜ"] = "Ǜ", 	["ǝ"] = "Ǝ", 	["ǟ"] = "Ǟ", 	["ǡ"] = "Ǡ", 	["ǣ"] = "Ǣ", 	["ǥ"] = "Ǥ", 	["ǧ"] = "Ǧ", 	["ǩ"] = "Ǩ", 	["ǫ"] = "Ǫ", 	["ǭ"] = "Ǭ", 	["ǯ"] = "Ǯ", 	["ǲ"] = "Ǳ", 	["ǳ"] = "Ǳ", 	["ǵ"] = "Ǵ", 	["ǹ"] = "Ǹ", 	["ǻ"] = "Ǻ", 	["ǽ"] = "Ǽ", 	["ǿ"] = "Ǿ", 	["ȁ"] = "Ȁ", 	["ȃ"] = "Ȃ", 	["ȅ"] = "Ȅ", 	["ȇ"] = "Ȇ", 	["ȉ"] = "Ȉ", 	["ȋ"] = "Ȋ", 	["ȍ"] = "Ȍ", 	["ȏ"] = "Ȏ", 	["ȑ"] = "Ȑ", 	["ȓ"] = "Ȓ", 	["ȕ"] = "Ȕ", 	["ȗ"] = "Ȗ", 	["ș"] = "Ș", 	["ț"] = "Ț", 	["ȝ"] = "Ȝ", 	["ȟ"] = "Ȟ", 	["ȣ"] = "Ȣ", 	["ȥ"] = "Ȥ", 	["ȧ"] = "Ȧ", 	["ȩ"] = "Ȩ", 	["ȫ"] = "Ȫ", 	["ȭ"] = "Ȭ", 	["ȯ"] = "Ȯ", 	["ȱ"] = "Ȱ", 	["ȳ"] = "Ȳ", 	["ȼ"] = "Ȼ", 	["ɂ"] = "Ɂ", 	["ɇ"] = "Ɇ", 	["ɉ"] = "Ɉ", 	["ɋ"] = "Ɋ", 	["ɍ"] = "Ɍ", 	["ɏ"] = "Ɏ", 	["ɓ"] = "Ɓ", 	["ɔ"] = "Ɔ", 	["ɖ"] = "Ɖ", 	["ɗ"] = "Ɗ", 	["ə"] = "Ə", 	["ɛ"] = "Ɛ", 	["ɠ"] = "Ɠ", 	["ɣ"] = "Ɣ", 	["ɨ"] = "Ɨ", 	["ɩ"] = "Ɩ", 	["ɫ"] = "Ɫ", 	["ɯ"] = "Ɯ", 	["ɲ"] = "Ɲ", 	["ɵ"] = "Ɵ", 	["ɽ"] = "Ɽ", 	["ʀ"] = "Ʀ", 	["ʃ"] = "Ʃ", 	["ʈ"] = "Ʈ", 	["ʉ"] = "Ʉ", 	["ʊ"] = "Ʊ", 	["ʋ"] = "Ʋ", 	["ʌ"] = "Ʌ", 	["ʒ"] = "Ʒ", 	["ͅ"] = "Ι", 	["ͻ"] = "Ͻ", 	["ͼ"] = "Ͼ", 	["ͽ"] = "Ͽ", 	["ά"] = "Ά", 	["έ"] = "Έ", 	["ή"] = "Ή", 	["ί"] = "Ί", 	["α"] = "Α", 	["β"] = "Β", 	["γ"] = "Γ", 	["δ"] = "Δ", 	["ε"] = "Ε", 	["ζ"] = "Ζ", 	["η"] = "Η", 	["θ"] = "Θ", 	["ι"] = "Ι", 	["κ"] = "Κ", 	["λ"] = "Λ", 	["μ"] = "Μ", 	["ν"] = "Ν", 	["ξ"] = "Ξ", 	["ο"] = "Ο", 	["π"] = "Π", 	["ρ"] = "Ρ", 	["ς"] = "Σ", 	["σ"] = "Σ", 	["τ"] = "Τ", 	["υ"] = "Υ", 	["φ"] = "Φ", 	["χ"] = "Χ", 	["ψ"] = "Ψ", 	["ω"] = "Ω", 	["ϊ"] = "Ϊ", 	["ϋ"] = "Ϋ", 	["ό"] = "Ό", 	["ύ"] = "Ύ", 	["ώ"] = "Ώ", 	["ϐ"] = "Β", 	["ϑ"] = "Θ", 	["ϕ"] = "Φ", 	["ϖ"] = "Π", 	["ϙ"] = "Ϙ", 	["ϛ"] = "Ϛ", 	["ϝ"] = "Ϝ", 	["ϟ"] = "Ϟ", 	["ϡ"] = "Ϡ", 	["ϣ"] = "Ϣ", 	["ϥ"] = "Ϥ", 	["ϧ"] = "Ϧ", 	["ϩ"] = "Ϩ", 	["ϫ"] = "Ϫ", 	["ϭ"] = "Ϭ", 	["ϯ"] = "Ϯ", 	["ϰ"] = "Κ", 	["ϱ"] = "Ρ", 	["ϲ"] = "Ϲ", 	["ϵ"] = "Ε", 	["ϸ"] = "Ϸ", 	["ϻ"] = "Ϻ", 	["а"] = "А", 	["б"] = "Б", 	["в"] = "В", 	["г"] = "Г", 	["д"] = "Д", 	["е"] = "Е", 	["ж"] = "Ж", 	["з"] = "З", 	["и"] = "И", 	["й"] = "Й", 	["к"] = "К", 	["л"] = "Л", 	["м"] = "М", 	["н"] = "Н", 	["о"] = "О", 	["п"] = "П", 	["р"] = "Р", 	["с"] = "С", 	["т"] = "Т", 	["у"] = "У", 	["ф"] = "Ф", 	["х"] = "Х", 	["ц"] = "Ц", 	["ч"] = "Ч", 	["ш"] = "Ш", 	["щ"] = "Щ", 	["ъ"] = "Ъ", 	["ы"] = "Ы", 	["ь"] = "Ь", 	["э"] = "Э", 	["ю"] = "Ю", 	["я"] = "Я", 	["ѐ"] = "Ѐ", 	["ё"] = "Ё", 	["ђ"] = "Ђ", 	["ѓ"] = "Ѓ", 	["є"] = "Є", 	["ѕ"] = "Ѕ", 	["і"] = "І", 	["ї"] = "Ї", 	["ј"] = "Ј", 	["љ"] = "Љ", 	["њ"] = "Њ", 	["ћ"] = "Ћ", 	["ќ"] = "Ќ", 	["ѝ"] = "Ѝ", 	["ў"] = "Ў", 	["џ"] = "Џ", 	["ѡ"] = "Ѡ", 	["ѣ"] = "Ѣ", 	["ѥ"] = "Ѥ", 	["ѧ"] = "Ѧ", 	["ѩ"] = "Ѩ", 	["ѫ"] = "Ѫ", 	["ѭ"] = "Ѭ", 	["ѯ"] = "Ѯ", 	["ѱ"] = "Ѱ", 	["ѳ"] = "Ѳ", 	["ѵ"] = "Ѵ", 	["ѷ"] = "Ѷ", 	["ѹ"] = "Ѹ", 	["ѻ"] = "Ѻ", 	["ѽ"] = "Ѽ", 	["ѿ"] = "Ѿ", 	["ҁ"] = "Ҁ", 	["ҋ"] = "Ҋ", 	["ҍ"] = "Ҍ", 	["ҏ"] = "Ҏ", 	["ґ"] = "Ґ", 	["ғ"] = "Ғ", 	["ҕ"] = "Ҕ", 	["җ"] = "Җ", 	["ҙ"] = "Ҙ", 	["қ"] = "Қ", 	["ҝ"] = "Ҝ", 	["ҟ"] = "Ҟ", 	["ҡ"] = "Ҡ", 	["ң"] = "Ң", 	["ҥ"] = "Ҥ", 	["ҧ"] = "Ҧ", 	["ҩ"] = "Ҩ", 	["ҫ"] = "Ҫ", 	["ҭ"] = "Ҭ", 	["ү"] = "Ү", 	["ұ"] = "Ұ", 	["ҳ"] = "Ҳ", 	["ҵ"] = "Ҵ", 	["ҷ"] = "Ҷ", 	["ҹ"] = "Ҹ", 	["һ"] = "Һ", 	["ҽ"] = "Ҽ", 	["ҿ"] = "Ҿ", 	["ӂ"] = "Ӂ", 	["ӄ"] = "Ӄ", 	["ӆ"] = "Ӆ", 	["ӈ"] = "Ӈ", 	["ӊ"] = "Ӊ", 	["ӌ"] = "Ӌ", 	["ӎ"] = "Ӎ", 	["ӏ"] = "Ӏ", 	["ӑ"] = "Ӑ", 	["ӓ"] = "Ӓ", 	["ӕ"] = "Ӕ", 	["ӗ"] = "Ӗ", 	["ә"] = "Ә", 	["ӛ"] = "Ӛ", 	["ӝ"] = "Ӝ", 	["ӟ"] = "Ӟ", 	["ӡ"] = "Ӡ", 	["ӣ"] = "Ӣ", 	["ӥ"] = "Ӥ", 	["ӧ"] = "Ӧ", 	["ө"] = "Ө", 	["ӫ"] = "Ӫ", 	["ӭ"] = "Ӭ", 	["ӯ"] = "Ӯ", 	["ӱ"] = "Ӱ", 	["ӳ"] = "Ӳ", 	["ӵ"] = "Ӵ", 	["ӷ"] = "Ӷ", 	["ӹ"] = "Ӹ", 	["ӻ"] = "Ӻ", 	["ӽ"] = "Ӽ", 	["ӿ"] = "Ӿ", 	["ԁ"] = "Ԁ", 	["ԃ"] = "Ԃ", 	["ԅ"] = "Ԅ", 	["ԇ"] = "Ԇ", 	["ԉ"] = "Ԉ", 	["ԋ"] = "Ԋ", 	["ԍ"] = "Ԍ", 	["ԏ"] = "Ԏ", 	["ԑ"] = "Ԑ", 	["ԓ"] = "Ԓ", 	["ա"] = "Ա", 	["բ"] = "Բ", 	["գ"] = "Գ", 	["դ"] = "Դ", 	["ե"] = "Ե", 	["զ"] = "Զ", 	["է"] = "Է", 	["ը"] = "Ը", 	["թ"] = "Թ", 	["ժ"] = "Ժ", 	["ի"] = "Ի", 	["լ"] = "Լ", 	["խ"] = "Խ", 	["ծ"] = "Ծ", 	["կ"] = "Կ", 	["հ"] = "Հ", 	["ձ"] = "Ձ", 	["ղ"] = "Ղ", 	["ճ"] = "Ճ", 	["մ"] = "Մ", 	["յ"] = "Յ", 	["ն"] = "Ն", 	["շ"] = "Շ", 	["ո"] = "Ո", 	["չ"] = "Չ", 	["պ"] = "Պ", 	["ջ"] = "Ջ", 	["ռ"] = "Ռ", 	["ս"] = "Ս", 	["վ"] = "Վ", 	["տ"] = "Տ", 	["ր"] = "Ր", 	["ց"] = "Ց", 	["ւ"] = "Ւ", 	["փ"] = "Փ", 	["ք"] = "Ք", 	["օ"] = "Օ", 	["ֆ"] = "Ֆ", 	["ᵽ"] = "Ᵽ", 	["ḁ"] = "Ḁ", 	["ḃ"] = "Ḃ", 	["ḅ"] = "Ḅ", 	["ḇ"] = "Ḇ", 	["ḉ"] = "Ḉ", 	["ḋ"] = "Ḋ", 	["ḍ"] = "Ḍ", 	["ḏ"] = "Ḏ", 	["ḑ"] = "Ḑ", 	["ḓ"] = "Ḓ", 	["ḕ"] = "Ḕ", 	["ḗ"] = "Ḗ", 	["ḙ"] = "Ḙ", 	["ḛ"] = "Ḛ", 	["ḝ"] = "Ḝ", 	["ḟ"] = "Ḟ", 	["ḡ"] = "Ḡ", 	["ḣ"] = "Ḣ", 	["ḥ"] = "Ḥ", 	["ḧ"] = "Ḧ", 	["ḩ"] = "Ḩ", 	["ḫ"] = "Ḫ", 	["ḭ"] = "Ḭ", 	["ḯ"] = "Ḯ", 	["ḱ"] = "Ḱ", 	["ḳ"] = "Ḳ", 	["ḵ"] = "Ḵ", 	["ḷ"] = "Ḷ", 	["ḹ"] = "Ḹ", 	["ḻ"] = "Ḻ", 	["ḽ"] = "Ḽ", 	["ḿ"] = "Ḿ", 	["ṁ"] = "Ṁ", 	["ṃ"] = "Ṃ", 	["ṅ"] = "Ṅ", 	["ṇ"] = "Ṇ", 	["ṉ"] = "Ṉ", 	["ṋ"] = "Ṋ", 	["ṍ"] = "Ṍ", 	["ṏ"] = "Ṏ", 	["ṑ"] = "Ṑ", 	["ṓ"] = "Ṓ", 	["ṕ"] = "Ṕ", 	["ṗ"] = "Ṗ", 	["ṙ"] = "Ṙ", 	["ṛ"] = "Ṛ", 	["ṝ"] = "Ṝ", 	["ṟ"] = "Ṟ", 	["ṡ"] = "Ṡ", 	["ṣ"] = "Ṣ", 	["ṥ"] = "Ṥ", 	["ṧ"] = "Ṧ", 	["ṩ"] = "Ṩ", 	["ṫ"] = "Ṫ", 	["ṭ"] = "Ṭ", 	["ṯ"] = "Ṯ", 	["ṱ"] = "Ṱ", 	["ṳ"] = "Ṳ", 	["ṵ"] = "Ṵ", 	["ṷ"] = "Ṷ", 	["ṹ"] = "Ṹ", 	["ṻ"] = "Ṻ", 	["ṽ"] = "Ṽ", 	["ṿ"] = "Ṿ", 	["ẁ"] = "Ẁ", 	["ẃ"] = "Ẃ", 	["ẅ"] = "Ẅ", 	["ẇ"] = "Ẇ", 	["ẉ"] = "Ẉ", 	["ẋ"] = "Ẋ", 	["ẍ"] = "Ẍ", 	["ẏ"] = "Ẏ", 	["ẑ"] = "Ẑ", 	["ẓ"] = "Ẓ", 	["ẕ"] = "Ẕ", 	["ẛ"] = "Ṡ", 	["ạ"] = "Ạ", 	["ả"] = "Ả", 	["ấ"] = "Ấ", 	["ầ"] = "Ầ", 	["ẩ"] = "Ẩ", 	["ẫ"] = "Ẫ", 	["ậ"] = "Ậ", 	["ắ"] = "Ắ", 	["ằ"] = "Ằ", 	["ẳ"] = "Ẳ", 	["ẵ"] = "Ẵ", 	["ặ"] = "Ặ", 	["ẹ"] = "Ẹ", 	["ẻ"] = "Ẻ", 	["ẽ"] = "Ẽ", 	["ế"] = "Ế", 	["ề"] = "Ề", 	["ể"] = "Ể", 	["ễ"] = "Ễ", 	["ệ"] = "Ệ", 	["ỉ"] = "Ỉ", 	["ị"] = "Ị", 	["ọ"] = "Ọ", 	["ỏ"] = "Ỏ", 	["ố"] = "Ố", 	["ồ"] = "Ồ", 	["ổ"] = "Ổ", 	["ỗ"] = "Ỗ", 	["ộ"] = "Ộ", 	["ớ"] = "Ớ", 	["ờ"] = "Ờ", 	["ở"] = "Ở", 	["ỡ"] = "Ỡ", 	["ợ"] = "Ợ", 	["ụ"] = "Ụ", 	["ủ"] = "Ủ", 	["ứ"] = "Ứ", 	["ừ"] = "Ừ", 	["ử"] = "Ử", 	["ữ"] = "Ữ", 	["ự"] = "Ự", 	["ỳ"] = "Ỳ", 	["ỵ"] = "Ỵ", 	["ỷ"] = "Ỷ", 	["ỹ"] = "Ỹ", 	["ἀ"] = "Ἀ", 	["ἁ"] = "Ἁ", 	["ἂ"] = "Ἂ", 	["ἃ"] = "Ἃ", 	["ἄ"] = "Ἄ", 	["ἅ"] = "Ἅ", 	["ἆ"] = "Ἆ", 	["ἇ"] = "Ἇ", 	["ἐ"] = "Ἐ", 	["ἑ"] = "Ἑ", 	["ἒ"] = "Ἒ", 	["ἓ"] = "Ἓ", 	["ἔ"] = "Ἔ", 	["ἕ"] = "Ἕ", 	["ἠ"] = "Ἠ", 	["ἡ"] = "Ἡ", 	["ἢ"] = "Ἢ", 	["ἣ"] = "Ἣ", 	["ἤ"] = "Ἤ", 	["ἥ"] = "Ἥ", 	["ἦ"] = "Ἦ", 	["ἧ"] = "Ἧ", 	["ἰ"] = "Ἰ", 	["ἱ"] = "Ἱ", 	["ἲ"] = "Ἲ", 	["ἳ"] = "Ἳ", 	["ἴ"] = "Ἴ", 	["ἵ"] = "Ἵ", 	["ἶ"] = "Ἶ", 	["ἷ"] = "Ἷ", 	["ὀ"] = "Ὀ", 	["ὁ"] = "Ὁ", 	["ὂ"] = "Ὂ", 	["ὃ"] = "Ὃ", 	["ὄ"] = "Ὄ", 	["ὅ"] = "Ὅ", 	["ὑ"] = "Ὑ", 	["ὓ"] = "Ὓ", 	["ὕ"] = "Ὕ", 	["ὗ"] = "Ὗ", 	["ὠ"] = "Ὠ", 	["ὡ"] = "Ὡ", 	["ὢ"] = "Ὢ", 	["ὣ"] = "Ὣ", 	["ὤ"] = "Ὤ", 	["ὥ"] = "Ὥ", 	["ὦ"] = "Ὦ", 	["ὧ"] = "Ὧ", 	["ὰ"] = "Ὰ", 	["ά"] = "Ά", 	["ὲ"] = "Ὲ", 	["έ"] = "Έ", 	["ὴ"] = "Ὴ", 	["ή"] = "Ή", 	["ὶ"] = "Ὶ", 	["ί"] = "Ί", 	["ὸ"] = "Ὸ", 	["ό"] = "Ό", 	["ὺ"] = "Ὺ", 	["ύ"] = "Ύ", 	["ὼ"] = "Ὼ", 	["ώ"] = "Ώ", 	["ᾀ"] = "ᾈ", 	["ᾁ"] = "ᾉ", 	["ᾂ"] = "ᾊ", 	["ᾃ"] = "ᾋ", 	["ᾄ"] = "ᾌ", 	["ᾅ"] = "ᾍ", 	["ᾆ"] = "ᾎ", 	["ᾇ"] = "ᾏ", 	["ᾐ"] = "ᾘ", 	["ᾑ"] = "ᾙ", 	["ᾒ"] = "ᾚ", 	["ᾓ"] = "ᾛ", 	["ᾔ"] = "ᾜ", 	["ᾕ"] = "ᾝ", 	["ᾖ"] = "ᾞ", 	["ᾗ"] = "ᾟ", 	["ᾠ"] = "ᾨ", 	["ᾡ"] = "ᾩ", 	["ᾢ"] = "ᾪ", 	["ᾣ"] = "ᾫ", 	["ᾤ"] = "ᾬ", 	["ᾥ"] = "ᾭ", 	["ᾦ"] = "ᾮ", 	["ᾧ"] = "ᾯ", 	["ᾰ"] = "Ᾰ", 	["ᾱ"] = "Ᾱ", 	["ᾳ"] = "ᾼ", 	["ι"] = "Ι", 	["ῃ"] = "ῌ", 	["ῐ"] = "Ῐ", 	["ῑ"] = "Ῑ", 	["ῠ"] = "Ῠ", 	["ῡ"] = "Ῡ", 	["ῥ"] = "Ῥ", 	["ῳ"] = "ῼ", 	["ⅎ"] = "Ⅎ", 	["ⅰ"] = "Ⅰ", 	["ⅱ"] = "Ⅱ", 	["ⅲ"] = "Ⅲ", 	["ⅳ"] = "Ⅳ", 	["ⅴ"] = "Ⅴ", 	["ⅵ"] = "Ⅵ", 	["ⅶ"] = "Ⅶ", 	["ⅷ"] = "Ⅷ", 	["ⅸ"] = "Ⅸ", 	["ⅹ"] = "Ⅹ", 	["ⅺ"] = "Ⅺ", 	["ⅻ"] = "Ⅻ", 	["ⅼ"] = "Ⅼ", 	["ⅽ"] = "Ⅽ", 	["ⅾ"] = "Ⅾ", 	["ⅿ"] = "Ⅿ", 	["ↄ"] = "Ↄ", 	["ⓐ"] = "Ⓐ", 	["ⓑ"] = "Ⓑ", 	["ⓒ"] = "Ⓒ", 	["ⓓ"] = "Ⓓ", 	["ⓔ"] = "Ⓔ", 	["ⓕ"] = "Ⓕ", 	["ⓖ"] = "Ⓖ", 	["ⓗ"] = "Ⓗ", 	["ⓘ"] = "Ⓘ", 	["ⓙ"] = "Ⓙ", 	["ⓚ"] = "Ⓚ", 	["ⓛ"] = "Ⓛ", 	["ⓜ"] = "Ⓜ", 	["ⓝ"] = "Ⓝ", 	["ⓞ"] = "Ⓞ", 	["ⓟ"] = "Ⓟ", 	["ⓠ"] = "Ⓠ", 	["ⓡ"] = "Ⓡ", 	["ⓢ"] = "Ⓢ", 	["ⓣ"] = "Ⓣ", 	["ⓤ"] = "Ⓤ", 	["ⓥ"] = "Ⓥ", 	["ⓦ"] = "Ⓦ", 	["ⓧ"] = "Ⓧ", 	["ⓨ"] = "Ⓨ", 	["ⓩ"] = "Ⓩ", 	["ⰰ"] = "Ⰰ", 	["ⰱ"] = "Ⰱ", 	["ⰲ"] = "Ⰲ", 	["ⰳ"] = "Ⰳ", 	["ⰴ"] = "Ⰴ", 	["ⰵ"] = "Ⰵ", 	["ⰶ"] = "Ⰶ", 	["ⰷ"] = "Ⰷ", 	["ⰸ"] = "Ⰸ", 	["ⰹ"] = "Ⰹ", 	["ⰺ"] = "Ⰺ", 	["ⰻ"] = "Ⰻ", 	["ⰼ"] = "Ⰼ", 	["ⰽ"] = "Ⰽ", 	["ⰾ"] = "Ⰾ", 	["ⰿ"] = "Ⰿ", 	["ⱀ"] = "Ⱀ", 	["ⱁ"] = "Ⱁ", 	["ⱂ"] = "Ⱂ", 	["ⱃ"] = "Ⱃ", 	["ⱄ"] = "Ⱄ", 	["ⱅ"] = "Ⱅ", 	["ⱆ"] = "Ⱆ", 	["ⱇ"] = "Ⱇ", 	["ⱈ"] = "Ⱈ", 	["ⱉ"] = "Ⱉ", 	["ⱊ"] = "Ⱊ", 	["ⱋ"] = "Ⱋ", 	["ⱌ"] = "Ⱌ", 	["ⱍ"] = "Ⱍ", 	["ⱎ"] = "Ⱎ", 	["ⱏ"] = "Ⱏ", 	["ⱐ"] = "Ⱐ", 	["ⱑ"] = "Ⱑ", 	["ⱒ"] = "Ⱒ", 	["ⱓ"] = "Ⱓ", 	["ⱔ"] = "Ⱔ", 	["ⱕ"] = "Ⱕ", 	["ⱖ"] = "Ⱖ", 	["ⱗ"] = "Ⱗ", 	["ⱘ"] = "Ⱘ", 	["ⱙ"] = "Ⱙ", 	["ⱚ"] = "Ⱚ", 	["ⱛ"] = "Ⱛ", 	["ⱜ"] = "Ⱜ", 	["ⱝ"] = "Ⱝ", 	["ⱞ"] = "Ⱞ", 	["ⱡ"] = "Ⱡ", 	["ⱥ"] = "Ⱥ", 	["ⱦ"] = "Ⱦ", 	["ⱨ"] = "Ⱨ", 	["ⱪ"] = "Ⱪ", 	["ⱬ"] = "Ⱬ", 	["ⱶ"] = "Ⱶ", 	["ⲁ"] = "Ⲁ", 	["ⲃ"] = "Ⲃ", 	["ⲅ"] = "Ⲅ", 	["ⲇ"] = "Ⲇ", 	["ⲉ"] = "Ⲉ", 	["ⲋ"] = "Ⲋ", 	["ⲍ"] = "Ⲍ", 	["ⲏ"] = "Ⲏ", 	["ⲑ"] = "Ⲑ", 	["ⲓ"] = "Ⲓ", 	["ⲕ"] = "Ⲕ", 	["ⲗ"] = "Ⲗ", 	["ⲙ"] = "Ⲙ", 	["ⲛ"] = "Ⲛ", 	["ⲝ"] = "Ⲝ", 	["ⲟ"] = "Ⲟ", 	["ⲡ"] = "Ⲡ", 	["ⲣ"] = "Ⲣ", 	["ⲥ"] = "Ⲥ", 	["ⲧ"] = "Ⲧ", 	["ⲩ"] = "Ⲩ", 	["ⲫ"] = "Ⲫ", 	["ⲭ"] = "Ⲭ", 	["ⲯ"] = "Ⲯ", 	["ⲱ"] = "Ⲱ", 	["ⲳ"] = "Ⲳ", 	["ⲵ"] = "Ⲵ", 	["ⲷ"] = "Ⲷ", 	["ⲹ"] = "Ⲹ", 	["ⲻ"] = "Ⲻ", 	["ⲽ"] = "Ⲽ", 	["ⲿ"] = "Ⲿ", 	["ⳁ"] = "Ⳁ", 	["ⳃ"] = "Ⳃ", 	["ⳅ"] = "Ⳅ", 	["ⳇ"] = "Ⳇ", 	["ⳉ"] = "Ⳉ", 	["ⳋ"] = "Ⳋ", 	["ⳍ"] = "Ⳍ", 	["ⳏ"] = "Ⳏ", 	["ⳑ"] = "Ⳑ", 	["ⳓ"] = "Ⳓ", 	["ⳕ"] = "Ⳕ", 	["ⳗ"] = "Ⳗ", 	["ⳙ"] = "Ⳙ", 	["ⳛ"] = "Ⳛ", 	["ⳝ"] = "Ⳝ", 	["ⳟ"] = "Ⳟ", 	["ⳡ"] = "Ⳡ", 	["ⳣ"] = "Ⳣ", 	["ⴀ"] = "Ⴀ", 	["ⴁ"] = "Ⴁ", 	["ⴂ"] = "Ⴂ", 	["ⴃ"] = "Ⴃ", 	["ⴄ"] = "Ⴄ", 	["ⴅ"] = "Ⴅ", 	["ⴆ"] = "Ⴆ", 	["ⴇ"] = "Ⴇ", 	["ⴈ"] = "Ⴈ", 	["ⴉ"] = "Ⴉ", 	["ⴊ"] = "Ⴊ", 	["ⴋ"] = "Ⴋ", 	["ⴌ"] = "Ⴌ", 	["ⴍ"] = "Ⴍ", 	["ⴎ"] = "Ⴎ", 	["ⴏ"] = "Ⴏ", 	["ⴐ"] = "Ⴐ", 	["ⴑ"] = "Ⴑ", 	["ⴒ"] = "Ⴒ", 	["ⴓ"] = "Ⴓ", 	["ⴔ"] = "Ⴔ", 	["ⴕ"] = "Ⴕ", 	["ⴖ"] = "Ⴖ", 	["ⴗ"] = "Ⴗ", 	["ⴘ"] = "Ⴘ", 	["ⴙ"] = "Ⴙ", 	["ⴚ"] = "Ⴚ", 	["ⴛ"] = "Ⴛ", 	["ⴜ"] = "Ⴜ", 	["ⴝ"] = "Ⴝ", 	["ⴞ"] = "Ⴞ", 	["ⴟ"] = "Ⴟ", 	["ⴠ"] = "Ⴠ", 	["ⴡ"] = "Ⴡ", 	["ⴢ"] = "Ⴢ", 	["ⴣ"] = "Ⴣ", 	["ⴤ"] = "Ⴤ", 	["ⴥ"] = "Ⴥ", 	["ａ"] = "Ａ", 	["ｂ"] = "Ｂ", 	["ｃ"] = "Ｃ", 	["ｄ"] = "Ｄ", 	["ｅ"] = "Ｅ", 	["ｆ"] = "Ｆ", 	["ｇ"] = "Ｇ", 	["ｈ"] = "Ｈ", 	["ｉ"] = "Ｉ", 	["ｊ"] = "Ｊ", 	["ｋ"] = "Ｋ", 	["ｌ"] = "Ｌ", 	["ｍ"] = "Ｍ", 	["ｎ"] = "Ｎ", 	["ｏ"] = "Ｏ", 	["ｐ"] = "Ｐ", 	["ｑ"] = "Ｑ", 	["ｒ"] = "Ｒ", 	["ｓ"] = "Ｓ", 	["ｔ"] = "Ｔ", 	["ｕ"] = "Ｕ", 	["ｖ"] = "Ｖ", 	["ｗ"] = "Ｗ", 	["ｘ"] = "Ｘ", 	["ｙ"] = "Ｙ", 	["ｚ"] = "Ｚ", 	["𐐨"] = "𐐀", 	["𐐩"] = "𐐁", 	["𐐪"] = "𐐂", 	["𐐫"] = "𐐃", 	["𐐬"] = "𐐄", 	["𐐭"] = "𐐅", 	["𐐮"] = "𐐆", 	["𐐯"] = "𐐇", 	["𐐰"] = "𐐈", 	["𐐱"] = "𐐉", 	["𐐲"] = "𐐊", 	["𐐳"] = "𐐋", 	["𐐴"] = "𐐌", 	["𐐵"] = "𐐍", 	["𐐶"] = "𐐎", 	["𐐷"] = "𐐏", 	["𐐸"] = "𐐐", 	["𐐹"] = "𐐑", 	["𐐺"] = "𐐒", 	["𐐻"] = "𐐓", 	["𐐼"] = "𐐔", 	["𐐽"] = "𐐕", 	["𐐾"] = "𐐖", 	["𐐿"] = "𐐗", 	["𐑀"] = "𐐘", 	["𐑁"] = "𐐙", 	["𐑂"] = "𐐚", 	["𐑃"] = "𐐛", 	["𐑄"] = "𐐜", 	["𐑅"] = "𐐝", 	["𐑆"] = "𐐞", 	["𐑇"] = "𐐟", 	["𐑈"] = "𐐠", 	["𐑉"] = "𐐡", 	["𐑊"] = "𐐢", 	["𐑋"] = "𐐣", 	["𐑌"] = "𐐤", 	["𐑍"] = "𐐥", 	["𐑎"] = "𐐦", 	["𐑏"] = "𐐧", } utf8_uc_lc = {["A"] = "a", 	["B"] = "b", 	["C"] = "c", 	["D"] = "d", 	["E"] = "e", 	["F"] = "f", 	["G"] = "g", 	["H"] = "h", 	["I"] = "i", 	["J"] = "j", 	["K"] = "k", 	["L"] = "l", 	["M"] = "m", 	["N"] = "n", 	["O"] = "o", 	["P"] = "p", 	["Q"] = "q", 	["R"] = "r", 	["S"] = "s", 	["T"] = "t", 	["U"] = "u", 	["V"] = "v", 	["W"] = "w", 	["X"] = "x", 	["Y"] = "y", 	["Z"] = "z", 	["À"] = "à", 	["Á"] = "á", 	["Â"] = "â", 	["Ã"] = "ã", 	["Ä"] = "ä", 	["Å"] = "å", 	["Æ"] = "æ", 	["Ç"] = "ç", 	["È"] = "è", 	["É"] = "é", 	["Ê"] = "ê", 	["Ë"] = "ë", 	["Ì"] = "ì", 	["Í"] = "í", 	["Î"] = "î", 	["Ï"] = "ï", 	["Ð"] = "ð", 	["Ñ"] = "ñ", 	["Ò"] = "ò", 	["Ó"] = "ó", 	["Ô"] = "ô", 	["Õ"] = "õ", 	["Ö"] = "ö", 	["Ø"] = "ø", 	["Ù"] = "ù", 	["Ú"] = "ú", 	["Û"] = "û", 	["Ü"] = "ü", 	["Ý"] = "ý", 	["Þ"] = "þ", 	["Ā"] = "ā", 	["Ă"] = "ă", 	["Ą"] = "ą", 	["Ć"] = "ć", 	["Ĉ"] = "ĉ", 	["Ċ"] = "ċ", 	["Č"] = "č", 	["Ď"] = "ď", 	["Đ"] = "đ", 	["Ē"] = "ē", 	["Ĕ"] = "ĕ", 	["Ė"] = "ė", 	["Ę"] = "ę", 	["Ě"] = "ě", 	["Ĝ"] = "ĝ", 	["Ğ"] = "ğ", 	["Ġ"] = "ġ", 	["Ģ"] = "ģ", 	["Ĥ"] = "ĥ", 	["Ħ"] = "ħ", 	["Ĩ"] = "ĩ", 	["Ī"] = "ī", 	["Ĭ"] = "ĭ", 	["Į"] = "į", 	["İ"] = "i", 	["Ĳ"] = "ĳ", 	["Ĵ"] = "ĵ", 	["Ķ"] = "ķ", 	["Ĺ"] = "ĺ", 	["Ļ"] = "ļ", 	["Ľ"] = "ľ", 	["Ŀ"] = "ŀ", 	["Ł"] = "ł", 	["Ń"] = "ń", 	["Ņ"] = "ņ", 	["Ň"] = "ň", 	["Ŋ"] = "ŋ", 	["Ō"] = "ō", 	["Ŏ"] = "ŏ", 	["Ő"] = "ő", 	["Œ"] = "œ", 	["Ŕ"] = "ŕ", 	["Ŗ"] = "ŗ", 	["Ř"] = "ř", 	["Ś"] = "ś", 	["Ŝ"] = "ŝ", 	["Ş"] = "ş", 	["Š"] = "š", 	["Ţ"] = "ţ", 	["Ť"] = "ť", 	["Ŧ"] = "ŧ", 	["Ũ"] = "ũ", 	["Ū"] = "ū", 	["Ŭ"] = "ŭ", 	["Ů"] = "ů", 	["Ű"] = "ű", 	["Ų"] = "ų", 	["Ŵ"] = "ŵ", 	["Ŷ"] = "ŷ", 	["Ÿ"] = "ÿ", 	["Ź"] = "ź", 	["Ż"] = "ż", 	["Ž"] = "ž", 	["Ɓ"] = "ɓ", 	["Ƃ"] = "ƃ", 	["Ƅ"] = "ƅ", 	["Ɔ"] = "ɔ", 	["Ƈ"] = "ƈ", 	["Ɖ"] = "ɖ", 	["Ɗ"] = "ɗ", 	["Ƌ"] = "ƌ", 	["Ǝ"] = "ǝ", 	["Ə"] = "ə", 	["Ɛ"] = "ɛ", 	["Ƒ"] = "ƒ", 	["Ɠ"] = "ɠ", 	["Ɣ"] = "ɣ", 	["Ɩ"] = "ɩ", 	["Ɨ"] = "ɨ", 	["Ƙ"] = "ƙ", 	["Ɯ"] = "ɯ", 	["Ɲ"] = "ɲ", 	["Ɵ"] = "ɵ", 	["Ơ"] = "ơ", 	["Ƣ"] = "ƣ", 	["Ƥ"] = "ƥ", 	["Ʀ"] = "ʀ", 	["Ƨ"] = "ƨ", 	["Ʃ"] = "ʃ", 	["Ƭ"] = "ƭ", 	["Ʈ"] = "ʈ", 	["Ư"] = "ư", 	["Ʊ"] = "ʊ", 	["Ʋ"] = "ʋ", 	["Ƴ"] = "ƴ", 	["Ƶ"] = "ƶ", 	["Ʒ"] = "ʒ", 	["Ƹ"] = "ƹ", 	["Ƽ"] = "ƽ", 	["Ǆ"] = "ǆ", 	["ǅ"] = "ǆ", 	["Ǉ"] = "ǉ", 	["ǈ"] = "ǉ", 	["Ǌ"] = "ǌ", 	["ǋ"] = "ǌ", 	["Ǎ"] = "ǎ", 	["Ǐ"] = "ǐ", 	["Ǒ"] = "ǒ", 	["Ǔ"] = "ǔ", 	["Ǖ"] = "ǖ", 	["Ǘ"] = "ǘ", 	["Ǚ"] = "ǚ", 	["Ǜ"] = "ǜ", 	["Ǟ"] = "ǟ", 	["Ǡ"] = "ǡ", 	["Ǣ"] = "ǣ", 	["Ǥ"] = "ǥ", 	["Ǧ"] = "ǧ", 	["Ǩ"] = "ǩ", 	["Ǫ"] = "ǫ", 	["Ǭ"] = "ǭ", 	["Ǯ"] = "ǯ", 	["Ǳ"] = "ǳ", 	["ǲ"] = "ǳ", 	["Ǵ"] = "ǵ", 	["Ƕ"] = "ƕ", 	["Ƿ"] = "ƿ", 	["Ǹ"] = "ǹ", 	["Ǻ"] = "ǻ", 	["Ǽ"] = "ǽ", 	["Ǿ"] = "ǿ", 	["Ȁ"] = "ȁ", 	["Ȃ"] = "ȃ", 	["Ȅ"] = "ȅ", 	["Ȇ"] = "ȇ", 	["Ȉ"] = "ȉ", 	["Ȋ"] = "ȋ", 	["Ȍ"] = "ȍ", 	["Ȏ"] = "ȏ", 	["Ȑ"] = "ȑ", 	["Ȓ"] = "ȓ", 	["Ȕ"] = "ȕ", 	["Ȗ"] = "ȗ", 	["Ș"] = "ș", 	["Ț"] = "ț", 	["Ȝ"] = "ȝ", 	["Ȟ"] = "ȟ", 	["Ƞ"] = "ƞ", 	["Ȣ"] = "ȣ", 	["Ȥ"] = "ȥ", 	["Ȧ"] = "ȧ", 	["Ȩ"] = "ȩ", 	["Ȫ"] = "ȫ", 	["Ȭ"] = "ȭ", 	["Ȯ"] = "ȯ", 	["Ȱ"] = "ȱ", 	["Ȳ"] = "ȳ", 	["Ⱥ"] = "ⱥ", 	["Ȼ"] = "ȼ", 	["Ƚ"] = "ƚ", 	["Ⱦ"] = "ⱦ", 	["Ɂ"] = "ɂ", 	["Ƀ"] = "ƀ", 	["Ʉ"] = "ʉ", 	["Ʌ"] = "ʌ", 	["Ɇ"] = "ɇ", 	["Ɉ"] = "ɉ", 	["Ɋ"] = "ɋ", 	["Ɍ"] = "ɍ", 	["Ɏ"] = "ɏ", 	["Ά"] = "ά", 	["Έ"] = "έ", 	["Ή"] = "ή", 	["Ί"] = "ί", 	["Ό"] = "ό", 	["Ύ"] = "ύ", 	["Ώ"] = "ώ", 	["Α"] = "α", 	["Β"] = "β", 	["Γ"] = "γ", 	["Δ"] = "δ", 	["Ε"] = "ε", 	["Ζ"] = "ζ", 	["Η"] = "η", 	["Θ"] = "θ", 	["Ι"] = "ι", 	["Κ"] = "κ", 	["Λ"] = "λ", 	["Μ"] = "μ", 	["Ν"] = "ν", 	["Ξ"] = "ξ", 	["Ο"] = "ο", 	["Π"] = "π", 	["Ρ"] = "ρ", 	["Σ"] = "σ", 	["Τ"] = "τ", 	["Υ"] = "υ", 	["Φ"] = "φ", 	["Χ"] = "χ", 	["Ψ"] = "ψ", 	["Ω"] = "ω", 	["Ϊ"] = "ϊ", 	["Ϋ"] = "ϋ", 	["Ϙ"] = "ϙ", 	["Ϛ"] = "ϛ", 	["Ϝ"] = "ϝ", 	["Ϟ"] = "ϟ", 	["Ϡ"] = "ϡ", 	["Ϣ"] = "ϣ", 	["Ϥ"] = "ϥ", 	["Ϧ"] = "ϧ", 	["Ϩ"] = "ϩ", 	["Ϫ"] = "ϫ", 	["Ϭ"] = "ϭ", 	["Ϯ"] = "ϯ", 	["ϴ"] = "θ", 	["Ϸ"] = "ϸ", 	["Ϲ"] = "ϲ", 	["Ϻ"] = "ϻ", 	["Ͻ"] = "ͻ", 	["Ͼ"] = "ͼ", 	["Ͽ"] = "ͽ", 	["Ѐ"] = "ѐ", 	["Ё"] = "ё", 	["Ђ"] = "ђ", 	["Ѓ"] = "ѓ", 	["Є"] = "є", 	["Ѕ"] = "ѕ", 	["І"] = "і", 	["Ї"] = "ї", 	["Ј"] = "ј", 	["Љ"] = "љ", 	["Њ"] = "њ", 	["Ћ"] = "ћ", 	["Ќ"] = "ќ", 	["Ѝ"] = "ѝ", 	["Ў"] = "ў", 	["Џ"] = "џ", 	["А"] = "а", 	["Б"] = "б", 	["В"] = "в", 	["Г"] = "г", 	["Д"] = "д", 	["Е"] = "е", 	["Ж"] = "ж", 	["З"] = "з", 	["И"] = "и", 	["Й"] = "й", 	["К"] = "к", 	["Л"] = "л", 	["М"] = "м", 	["Н"] = "н", 	["О"] = "о", 	["П"] = "п", 	["Р"] = "р", 	["С"] = "с", 	["Т"] = "т", 	["У"] = "у", 	["Ф"] = "ф", 	["Х"] = "х", 	["Ц"] = "ц", 	["Ч"] = "ч", 	["Ш"] = "ш", 	["Щ"] = "щ", 	["Ъ"] = "ъ", 	["Ы"] = "ы", 	["Ь"] = "ь", 	["Э"] = "э", 	["Ю"] = "ю", 	["Я"] = "я", 	["Ѡ"] = "ѡ", 	["Ѣ"] = "ѣ", 	["Ѥ"] = "ѥ", 	["Ѧ"] = "ѧ", 	["Ѩ"] = "ѩ", 	["Ѫ"] = "ѫ", 	["Ѭ"] = "ѭ", 	["Ѯ"] = "ѯ", 	["Ѱ"] = "ѱ", 	["Ѳ"] = "ѳ", 	["Ѵ"] = "ѵ", 	["Ѷ"] = "ѷ", 	["Ѹ"] = "ѹ", 	["Ѻ"] = "ѻ", 	["Ѽ"] = "ѽ", 	["Ѿ"] = "ѿ", 	["Ҁ"] = "ҁ", 	["Ҋ"] = "ҋ", 	["Ҍ"] = "ҍ", 	["Ҏ"] = "ҏ", 	["Ґ"] = "ґ", 	["Ғ"] = "ғ", 	["Ҕ"] = "ҕ", 	["Җ"] = "җ", 	["Ҙ"] = "ҙ", 	["Қ"] = "қ", 	["Ҝ"] = "ҝ", 	["Ҟ"] = "ҟ", 	["Ҡ"] = "ҡ", 	["Ң"] = "ң", 	["Ҥ"] = "ҥ", 	["Ҧ"] = "ҧ", 	["Ҩ"] = "ҩ", 	["Ҫ"] = "ҫ", 	["Ҭ"] = "ҭ", 	["Ү"] = "ү", 	["Ұ"] = "ұ", 	["Ҳ"] = "ҳ", 	["Ҵ"] = "ҵ", 	["Ҷ"] = "ҷ", 	["Ҹ"] = "ҹ", 	["Һ"] = "һ", 	["Ҽ"] = "ҽ", 	["Ҿ"] = "ҿ", 	["Ӏ"] = "ӏ", 	["Ӂ"] = "ӂ", 	["Ӄ"] = "ӄ", 	["Ӆ"] = "ӆ", 	["Ӈ"] = "ӈ", 	["Ӊ"] = "ӊ", 	["Ӌ"] = "ӌ", 	["Ӎ"] = "ӎ", 	["Ӑ"] = "ӑ", 	["Ӓ"] = "ӓ", 	["Ӕ"] = "ӕ", 	["Ӗ"] = "ӗ", 	["Ә"] = "ә", 	["Ӛ"] = "ӛ", 	["Ӝ"] = "ӝ", 	["Ӟ"] = "ӟ", 	["Ӡ"] = "ӡ", 	["Ӣ"] = "ӣ", 	["Ӥ"] = "ӥ", 	["Ӧ"] = "ӧ", 	["Ө"] = "ө", 	["Ӫ"] = "ӫ", 	["Ӭ"] = "ӭ", 	["Ӯ"] = "ӯ", 	["Ӱ"] = "ӱ", 	["Ӳ"] = "ӳ", 	["Ӵ"] = "ӵ", 	["Ӷ"] = "ӷ", 	["Ӹ"] = "ӹ", 	["Ӻ"] = "ӻ", 	["Ӽ"] = "ӽ", 	["Ӿ"] = "ӿ", 	["Ԁ"] = "ԁ", 	["Ԃ"] = "ԃ", 	["Ԅ"] = "ԅ", 	["Ԇ"] = "ԇ", 	["Ԉ"] = "ԉ", 	["Ԋ"] = "ԋ", 	["Ԍ"] = "ԍ", 	["Ԏ"] = "ԏ", 	["Ԑ"] = "ԑ", 	["Ԓ"] = "ԓ", 	["Ա"] = "ա", 	["Բ"] = "բ", 	["Գ"] = "գ", 	["Դ"] = "դ", 	["Ե"] = "ե", 	["Զ"] = "զ", 	["Է"] = "է", 	["Ը"] = "ը", 	["Թ"] = "թ", 	["Ժ"] = "ժ", 	["Ի"] = "ի", 	["Լ"] = "լ", 	["Խ"] = "խ", 	["Ծ"] = "ծ", 	["Կ"] = "կ", 	["Հ"] = "հ", 	["Ձ"] = "ձ", 	["Ղ"] = "ղ", 	["Ճ"] = "ճ", 	["Մ"] = "մ", 	["Յ"] = "յ", 	["Ն"] = "ն", 	["Շ"] = "շ", 	["Ո"] = "ո", 	["Չ"] = "չ", 	["Պ"] = "պ", 	["Ջ"] = "ջ", 	["Ռ"] = "ռ", 	["Ս"] = "ս", 	["Վ"] = "վ", 	["Տ"] = "տ", 	["Ր"] = "ր", 	["Ց"] = "ց", 	["Ւ"] = "ւ", 	["Փ"] = "փ", 	["Ք"] = "ք", 	["Օ"] = "օ", 	["Ֆ"] = "ֆ", 	["Ⴀ"] = "ⴀ", 	["Ⴁ"] = "ⴁ", 	["Ⴂ"] = "ⴂ", 	["Ⴃ"] = "ⴃ", 	["Ⴄ"] = "ⴄ", 	["Ⴅ"] = "ⴅ", 	["Ⴆ"] = "ⴆ", 	["Ⴇ"] = "ⴇ", 	["Ⴈ"] = "ⴈ", 	["Ⴉ"] = "ⴉ", 	["Ⴊ"] = "ⴊ", 	["Ⴋ"] = "ⴋ", 	["Ⴌ"] = "ⴌ", 	["Ⴍ"] = "ⴍ", 	["Ⴎ"] = "ⴎ", 	["Ⴏ"] = "ⴏ", 	["Ⴐ"] = "ⴐ", 	["Ⴑ"] = "ⴑ", 	["Ⴒ"] = "ⴒ", 	["Ⴓ"] = "ⴓ", 	["Ⴔ"] = "ⴔ", 	["Ⴕ"] = "ⴕ", 	["Ⴖ"] = "ⴖ", 	["Ⴗ"] = "ⴗ", 	["Ⴘ"] = "ⴘ", 	["Ⴙ"] = "ⴙ", 	["Ⴚ"] = "ⴚ", 	["Ⴛ"] = "ⴛ", 	["Ⴜ"] = "ⴜ", 	["Ⴝ"] = "ⴝ", 	["Ⴞ"] = "ⴞ", 	["Ⴟ"] = "ⴟ", 	["Ⴠ"] = "ⴠ", 	["Ⴡ"] = "ⴡ", 	["Ⴢ"] = "ⴢ", 	["Ⴣ"] = "ⴣ", 	["Ⴤ"] = "ⴤ", 	["Ⴥ"] = "ⴥ", 	["Ḁ"] = "ḁ", 	["Ḃ"] = "ḃ", 	["Ḅ"] = "ḅ", 	["Ḇ"] = "ḇ", 	["Ḉ"] = "ḉ", 	["Ḋ"] = "ḋ", 	["Ḍ"] = "ḍ", 	["Ḏ"] = "ḏ", 	["Ḑ"] = "ḑ", 	["Ḓ"] = "ḓ", 	["Ḕ"] = "ḕ", 	["Ḗ"] = "ḗ", 	["Ḙ"] = "ḙ", 	["Ḛ"] = "ḛ", 	["Ḝ"] = "ḝ", 	["Ḟ"] = "ḟ", 	["Ḡ"] = "ḡ", 	["Ḣ"] = "ḣ", 	["Ḥ"] = "ḥ", 	["Ḧ"] = "ḧ", 	["Ḩ"] = "ḩ", 	["Ḫ"] = "ḫ", 	["Ḭ"] = "ḭ", 	["Ḯ"] = "ḯ", 	["Ḱ"] = "ḱ", 	["Ḳ"] = "ḳ", 	["Ḵ"] = "ḵ", 	["Ḷ"] = "ḷ", 	["Ḹ"] = "ḹ", 	["Ḻ"] = "ḻ", 	["Ḽ"] = "ḽ", 	["Ḿ"] = "ḿ", 	["Ṁ"] = "ṁ", 	["Ṃ"] = "ṃ", 	["Ṅ"] = "ṅ", 	["Ṇ"] = "ṇ", 	["Ṉ"] = "ṉ", 	["Ṋ"] = "ṋ", 	["Ṍ"] = "ṍ", 	["Ṏ"] = "ṏ", 	["Ṑ"] = "ṑ", 	["Ṓ"] = "ṓ", 	["Ṕ"] = "ṕ", 	["Ṗ"] = "ṗ", 	["Ṙ"] = "ṙ", 	["Ṛ"] = "ṛ", 	["Ṝ"] = "ṝ", 	["Ṟ"] = "ṟ", 	["Ṡ"] = "ṡ", 	["Ṣ"] = "ṣ", 	["Ṥ"] = "ṥ", 	["Ṧ"] = "ṧ", 	["Ṩ"] = "ṩ", 	["Ṫ"] = "ṫ", 	["Ṭ"] = "ṭ", 	["Ṯ"] = "ṯ", 	["Ṱ"] = "ṱ", 	["Ṳ"] = "ṳ", 	["Ṵ"] = "ṵ", 	["Ṷ"] = "ṷ", 	["Ṹ"] = "ṹ", 	["Ṻ"] = "ṻ", 	["Ṽ"] = "ṽ", 	["Ṿ"] = "ṿ", 	["Ẁ"] = "ẁ", 	["Ẃ"] = "ẃ", 	["Ẅ"] = "ẅ", 	["Ẇ"] = "ẇ", 	["Ẉ"] = "ẉ", 	["Ẋ"] = "ẋ", 	["Ẍ"] = "ẍ", 	["Ẏ"] = "ẏ", 	["Ẑ"] = "ẑ", 	["Ẓ"] = "ẓ", 	["Ẕ"] = "ẕ", 	["Ạ"] = "ạ", 	["Ả"] = "ả", 	["Ấ"] = "ấ", 	["Ầ"] = "ầ", 	["Ẩ"] = "ẩ", 	["Ẫ"] = "ẫ", 	["Ậ"] = "ậ", 	["Ắ"] = "ắ", 	["Ằ"] = "ằ", 	["Ẳ"] = "ẳ", 	["Ẵ"] = "ẵ", 	["Ặ"] = "ặ", 	["Ẹ"] = "ẹ", 	["Ẻ"] = "ẻ", 	["Ẽ"] = "ẽ", 	["Ế"] = "ế", 	["Ề"] = "ề", 	["Ể"] = "ể", 	["Ễ"] = "ễ", 	["Ệ"] = "ệ", 	["Ỉ"] = "ỉ", 	["Ị"] = "ị", 	["Ọ"] = "ọ", 	["Ỏ"] = "ỏ", 	["Ố"] = "ố", 	["Ồ"] = "ồ", 	["Ổ"] = "ổ", 	["Ỗ"] = "ỗ", 	["Ộ"] = "ộ", 	["Ớ"] = "ớ", 	["Ờ"] = "ờ", 	["Ở"] = "ở", 	["Ỡ"] = "ỡ", 	["Ợ"] = "ợ", 	["Ụ"] = "ụ", 	["Ủ"] = "ủ", 	["Ứ"] = "ứ", 	["Ừ"] = "ừ", 	["Ử"] = "ử", 	["Ữ"] = "ữ", 	["Ự"] = "ự", 	["Ỳ"] = "ỳ", 	["Ỵ"] = "ỵ", 	["Ỷ"] = "ỷ", 	["Ỹ"] = "ỹ", 	["Ἀ"] = "ἀ", 	["Ἁ"] = "ἁ", 	["Ἂ"] = "ἂ", 	["Ἃ"] = "ἃ", 	["Ἄ"] = "ἄ", 	["Ἅ"] = "ἅ", 	["Ἆ"] = "ἆ", 	["Ἇ"] = "ἇ", 	["Ἐ"] = "ἐ", 	["Ἑ"] = "ἑ", 	["Ἒ"] = "ἒ", 	["Ἓ"] = "ἓ", 	["Ἔ"] = "ἔ", 	["Ἕ"] = "ἕ", 	["Ἠ"] = "ἠ", 	["Ἡ"] = "ἡ", 	["Ἢ"] = "ἢ", 	["Ἣ"] = "ἣ", 	["Ἤ"] = "ἤ", 	["Ἥ"] = "ἥ", 	["Ἦ"] = "ἦ", 	["Ἧ"] = "ἧ", 	["Ἰ"] = "ἰ", 	["Ἱ"] = "ἱ", 	["Ἲ"] = "ἲ", 	["Ἳ"] = "ἳ", 	["Ἴ"] = "ἴ", 	["Ἵ"] = "ἵ", 	["Ἶ"] = "ἶ", 	["Ἷ"] = "ἷ", 	["Ὀ"] = "ὀ", 	["Ὁ"] = "ὁ", 	["Ὂ"] = "ὂ", 	["Ὃ"] = "ὃ", 	["Ὄ"] = "ὄ", 	["Ὅ"] = "ὅ", 	["Ὑ"] = "ὑ", 	["Ὓ"] = "ὓ", 	["Ὕ"] = "ὕ", 	["Ὗ"] = "ὗ", 	["Ὠ"] = "ὠ", 	["Ὡ"] = "ὡ", 	["Ὢ"] = "ὢ", 	["Ὣ"] = "ὣ", 	["Ὤ"] = "ὤ", 	["Ὥ"] = "ὥ", 	["Ὦ"] = "ὦ", 	["Ὧ"] = "ὧ", 	["ᾈ"] = "ᾀ", 	["ᾉ"] = "ᾁ", 	["ᾊ"] = "ᾂ", 	["ᾋ"] = "ᾃ", 	["ᾌ"] = "ᾄ", 	["ᾍ"] = "ᾅ", 	["ᾎ"] = "ᾆ", 	["ᾏ"] = "ᾇ", 	["ᾘ"] = "ᾐ", 	["ᾙ"] = "ᾑ", 	["ᾚ"] = "ᾒ", 	["ᾛ"] = "ᾓ", 	["ᾜ"] = "ᾔ", 	["ᾝ"] = "ᾕ", 	["ᾞ"] = "ᾖ", 	["ᾟ"] = "ᾗ", 	["ᾨ"] = "ᾠ", 	["ᾩ"] = "ᾡ", 	["ᾪ"] = "ᾢ", 	["ᾫ"] = "ᾣ", 	["ᾬ"] = "ᾤ", 	["ᾭ"] = "ᾥ", 	["ᾮ"] = "ᾦ", 	["ᾯ"] = "ᾧ", 	["Ᾰ"] = "ᾰ", 	["Ᾱ"] = "ᾱ", 	["Ὰ"] = "ὰ", 	["Ά"] = "ά", 	["ᾼ"] = "ᾳ", 	["Ὲ"] = "ὲ", 	["Έ"] = "έ", 	["Ὴ"] = "ὴ", 	["Ή"] = "ή", 	["ῌ"] = "ῃ", 	["Ῐ"] = "ῐ", 	["Ῑ"] = "ῑ", 	["Ὶ"] = "ὶ", 	["Ί"] = "ί", 	["Ῠ"] = "ῠ", 	["Ῡ"] = "ῡ", 	["Ὺ"] = "ὺ", 	["Ύ"] = "ύ", 	["Ῥ"] = "ῥ", 	["Ὸ"] = "ὸ", 	["Ό"] = "ό", 	["Ὼ"] = "ὼ", 	["Ώ"] = "ώ", 	["ῼ"] = "ῳ", 	["Ω"] = "ω", 	["K"] = "k", 	["Å"] = "å", 	["Ⅎ"] = "ⅎ", 	["Ⅰ"] = "ⅰ", 	["Ⅱ"] = "ⅱ", 	["Ⅲ"] = "ⅲ", 	["Ⅳ"] = "ⅳ", 	["Ⅴ"] = "ⅴ", 	["Ⅵ"] = "ⅵ", 	["Ⅶ"] = "ⅶ", 	["Ⅷ"] = "ⅷ", 	["Ⅸ"] = "ⅸ", 	["Ⅹ"] = "ⅹ", 	["Ⅺ"] = "ⅺ", 	["Ⅻ"] = "ⅻ", 	["Ⅼ"] = "ⅼ", 	["Ⅽ"] = "ⅽ", 	["Ⅾ"] = "ⅾ", 	["Ⅿ"] = "ⅿ", 	["Ↄ"] = "ↄ", 	["Ⓐ"] = "ⓐ", 	["Ⓑ"] = "ⓑ", 	["Ⓒ"] = "ⓒ", 	["Ⓓ"] = "ⓓ", 	["Ⓔ"] = "ⓔ", 	["Ⓕ"] = "ⓕ", 	["Ⓖ"] = "ⓖ", 	["Ⓗ"] = "ⓗ", 	["Ⓘ"] = "ⓘ", 	["Ⓙ"] = "ⓙ", 	["Ⓚ"] = "ⓚ", 	["Ⓛ"] = "ⓛ", 	["Ⓜ"] = "ⓜ", 	["Ⓝ"] = "ⓝ", 	["Ⓞ"] = "ⓞ", 	["Ⓟ"] = "ⓟ", 	["Ⓠ"] = "ⓠ", 	["Ⓡ"] = "ⓡ", 	["Ⓢ"] = "ⓢ", 	["Ⓣ"] = "ⓣ", 	["Ⓤ"] = "ⓤ", 	["Ⓥ"] = "ⓥ", 	["Ⓦ"] = "ⓦ", 	["Ⓧ"] = "ⓧ", 	["Ⓨ"] = "ⓨ", 	["Ⓩ"] = "ⓩ", 	["Ⰰ"] = "ⰰ", 	["Ⰱ"] = "ⰱ", 	["Ⰲ"] = "ⰲ", 	["Ⰳ"] = "ⰳ", 	["Ⰴ"] = "ⰴ", 	["Ⰵ"] = "ⰵ", 	["Ⰶ"] = "ⰶ", 	["Ⰷ"] = "ⰷ", 	["Ⰸ"] = "ⰸ", 	["Ⰹ"] = "ⰹ", 	["Ⰺ"] = "ⰺ", 	["Ⰻ"] = "ⰻ", 	["Ⰼ"] = "ⰼ", 	["Ⰽ"] = "ⰽ", 	["Ⰾ"] = "ⰾ", 	["Ⰿ"] = "ⰿ", 	["Ⱀ"] = "ⱀ", 	["Ⱁ"] = "ⱁ", 	["Ⱂ"] = "ⱂ", 	["Ⱃ"] = "ⱃ", 	["Ⱄ"] = "ⱄ", 	["Ⱅ"] = "ⱅ", 	["Ⱆ"] = "ⱆ", 	["Ⱇ"] = "ⱇ", 	["Ⱈ"] = "ⱈ", 	["Ⱉ"] = "ⱉ", 	["Ⱊ"] = "ⱊ", 	["Ⱋ"] = "ⱋ", 	["Ⱌ"] = "ⱌ", 	["Ⱍ"] = "ⱍ", 	["Ⱎ"] = "ⱎ", 	["Ⱏ"] = "ⱏ", 	["Ⱐ"] = "ⱐ", 	["Ⱑ"] = "ⱑ", 	["Ⱒ"] = "ⱒ", 	["Ⱓ"] = "ⱓ", 	["Ⱔ"] = "ⱔ", 	["Ⱕ"] = "ⱕ", 	["Ⱖ"] = "ⱖ", 	["Ⱗ"] = "ⱗ", 	["Ⱘ"] = "ⱘ", 	["Ⱙ"] = "ⱙ", 	["Ⱚ"] = "ⱚ", 	["Ⱛ"] = "ⱛ", 	["Ⱜ"] = "ⱜ", 	["Ⱝ"] = "ⱝ", 	["Ⱞ"] = "ⱞ", 	["Ⱡ"] = "ⱡ", 	["Ɫ"] = "ɫ", 	["Ᵽ"] = "ᵽ", 	["Ɽ"] = "ɽ", 	["Ⱨ"] = "ⱨ", 	["Ⱪ"] = "ⱪ", 	["Ⱬ"] = "ⱬ", 	["Ⱶ"] = "ⱶ", 	["Ⲁ"] = "ⲁ", 	["Ⲃ"] = "ⲃ", 	["Ⲅ"] = "ⲅ", 	["Ⲇ"] = "ⲇ", 	["Ⲉ"] = "ⲉ", 	["Ⲋ"] = "ⲋ", 	["Ⲍ"] = "ⲍ", 	["Ⲏ"] = "ⲏ", 	["Ⲑ"] = "ⲑ", 	["Ⲓ"] = "ⲓ", 	["Ⲕ"] = "ⲕ", 	["Ⲗ"] = "ⲗ", 	["Ⲙ"] = "ⲙ", 	["Ⲛ"] = "ⲛ", 	["Ⲝ"] = "ⲝ", 	["Ⲟ"] = "ⲟ", 	["Ⲡ"] = "ⲡ", 	["Ⲣ"] = "ⲣ", 	["Ⲥ"] = "ⲥ", 	["Ⲧ"] = "ⲧ", 	["Ⲩ"] = "ⲩ", 	["Ⲫ"] = "ⲫ", 	["Ⲭ"] = "ⲭ", 	["Ⲯ"] = "ⲯ", 	["Ⲱ"] = "ⲱ", 	["Ⲳ"] = "ⲳ", 	["Ⲵ"] = "ⲵ", 	["Ⲷ"] = "ⲷ", 	["Ⲹ"] = "ⲹ", 	["Ⲻ"] = "ⲻ", 	["Ⲽ"] = "ⲽ", 	["Ⲿ"] = "ⲿ", 	["Ⳁ"] = "ⳁ", 	["Ⳃ"] = "ⳃ", 	["Ⳅ"] = "ⳅ", 	["Ⳇ"] = "ⳇ", 	["Ⳉ"] = "ⳉ", 	["Ⳋ"] = "ⳋ", 	["Ⳍ"] = "ⳍ", 	["Ⳏ"] = "ⳏ", 	["Ⳑ"] = "ⳑ", 	["Ⳓ"] = "ⳓ", 	["Ⳕ"] = "ⳕ", 	["Ⳗ"] = "ⳗ", 	["Ⳙ"] = "ⳙ", 	["Ⳛ"] = "ⳛ", 	["Ⳝ"] = "ⳝ", 	["Ⳟ"] = "ⳟ", 	["Ⳡ"] = "ⳡ", 	["Ⳣ"] = "ⳣ", 	["Ａ"] = "ａ", 	["Ｂ"] = "ｂ", 	["Ｃ"] = "ｃ", 	["Ｄ"] = "ｄ", 	["Ｅ"] = "ｅ", 	["Ｆ"] = "ｆ", 	["Ｇ"] = "ｇ", 	["Ｈ"] = "ｈ", 	["Ｉ"] = "ｉ", 	["Ｊ"] = "ｊ", 	["Ｋ"] = "ｋ", 	["Ｌ"] = "ｌ", 	["Ｍ"] = "ｍ", 	["Ｎ"] = "ｎ", 	["Ｏ"] = "ｏ", 	["Ｐ"] = "ｐ", 	["Ｑ"] = "ｑ", 	["Ｒ"] = "ｒ", 	["Ｓ"] = "ｓ", 	["Ｔ"] = "ｔ", 	["Ｕ"] = "ｕ", 	["Ｖ"] = "ｖ", 	["Ｗ"] = "ｗ", 	["Ｘ"] = "ｘ", 	["Ｙ"] = "ｙ", 	["Ｚ"] = "ｚ", 	["𐐀"] = "𐐨", 	["𐐁"] = "𐐩", 	["𐐂"] = "𐐪", 	["𐐃"] = "𐐫", 	["𐐄"] = "𐐬", 	["𐐅"] = "𐐭", 	["𐐆"] = "𐐮", 	["𐐇"] = "𐐯", 	["𐐈"] = "𐐰", 	["𐐉"] = "𐐱", 	["𐐊"] = "𐐲", 	["𐐋"] = "𐐳", 	["𐐌"] = "𐐴", 	["𐐍"] = "𐐵", 	["𐐎"] = "𐐶", 	["𐐏"] = "𐐷", 	["𐐐"] = "𐐸", 	["𐐑"] = "𐐹", 	["𐐒"] = "𐐺", 	["𐐓"] = "𐐻", 	["𐐔"] = "𐐼", 	["𐐕"] = "𐐽", 	["𐐖"] = "𐐾", 	["𐐗"] = "𐐿", 	["𐐘"] = "𐑀", 	["𐐙"] = "𐑁", 	["𐐚"] = "𐑂", 	["𐐛"] = "𐑃", 	["𐐜"] = "𐑄", 	["𐐝"] = "𐑅", 	["𐐞"] = "𐑆", 	["𐐟"] = "𐑇", 	["𐐠"] = "𐑈", 	["𐐡"] = "𐑉", 	["𐐢"] = "𐑊", 	["𐐣"] = "𐑋", 	["𐐤"] = "𐑌", 	["𐐥"] = "𐑍", 	["𐐦"] = "𐑎", 	["𐐧"] = "𐑏", }	
	-- replace UTF-8 characters based on a mapping table
	local function utf8replace (s, mapping)
		-- argument checking
		if type(s) ~= "string" then
			error("bad argument #1 to 'utf8replace' (string expected, got ".. type(s).. ")")
		end
		if type(mapping) ~= "table" then
			error("bad argument #2 to 'utf8replace' (table expected, got ".. type(mapping).. ")")
		end
	 
		local pos = 1
		local bytes = s:len()
		local charbytes
		local newstr = ""
	 
		while pos <= bytes do
			charbytes = utf8charbytes(s, pos)
			local c = s:sub(pos, pos + charbytes - 1)
	 
			newstr = newstr .. (mapping[c] or c)
	 
			pos = pos + charbytes
		end
	 
		return newstr
	end
	 
	 
	-- identical to string.upper except it knows about unicode simple case conversions
	local function utf8upper (s)
		return utf8replace(s, utf8_lc_uc)
	end
	 
	-- identical to string.lower except it knows about unicode simple case conversions
	local function utf8lower (s)
		return utf8replace(s, utf8_uc_lc)
	end	
	local font = "Metrostroi_Infkiev"
	function TRAIN_SYSTEM:ClientThink()
		-- if not self.Train:ShouldDrawPanel("InfScreen_2") then return end
			if not self.DrawTimer then
				render.PushRenderTarget(self.Train.InfScreen,0,0,512, 128)
				render.Clear(0, 0, 0, 0)
				render.PopRenderTarget()
			end
			if self.DrawTimer and CurTime()-self.DrawTimer < 0.1 then return end
			self.DrawTimer = CurTime()
			render.PushRenderTarget(self.Train.InfScreen,0,0,512, 128)
			--render.Clear(0, 0, 0, 0)
			cam.Start2D()
				self:InfScreen(self.Train)
			cam.End2D()
			render.PopRenderTarget()
	end
 
	function TRAIN_SYSTEM:PrintText(x,y,text,inverse, inf2003, isleft)
        local str = {utf8.codepoint(text,1,-1)}
        for i=1,#str do
            local char = utf8.char(str[i])
            if inverse then
                draw.SimpleText(string.char(0x7f),font,(x+i)*20.5+5,y*40+40,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(char,font,(x+i)*20.5+5,y*40+40,not inf2003 and Color(140,190,0,150) or Color(0,255,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(char,font,(x+i)*20.5+5,y*40+40,Color(0,0,0,130),left and TEXT_ALIGN_RIGHT or TEXT_ALIGN_CENTER,left and TEXT_ALIGN_RIGHT or TEXT_ALIGN_CENTER)
            end
        end
	end
	function TRAIN_SYSTEM:InfScreen(Train)

		local timer = Train:GetPackedRatio("INFTimer")
		local State = Train:GetNW2Int("INFState",1)  
		if State == -1 then 
			render.Clear(0, 0, 0, 0)
			return 
		end 
		if Train:GetNW2Int("Inform",1)==2 then Train:SetNW2Int("RadioInf",2) end 
        if Train:GetNW2Int("RadioInf",1) ~= 2 then 
			surface.SetDrawColor(0,150,0,255) 
			surface.DrawRect(0,0,512,128)
		if State == 0 then 
			self:PrintText(not Train:GetClass():find("5k") and 3 or 3,0,not Train:GetClass():find("5k") and "Версия 1.08" or "Версия 1.12")
			self:PrintText(not Train:GetClass():find("5k") and 2 or 1.5,1,not Train:GetClass():find("5k") and "От 28.10.2011" or "От 29.12.2016")
		end 
		if State == 1 then 
			self:PrintText(Train:GetClass():find("5k") and 0 or 2,0,"ТЕСТ информатора")
			if timer > 2.3 then
			local al = {"a","Б","В","Г","Д","Ж","З","Е","Ё"}
			self:PrintText(Train:GetClass():find("5k") and 7-2 or 7,1,Train:GetNW2Bool("Inf:IsKyiv") and "НОРМА" or math.random(0,999) .. table.Random(al))
			end 
		end 
		if State == 4 then 
			self:PrintText(Train:GetClass():find("5k") and 0 or 2,0,"Ошибка: ")
			if timer > 2.3 then
			local al = {"a","Б","В","Г","Д","Ж","З","Е","Ё"}
			self:PrintText(Train:GetClass():find("5k") and -0.5 or 7,1,Train:GetNW2Bool("Inf:IsKyiv") and "НОРМА" or "0.mp3 is not found")
			end 
		end 
		if State == 3 then 
			self:PrintText(2,0,"файл: " .. "1d" .. ".mp3" )
			self:PrintText(0,1,"НЕ ВЫКЛЮЧАЙТЕ ПИТАНИЕ")
		end
		if State == 2 then 
			local stbl = Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
			local ltbl = stbl[1]
			local Path = Train:GetNW2Bool("Inf:Path")
			local Dep = self.Train:GetNW2Bool("Inf:Arrived",false)	
			local al = {"a","Б","В","Г","Д","Ж","З","Е","Ё","ы","ь","э","ш","Щ","Х","ч","я","$","%^$32","#@!"}
			local err = Train:GetNW2Bool("Inf:Error") and math.random(0,999) .. table.Random(al) or "" 
			local FirstStation,LastStation = Train:GetNW2Int("Inf:FirstStation"),Train:GetNW2Int("Inf:LastStation")
            local StartSt,EndSt = ltbl[Path and LastStation or FirstStation],ltbl[Path and FirstStation or LastStation]
			local Station = ltbl[Train:GetNW2Int("Inf:Station",1)+(Dep and 1 or 0)*(Path and -1 or 1)*(FirstStation == Train:GetNW2Int("Inf:Station",1) and not Dep and 0 or 1)*(LastStation == Train:GetNW2Int("Inf:Station",1) and not Dep and 0 or 1)]
			if (Station == StartSt and not Dep or ltbl[Train:GetNW2Int("Inf:Station",1)] == EndSt and Dep) then
				self:PrintText(0,0,not Train:GetClass():find("5k") and "Напрямок руху" or "Направление движ.")
				self:PrintText(0,1,utf8upper(EndSt[2])) 
			else
				if Dep then
					self:PrintText(0,0,not Train:GetClass():find("5k") and "Наступна ст" .. err .. "анцiя" or "Следу".. err .."ющая станц.")
				else
					self:PrintText(0,0,not Train:GetClass():find("5k") and "Стан".. err .."цiя" or "Станц" .. err .."ия")--ія")
				end

				self:PrintText(0,1,utf8upper(err[1] .. Station[2]))
			end
		end 
	else 
		surface.SetDrawColor(0,160,0,255) 
		surface.DrawRect(0,0,512,128)
		if State == 2 then 
			local stbl = Metrostroi.ASNPSetup and Metrostroi.ASNPSetup[Train:GetNW2Int("Announcer",1)]
			local ltbl = stbl[1]
			local Path = Train:GetNW2Bool("Inf:Path")
			local Dep = self.Train:GetNW2Bool("Inf:Arrived",false)	

			local FirstStation,LastStation = Train:GetNW2Int("Inf:FirstStation"),Train:GetNW2Int("Inf:LastStation")

            local StartSt,EndSt = ltbl[Path and LastStation or FirstStation],ltbl[Path and FirstStation or LastStation]
			local Station = ltbl[Train:GetNW2Int("Inf:Station",1)+(Dep and 1 or 0)*(Path and -1 or 1)*(FirstStation == Train:GetNW2Int("Inf:Station",1) and not Dep and 0 or 1)*(LastStation == Train:GetNW2Int("Inf:Station",1) and not Dep and 0 or 1)]
			if (Station == StartSt and not Dep or ltbl[Train:GetNW2Int("Inf:Station",1)] == EndSt and Dep) then
				self:PrintText(4,0,"- " .. utf8upper(EndSt[2]) .. " -",false,true)
				self:PrintText(8,1," " .. utf8upper(Station[2]) .. " ",false,true) 
			else
				self:PrintText(4,0,"- " .. utf8upper(EndSt[2]) .. " -",false,true)
				self:PrintText(7,1," " .. utf8upper(Station[2]) .. " ",false,true, true) 
			end
		end 
	end  
		if State == 3 then 
			local code = Train:GetNW2Bool("Inf:Code",false)
			if not code then 
				self:PrintText(2,0,"Инженерное меню")
				if Train:GetNW2Int("Inf:CodeT",0) == 0 then 
				self:PrintText(2,1,"Код доступа: введите") 
				else 
				self:PrintText(2,1,"Код доступа: " .. Train:GetNW2Int("Inf:CodeT",0)) 
				end 
			else 
				self:PrintText(0,0,"Kyiv 2003. ver. 23.11.2017" )
				self:PrintText(0,1,"path:" .. getpath(nil,Train) .. " St:" .. getst(Train))
			end 

		end 
    end
	if State == 4 then 
		local str = self:GetNW2Int("Inf:STRR",1)
		self:PrintText(0, 0,"Диагностическое окно")
		if str == 1 then 
		   self:PrintText(0,1, "Логика прошивки: " .. self:GetNW2String("Inf:LogicVersion","ККЛ"))
		end
	end
    net.Receive("metrostroi_infkiev_announcer", function(len, pl)
        local train = net.ReadEntity()
        if not IsValid(train) or not train.RenderClientEnts then return end
        local snd = net.ReadString()

		local v = train.AnnouncerPositions[1]
		train:PlayOnceFromPos("announcer1", snd, v[3] or 1, 1, 999, 1e9, v[1])
    end)	
end