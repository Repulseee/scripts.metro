-- print(Metrostroi.SignalDebugCV)
-- Спасибо TheFulDeep за ко

if SERVER then 
    hook.Add("OnEntityCreated", "AlsFReqForKKL", function(ent)
        timer.Simple(3, function() 
            if not IsValid(ent) or not (ent:GetClass():find("717_k",1,true) or ent:GetClass():find("717_5k",1,true)) then return end
            local blizhniy
            for k,v in pairs(ents.FindByClass("gmod_track_signal")) do
                if IsValid(v) and (not blizhniy or ent:GetPos():DistToSqr(v:GetPos()) < ent:GetPos():DistToSqr(blizhniy:GetPos())) then blizhniy = v end
            end            
        
            if not blizhniy or not blizhniy.TwoToSix then return end   
            if ent.ALSFreq and ent.ALSFreq.TriggerInput then ent.ALSFreq:TriggerInput("Set",1) end  
        end)           
    end)     
end               
                    
KKL = KKL or {}                      
             
function KKL.Log(s)                     
       MsgC(Color(0,255,0), s .. "\n")                  
end              
         
function KKL.GenerateNumber(train,tbl,func,retry)   
    -- Metrostroi.RemoveNumber(train)                  
    if not tbl or not IsValid(train) then return 0 end
    local typ = train.SubwayTrain and train.SubwayTrain.Type or train:GetClass()
    -- if not Metrostroi.UsedNumbers[typ] then Metrostroi.UsedNumbers[typ] = {} end 	   
    for i=1,1000 do 
        local range = train.ScepRang and tbl[train.ScepRang] or tbl[math.random(1,#tbl)]
        local number 
        if range[1]==true then  
            local tblN = range[2]
            number = tblN[math.random(1,#tblN)]
        else
            number = math.random(range[1],range[2])           
        end     
        if func then number = func(train,number) or number end
        if number and number~=true and not Metrostroi.UsedNumbers[typ][number] then  
            -- Metrostroi.UsedNumbers[typ][number] = tr ue 
            print(Format("Создан номер сцепа #s для состава %s, %s,%s",number,train:GetClass(),train:EntIndex(),typ))
            return number,range[3] 
        end  
    end     
    if retry then
        ErrorNoHalt(Format("Metrostroi: Error generating scep number for train %s! Second try was failed.\n",train:GetClass()))
        return 0 
    else
        ErrorNoHalt(Format("Metrostroi: Error generating scep number for train %s! Clearing wagon numbers table...\n" ,train:GetClass()))
        Metrostroi.UsedNumbers = {}
        return KKL.GenerateNumber(train,tbl,func,true)
    end
end    
 
timer.Create( "AutomaticGryaz", 300, 0, function() 
         for _, ent in pairs( ents.FindByClass( "gmod_subway_81-717_5msbl" ) ) do 
              local dirt = ent:GetNW2Float("DirtLevel")
   
                  ent:SetNW2Float("DirtLevel",0.5)
              
         end  
end )  
if game.GetMap():find("m3") then 
	Metrostroi.AddANSPAnnouncer("Kyiv",
	{
		click_start = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click_end = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		announcer_ready = {"subway_announcers/ru_romanova/announcer_ready.mp3", 3.871},
		doors_closing = {"kyiv_announce/d.mp3", 3.3},
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5}, 
		next_luk = {"kyiv_announce/25d.mp3", 10.5},
		luk_arr = {"kyiv_announce/26.mp3", 4.5},
		g_to = {"kyiv_announce/23d.mp3", 9.3},
		g_arr = {"kyiv_announce/24.mp3", 12.3}, 
		p_to = {"kyiv_announce/21d.mp3", 9.3},
		p_arr = {"kyiv_announce/22.mp3", 13.3},
		to_kl = {"kyiv_announce/19d.mp3", 4.5}, 
		arr_kl = {"kyiv_announce/20.mp3", 3.3},  
		next_borysp = {"kyiv_announce/1d.mp3", 5.3},
		borysp_arr = {"kyiv_announce/2.mp3", 4.9}, 
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},
		next_sur = {"kyiv_announce/29d.mp3", 5.829}, 
	},
	{
		{
            LED = {5,5,5,5,5,5},
			Name = "Первая линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
            {
                151,"Сирець",
                arrlast = {nil,{"sur_arr"}, "sur_arr"},
                dep = {{"doors_closing", 2, "next_dor"}},
				right_doors = true
            },
            {
                153,"Дорогожичи",
                arr = {{"door_arr"},{"door_arr"}},
                dep = {{"doors_closing", 2, "next_luk"},{"doors_closing",2, "next_sur"}},
				right_doors = true
            },
            {
                154,"Лукяновская",
                arr = {{"luk_arr"},{"luk_arr"}},
                dep = {{"doors_closing", 2, "g_to"},{"doors_closing", 2, "next_door"}},
				right_doors = true
            },
            {     
                155,"White Forest",
                arr = {{"g_arr"},{"g_arr"}},
				arrlast = {{"prib", "white_forest","last_neid", "spec_attention_objects", "last_zakon"},{"prib", "white_forest","last_neid", "spec_attention_objects", "last_zakon"}, "white_forest"},
                dep = {{"doors_closing", 2, "p_to"},{"doors_closing", 2, "next_luk"}},
				not_last = {0.5, "m_train_goes_to", "m_white_forest"},
				right_doors = true
            },
            {
                156,"Urban Park",
                arr = {{"p_arr"},{"p_arr"}},
                dep = {{"doors_closing", 2, "next_hut"},{"doors_closing",2, "g_to"}},
				right_doors = true
            }, 
            {
                157,"Rocklake",
                arrlast = {{"hut_arr"}, nil, "hut_arr"},
                dep = {nil,{"doors_closing", "p_to"}},
            }
		}
	}
)
end 
if game.GetMap():find("b50") then 
	Metrostroi.AddANSPAnnouncer("Kyiv RRI",
	{
		click_start = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click_end = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		announcer_ready = {"subway_announcers/ru_romanova/announcer_ready.mp3", 3.871},
		click1 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click2 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		last = {"subway_announcers/ru_romanova/last.mp3", 1.021},
		last_neid = {"subway_announcers/ru_romanova/last_neid.mp3", 3.39},
		last_zakon = {"subway_announcers/ru_romanova/last_zakon.mp3", 7.565},	
		spec_attention_exit = {"subway_announcers/ru_romanova/spec_attention_exit.mp3", 4.418},
		spec_attention_handrails = {"subway_announcers/ru_romanova/spec_attention_handrails.mp3", 4.987},
		spec_attention_objects = {"subway_announcers/ru_romanova/spec_attention_things.mp3", 5.057},
		spec_attention_politeness = {"subway_announcers/ru_romanova/spec_attention_politeness.mp3", 8.89},
		spec_attention_train_depart = {"subway_announcers/ru_romanova/spec_attention_train_depart.mp3", 4.888},
		spec_attention_train_stop = {"subway_announcers/ru_romanova/spec_attention_train_stop.mp3", 6.061},
		spec_attention_train_fast = {"subway_announcers/ru_romanova/spec_attention_train_fast.mp3", 4.231},
		train_goes_to = {"subway_announcers/ru_romanova/train_goes_to.mp3", 2.465},
		doors_right = {"subway_announcers/ru_romanova/doors_right.mp3", 1.383},
		otpr = {"subway_announcers/ru_romanova/0_otpr.mp3", 3.970},
		prib = {"subway_announcers/ru_romanova/0_prib.mp3", 1.076},
		skip_vokzalnaya = {"subway_announcers/ru_romanova/skip_vokzalnaya.mp3", 4.600},	 

		doors_closing = {"kyiv_announce/rri/d.mp3", 3.3},
		next_dor = {"kyiv_announce/rri/27d.mp3", 5.5}, 
		door_arr = {"kyiv_announce/rri/28.mp3", 4.5},  
		next_luk = {"kyiv_announce/rri/25d.mp3", 10.5},
		luk_arr = {"kyiv_announce/rri/26.mp3", 4.5},  
		g_to = {"kyiv_announce/rri/23d.mp3", 9.3},     
		g_arr = {"kyiv_announce/rri/24.mp3", 12.3}, 
		p_to = {"kyiv_announce/rri/21d.mp3", 9.3},
		p_arr = {"kyiv_announce/rri/22.mp3", 13.3},
		to_kl = {"kyiv_announce/rri/19d.mp3", 4.5},  
		arr_kl = {"kyiv_announce/rri/20.mp3", 3.3},  
		p1_arr = {"kyiv_announce/rri/18.mp3",3.4},
		p1_to = {"kyiv_announce/rri/17d.mp3",8.4},   
		dr_arr = {"kyiv_announce/rri/16.mp3",4.4},
		dr_to = {"kyiv_announce/rri/15d.mp3",10.4},
		vud_arr = {"kyiv_announce/rri/14.mp3",12.4},
		vud_to = {"kyiv_announce/rri/13d.mp3",8.4},
		sl_arr = {"kyiv_announce/rri/12.mp3",4.4},
		sl_to = {"kyiv_announce/rri/11d.mp3",9.4},
		osk_arr = {"kyiv_announce/rri/10.mp3",4.4},
		osk_to = {"kyiv_announce/rri/9d.mp3",8.4},
		pozn_arr = {"kyiv_announce/rri/8.mp3",4.4},
		pozn_to = {"kyiv_announce/rri/7d.mp3",5.4},
		kh_arr = {"kyiv_announce/rri/6.mp3",10.4},
		kh_to = {"kyiv_announce/rri/5d.mp3",5.4},
		b_arr = {"kyiv_announce/rri/2.mp3",4.4},
		b_to = {"kyiv_announce/rri/1d.mp3",5.4},
		sur_arr = {"kyiv_announce/rri/30.mp3", 14.829},
		hut_arr = {"kyiv_announce/rri/31.mp3", 15.829},
		next_hut = {"kyiv_announce/rri/31d.mp3", 9.829},
		next_sur = {"kyiv_announce/rri/29d.mp3", 5.829}, 
	},
	{
		{
			LED = {3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 4},
			Name = "1 линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			{
				108,
				"Автозаводская",
				arrlast = {nil, {"sur_arr"}, "sur_arr"},
				dep = {{"doors_closing", 3, "next_dor"}}
			},
			{
				109,
				"Индустриальная",
				arr = {{"door_arr"}, {"door_arr"}},
				dep = {{"doors_closing", 3, "next_luk"}, {"doors_closing", 3, "next_sur"}}
			},
			{
				110,
				"Московская",
				arr = {{"luk_arr"}, {"luk_arr"}},
				dep = {{"doors_closing", 3, "g_to"}, {"doors_closing", 3, "next_dor"}},
				right_doors = true
			},
			{
				111,
				"Октябрьская", 
				arr = {{"g_arr"}, {"g_arr"}},
				dep = {{"doors_closing", 3, "p_to"}, {"doors_closing", 3, "next_luk"}},
				arrlast = {{"m_prib", "m_oktyabrskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "oktyabrskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "oktyabrskaya"},
				not_last = {0.5, "m_train_goes_to", "m_oktyabrskaya"}
			},
			{
				112,
				"Площадь мира",
				arr = {{"p_arr"}, {"p_arr"}},
				dep = {{"doors_closing", 3, "to_kl"}, {"doors_closing", 3, "g_to"}},
				arrlast = {{"m_prib", "m_ploschad_mira", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "ploschad_mira", "last_neid", "spec_attention_objects", "last_zakon"}, "ploschad_mira"},
				not_last = {0.5, "m_train_goes_to", "m_ploschad_mira"}
			},
			{
				113,
				"Новоармейская",
				arr = {{"arr_kl"}, {"arr_kl"}},
				dep = {{"doors_closing", 3, "p1_to"}, {"doors_closing", 3, "p_to"}}
			},
			{
				115,
				"Комсомольская",
				arr = {{"p1_arr"}, {"p1_arr"}},
				dep = {{"doors_closing", 3, "dr_to"}, {"doors_closing", 3, "to_kl"}},
				arrlast = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "komsomolskaya"},
				not_last = {0.5, "m_train_goes_to", "m_komsomolskaya"},
				have_inrerchange = true,
				right_doors = true
			},
			{
				116,
				"Электросила",
				arr = {{"dr_arr"}, {"dr_arr"}},
				dep = {{"doors_closing", 3, "vud_to"}, {"doors_closing", 3, "p1_to"}},
			},
			{
				117,
				"Театральная пл.",
				arr = {{"vud_arr"}, {"vud_arr"}},
				dep = {{"doors_closing", 3, "sl_to"}, {"doors_closing", 3, "dr_to"}}
			},
			{
				118,
				"Парк победы",
				arr = {{"sl_arr"}, {"sl_arr"}},
				dep = {{"doors_closing", 3, "osk_to"}, {"doors_closing", 3, "vud_to"}},
				right_doors = true
			},
			{
				119,
				"Синеозёрная",
				arr = {{"osk_arr"}, {"osk_arr"}},
				dep = {{"doors_closing", 3, "pozn_to"}, {"doors_closing", 3, "sl_to"}}
			},
			{
				121,
				"Минская",
				arr = {{"pozn_arr"}, {"pozn_arr"}},
				dep = {{"doors_closing", 3, "b_to"}, {"doors_closing", 3, "osk_to"}},
				arrlast = {{"prib", "minskaya", "last_neid", "spec_attention_objects", "last_zakon"}, {"m_prib", "m_minskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, "minskaya"},
				not_last = {0.5, "m_train_goes_to", "m_minskaya"}
			},
			{
				122,
				"Царские Ворота",
				arr = {{"kh_arr"}, {"kh_arr"}},
				dep = {{"doors_closing", 3, "b_to"}, {"doors_closing", 3, "pozn_to"}},
				have_inrerchange = true
			},
			{
				321,
				"Музей скульптур",
				arr = {{"b_arr"}, {"b_arr"}},
				dep = {{"doors_closing", 3, "next_hut"}, {"doors_closing", 3, "kh_to"}}
			},
		},
		{
			LED = {3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2},
			Name = "3 линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			{
				108,
				"Автозаводская",
				arrlast = {nil, {"prib", "avtozavodskaya", "last", "last_neid", "spec_attention_objects", "last_zakon"}, "avtozavodskaya"},
				dep = {{"m_otpr", "m_industrialnaya", "m_spec_attention_handrails"}}
			},
			{
				109,
				"Индустриальная",
				arr = {{"m_prib", "m_industrialnaya"}, {"prib", "industrialnaya","spec_attention_objects"}},
				dep = {{"m_otpr", "m_moskovskaya","m_doors_right"}, {"otpr", "avtozavodskaya"}}
			},
			{
				110,
				"Московская",
				arr = {{"m_prib", "m_moskovskaya","m_doors_right"}, {"prib", "moskovskaya","doors_right"}},
				dep = {{"m_otpr", "m_oktyabrskaya"}, {"otpr", "industrialnaya"}},
				right_doors = true
			},
			{
				111,
				"Октябрьская",
				arr = {{"m_prib", "m_oktyabrskaya","m_spec_attention_objects"}, {"prib", "oktyabrskaya","spec_attention_objects"}},
				dep = {{"m_otpr", "m_ploschad_mira"}, {"otpr", "moskovskaya","doors_right"}},
				arrlast = {{"m_prib", "m_oktyabrskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "oktyabrskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "oktyabrskaya"},
				not_last = {0.5, "m_train_goes_to", "m_oktyabrskaya"}
			},
			{
				112,
				"Площадь мира",
				arr = {{"m_prib", "m_ploschad_mira"}, {"prib", "ploschad_mira"}},
				dep = {{"m_otpr", "m_novoarmeyskaya"}, {"otpr", "oktyabrskaya"}},
				arrlast = {{"m_prib", "m_ploschad_mira", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "ploschad_mira", "last_neid", "spec_attention_objects", "last_zakon"}, "ploschad_mira"},
				not_last = {0.5, "m_train_goes_to", "m_ploschad_mira"}
			},
			{
				113,
				"Новоармейская",
				arr = {{"m_prib", "m_novoarmeyskaya","m_skip_vokzalnaya"}, {"prib", "novoarmeyskaya"}},
				dep = {{"m_otpr", "m_komsomolskaya","m_doors_right"}, {"otpr", "ploschad_mira","spec_attention_politeness"}}
			},
			{
				115,
				"Комсомольская",
				arr = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya","m_spec_attention_objects"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya","skip_vokzalnaya"}},
				dep = {{"m_otpr", "m_elektrosila"}, {"otpr", "novoarmeyskaya"}},
				arrlast = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "komsomolskaya"},
				not_last = {0.5, "m_train_goes_to", "m_komsomolskaya"},
				have_inrerchange = true,
				right_doors = true
			},
			{
				116,
				"Электросила",
				arr = {{"prib", "elektrosila"}, {"prib", "elektrosila"}},
				dep = {{"otpr", "teatralnaya_ploschad", "spec_attention_handrails"}, {"otpr", "komsomolskaya","doors_right"}}
			},
			{
				117,
				"Театральная пл.",
				arr = {{"prib", "teatralnaya_ploschad","spec_attention_objects"}, {"m_prib", "m_teatralnaya_ploschad","m_spec_attention_objects"}},
				dep = {{"otpr", "park_pobedy", "doors_right"}, {"m_otpr", "m_elektrosila"}}
			},
			{
				118,
				"Парк победы",
				arr = {{"prib", "park_pobedy","doors_right"}, {"m_prib", "m_park_pobedy", "m_doors_right"}},
				dep = {{"otpr", "sineozernaya"}, {"m_otpr", "m_teatralnaya_ploschad"}},
				right_doors = true
			},
			{
				119,
				"Синеозёрная",
				arr = {{"prib", "sineozernaya"}, {"m_prib", "m_sineozernaya"}},
				dep = {{"otpr", "minskaya","spec_attention_politeness"}, {"m_otpr", "m_park_pobedy", "m_doors_right"}}
			},
			{
				121,
				"Минская",
				arr = {{"prib", "minskaya", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_prib", "m_minskaya"}},
				dep = {{"otpr", "tsarskiye_vorota","spec_attention_exit", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_otpr", "m_sineozernaya"}},
				arrlast = {{"prib", "minskaya", "last_neid", "spec_attention_objects", "last_zakon"}, {"m_prib", "m_minskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, "minskaya"},
				not_last = {0.5, "m_train_goes_to", "m_minskaya"}
			},
			{
				122,
				"Царские Ворота",
				arr = {{"prib", "tsarskiye_vorota","towards_line_3", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_prib", "m_tsarskiye_vorota", "m_to_mezhdustroyskaya","m_spec_attention_objects"}},
				dep = {{"otpr", "muzey_skulptur"}, {"m_otpr", "m_minskaya"}},
				have_inrerchange = true
			},
			{
				321,
				"Музей скульптур",
				arr = {{"prib", "muzey_skulptur","spec_attention_objects"}, {"m_prib", "m_muzey_skulptur"}},
				dep = {{"otpr", "avtostanciya_yuzhnaya"}, {"m_otpr", "m_tsarskiye_vorota"}}
			},
			{
				322,
				"Автостанция Южная",
				arrlast = {{"prib", "avtostanciya_yuzhnaya", "last", "last_neid", "spec_attention_objects", "last_zakon"}, nil, "avtostanciya_yuzhnaya"},
				dep = {nil, {"m_otpr", "m_muzey_skulptur", "m_spec_attention_handrails"}},
			}
		}
	}
)
	Metrostroi.AddANSPAnnouncer("Kyiv",
	{
		click_start = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click_end = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		announcer_ready = {"subway_announcers/ru_romanova/announcer_ready.mp3", 3.871},
		click1 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click2 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		last = {"subway_announcers/ru_romanova/last.mp3", 1.021},
		last_neid = {"subway_announcers/ru_romanova/last_neid.mp3", 3.39},
		last_zakon = {"subway_announcers/ru_romanova/last_zakon.mp3", 7.565},	
		spec_attention_exit = {"subway_announcers/ru_romanova/spec_attention_exit.mp3", 4.418},
		spec_attention_handrails = {"subway_announcers/ru_romanova/spec_attention_handrails.mp3", 4.987},
		spec_attention_objects = {"subway_announcers/ru_romanova/spec_attention_things.mp3", 5.057},
		spec_attention_politeness = {"subway_announcers/ru_romanova/spec_attention_politeness.mp3", 8.89},
		spec_attention_train_depart = {"subway_announcers/ru_romanova/spec_attention_train_depart.mp3", 4.888},
		spec_attention_train_stop = {"subway_announcers/ru_romanova/spec_attention_train_stop.mp3", 6.061},
		spec_attention_train_fast = {"subway_announcers/ru_romanova/spec_attention_train_fast.mp3", 4.231},
		train_goes_to = {"subway_announcers/ru_romanova/train_goes_to.mp3", 2.465},
		doors_right = {"subway_announcers/ru_romanova/doors_right.mp3", 1.383},
		otpr = {"subway_announcers/ru_romanova/0_otpr.mp3", 3.970},
		prib = {"subway_announcers/ru_romanova/0_prib.mp3", 1.076},
		skip_vokzalnaya = {"subway_announcers/ru_romanova/skip_vokzalnaya.mp3", 4.600},	

		doors_closing = {"kyiv_announce/d.mp3", 3.3},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5}, 
		next_luk = {"kyiv_announce/25d.mp3", 10.5},
		luk_arr = {"kyiv_announce/26.mp3", 4.5},
		g_to = {"kyiv_announce/23d.mp3", 9.3},
		g_arr = {"kyiv_announce/24.mp3", 12.3}, 
		p_to = {"kyiv_announce/21d.mp3", 9.3},
		p_arr = {"kyiv_announce/22.mp3", 13.3},
		to_kl = {"kyiv_announce/19d.mp3", 4.5}, 
		arr_kl = {"kyiv_announce/20.mp3", 3.3},  
		p1_arr = {"kyiv_announce/18.mp3",3.4},
		p1_to = {"kyiv_announce/17d.mp3",8.4},
		dr_arr = {"kyiv_announce/16.mp3",4.4},
		dr_to = {"kyiv_announce/15d.mp3",10.4},
		vud_arr = {"kyiv_announce/14.mp3",12.4},
		vud_to = {"kyiv_announce/13d.mp3",8.4},
		sl_arr = {"kyiv_announce/12.mp3",4.4},
		sl_to = {"kyiv_announce/11d.mp3",9.4},
		osk_arr = {"kyiv_announce/10.mp3",4.4},
		osk_to = {"kyiv_announce/9d.mp3",8.4},
		pozn_arr = {"kyiv_announce/8.mp3",4.4},
		pozn_to = {"kyiv_announce/7d.mp3",5.4},
		kh_arr = {"kyiv_announce/6.mp3",10.4},
		kh_to = {"kyiv_announce/5d.mp3",5.4},
		b_arr = {"kyiv_announce/2.mp3",4.4},
		b_to = {"kyiv_announce/1d.mp3",5.4},
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},
		next_sur = {"kyiv_announce/29d.mp3", 5.829}, 
	},
	{
		{
			LED = {3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 4},
			Name = "1 линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			{
				108,
				"Автозаводская",
				arrlast = {nil, {"sur_arr"}, "sur_arr"},
				dep = {{"doors_closing", 3, "next_dor"}}
			},
			{
				109,
				"Индустриальная",
				arr = {{"door_arr"}, {"door_arr"}},
				dep = {{"doors_closing", 3, "next_luk"}, {"doors_closing", 3, "next_sur"}}
			},
			{
				110,
				"Московская",
				arr = {{"luk_arr"}, {"luk_arr"}},
				dep = {{"doors_closing", 3, "g_to"}, {"doors_closing", 3, "next_dor"}},
				right_doors = true
			},
			{
				111,
				"Октябрьская",
				arr = {{"g_arr"}, {"g_arr"}},
				dep = {{"doors_closing", 3, "p_to"}, {"doors_closing", 3, "next_luk"}},
				arrlast = {{"m_prib", "m_oktyabrskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "oktyabrskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "oktyabrskaya"},
				not_last = {0.5, "m_train_goes_to", "m_oktyabrskaya"}
			},
			{
				112,
				"Площадь мира",
				arr = {{"p_arr"}, {"p_arr"}},
				dep = {{"doors_closing", 3, "to_kl"}, {"doors_closing", 3, "g_to"}},
				arrlast = {{"m_prib", "m_ploschad_mira", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "ploschad_mira", "last_neid", "spec_attention_objects", "last_zakon"}, "ploschad_mira"},
				not_last = {0.5, "m_train_goes_to", "m_ploschad_mira"}
			},
			{
				113,
				"Новоармейская",
				arr = {{"arr_kl"}, {"arr_kl"}},
				dep = {{"doors_closing", 3, "p1_to"}, {"doors_closing", 3, "p_to"}}
			},
			{
				115,
				"Комсомольская",
				arr = {{"p1_arr"}, {"p1_arr"}},
				dep = {{"doors_closing", 3, "dr_to"}, {"doors_closing", 3, "to_kl"}},
				arrlast = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "komsomolskaya"},
				not_last = {0.5, "m_train_goes_to", "m_komsomolskaya"},
				have_inrerchange = true,
				right_doors = true
			},
			{
				116,
				"Электросила",
				arr = {{"dr_arr"}, {"dr_arr"}},
				dep = {{"doors_closing", 3, "vud_to"}, {"doors_closing", 3, "p1_to"}},
			},
			{
				117,
				"Театральная пл.",
				arr = {{"vud_arr"}, {"vud_arr"}},
				dep = {{"doors_closing", 3, "sl_to"}, {"doors_closing", 3, "dr_to"}}
			},
			{
				118,
				"Парк победы",
				arr = {{"sl_arr"}, {"sl_arr"}},
				dep = {{"doors_closing", 3, "osk_to"}, {"doors_closing", 3, "vud_to"}},
				right_doors = true
			},
			{
				119,
				"Синеозёрная",
				arr = {{"osk_arr"}, {"osk_arr"}},
				dep = {{"doors_closing", 3, "pozn_to"}, {"doors_closing", 3, "sl_to"}}
			},
			{
				121,
				"Минская",
				arr = {{"pozn_arr"}, {"pozn_arr"}},
				dep = {{"doors_closing", 3, "b_to"}, {"doors_closing", 3, "osk_to"}},
				arrlast = {{"prib", "minskaya", "last_neid", "spec_attention_objects", "last_zakon"}, {"m_prib", "m_minskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, "minskaya"},
				not_last = {0.5, "m_train_goes_to", "m_minskaya"}
			},
			{
				122,
				"Царские Ворота",
				arr = {{"b_arr"}, {"b_arr"}},
				dep = {{"doors_closing", 3, "next_hut"}, {"doors_closing", 3, "pozn_to"}},
				have_inrerchange = true
			},
			{  
				123,
				"Междустройская",
				arrlast = {{"hut_arr"}, nil, "hut_arr"},
				dep = {nil, {"doors_closing",  3,"b_to"}},
				right_doors = true
			}
		},
		{
			LED = {3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2},
			Name = "3 линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			{
				108,
				"Автозаводская",
				arrlast = {nil, {"prib", "avtozavodskaya", "last", "last_neid", "spec_attention_objects", "last_zakon"}, "avtozavodskaya"},
				dep = {{"m_otpr", "m_industrialnaya", "m_spec_attention_handrails"}}
			},
			{
				109,
				"Индустриальная",
				arr = {{"m_prib", "m_industrialnaya"}, {"prib", "industrialnaya","spec_attention_objects"}},
				dep = {{"m_otpr", "m_moskovskaya","m_doors_right"}, {"otpr", "avtozavodskaya"}}
			},
			{
				110,
				"Московская",
				arr = {{"m_prib", "m_moskovskaya","m_doors_right"}, {"prib", "moskovskaya","doors_right"}},
				dep = {{"m_otpr", "m_oktyabrskaya"}, {"otpr", "industrialnaya"}},
				right_doors = true
			},
			{
				111,
				"Октябрьская",
				arr = {{"m_prib", "m_oktyabrskaya","m_spec_attention_objects"}, {"prib", "oktyabrskaya","spec_attention_objects"}},
				dep = {{"m_otpr", "m_ploschad_mira"}, {"otpr", "moskovskaya","doors_right"}},
				arrlast = {{"m_prib", "m_oktyabrskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "oktyabrskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "oktyabrskaya"},
				not_last = {0.5, "m_train_goes_to", "m_oktyabrskaya"}
			},
			{
				112,
				"Площадь мира",
				arr = {{"m_prib", "m_ploschad_mira"}, {"prib", "ploschad_mira"}},
				dep = {{"m_otpr", "m_novoarmeyskaya"}, {"otpr", "oktyabrskaya"}},
				arrlast = {{"m_prib", "m_ploschad_mira", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "ploschad_mira", "last_neid", "spec_attention_objects", "last_zakon"}, "ploschad_mira"},
				not_last = {0.5, "m_train_goes_to", "m_ploschad_mira"}
			},
			{
				113,
				"Новоармейская",
				arr = {{"m_prib", "m_novoarmeyskaya","m_skip_vokzalnaya"}, {"prib", "novoarmeyskaya"}},
				dep = {{"m_otpr", "m_komsomolskaya","m_doors_right"}, {"otpr", "ploschad_mira","spec_attention_politeness"}}
			},
			{
				115,
				"Комсомольская",
				arr = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya","m_spec_attention_objects"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya","skip_vokzalnaya"}},
				dep = {{"m_otpr", "m_elektrosila"}, {"otpr", "novoarmeyskaya"}},
				arrlast = {{"m_prib", "m_komsomolskaya","m_doors_right", "m_to_leninskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, {"prib", "komsomolskaya","doors_right", "to_leninskaya", "last_neid", "spec_attention_objects", "last_zakon"}, "komsomolskaya"},
				not_last = {0.5, "m_train_goes_to", "m_komsomolskaya"},
				have_inrerchange = true,
				right_doors = true
			},
			{
				116,
				"Электросила",
				arr = {{"prib", "elektrosila"}, {"prib", "elektrosila"}},
				dep = {{"otpr", "teatralnaya_ploschad", "spec_attention_handrails"}, {"otpr", "komsomolskaya","doors_right"}}
			},
			{
				117,
				"Театральная пл.",
				arr = {{"prib", "teatralnaya_ploschad","spec_attention_objects"}, {"m_prib", "m_teatralnaya_ploschad","m_spec_attention_objects"}},
				dep = {{"otpr", "park_pobedy", "doors_right"}, {"m_otpr", "m_elektrosila"}}
			},
			{
				118,
				"Парк победы",
				arr = {{"prib", "park_pobedy","doors_right"}, {"m_prib", "m_park_pobedy", "m_doors_right"}},
				dep = {{"otpr", "sineozernaya"}, {"m_otpr", "m_teatralnaya_ploschad"}},
				right_doors = true
			},
			{
				119,
				"Синеозёрная",
				arr = {{"prib", "sineozernaya"}, {"m_prib", "m_sineozernaya"}},
				dep = {{"otpr", "minskaya","spec_attention_politeness"}, {"m_otpr", "m_park_pobedy", "m_doors_right"}}
			},
			{
				121,
				"Минская",
				arr = {{"prib", "minskaya", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_prib", "m_minskaya"}},
				dep = {{"otpr", "tsarskiye_vorota","spec_attention_exit", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_otpr", "m_sineozernaya"}},
				arrlast = {{"prib", "minskaya", "last_neid", "spec_attention_objects", "last_zakon"}, {"m_prib", "m_minskaya", "m_last_neid", "m_spec_attention_objects", "m_last_zakon"}, "minskaya"},
				not_last = {0.5, "m_train_goes_to", "m_minskaya"}
			},
			{
				122,
				"Царские Ворота",
				arr = {{"prib", "tsarskiye_vorota","towards_line_3", 0.5, "train_goes_to", "avtostanciya_yuzhnaya"}, {"m_prib", "m_tsarskiye_vorota", "m_to_mezhdustroyskaya","m_spec_attention_objects"}},
				dep = {{"otpr", "muzey_skulptur"}, {"m_otpr", "m_minskaya"}},
				have_inrerchange = true
			},
			{
				321,
				"Музей скульптур",
				arr = {{"prib", "muzey_skulptur","spec_attention_objects"}, {"m_prib", "m_muzey_skulptur"}},
				dep = {{"otpr", "avtostanciya_yuzhnaya"}, {"m_otpr", "m_tsarskiye_vorota"}}
			},
			{
				322,
				"Автостанция Южная",
				arrlast = {{"prib", "avtostanciya_yuzhnaya", "last", "last_neid", "spec_attention_objects", "last_zakon"}, nil, "avtostanciya_yuzhnaya"},
				dep = {nil, {"m_otpr", "m_muzey_skulptur", "m_spec_attention_handrails"}},
			}
		}
	}
)
end 
if game.GetMap():find("rural") then 
    Metrostroi.AddANSPAnnouncer("Kyiv",
	{
		click_start = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click_end = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		announcer_ready = {"subway_announcers/ru_romanova/announcer_ready.mp3", 3.871},
		doors_closing = {"kyiv_announce/d.mp3", 3.3},
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5}, 
		next_luk = {"kyiv_announce/25d.mp3", 10.5},
		luk_arr = {"kyiv_announce/26.mp3", 4.5},
		g_to = {"kyiv_announce/23d.mp3", 9.3},
		g_arr = {"kyiv_announce/24.mp3", 12.3}, 
		p_to = {"kyiv_announce/21d.mp3", 9.3},
		p_arr = {"kyiv_announce/22.mp3", 13.3},
		to_kl = {"kyiv_announce/19d.mp3", 4.5}, 
		arr_kl = {"kyiv_announce/20.mp3", 3.3},  
		next_borysp = {"kyiv_announce/1d.mp3", 5.3},
		borysp_arr = {"kyiv_announce/2.mp3", 4.9}, 
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},
		next_sur = {"kyiv_announce/29d.mp3", 5.829}, 
	},
	{
		{
            LED = {5,5,5,5,5,5},
			Name = "Первая линия",
			Loop = false,
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
            {
                151,"Market Str.",
                arrlast = {nil,{"sur_arr"}, "sur_arr"},
                dep = {{"doors_closing", 2, "next_dor"}},
				right_doors = true
            },
            {
                153,"Aviation University",
                arr = {{"door_arr"},{"door_arr"}},
                dep = {{"doors_closing", 2, "next_luk"},{"doors_closing",2, "next_sur"}},
				right_doors = true
            },
            {
                154,"City Hall",
                arr = {{"luk_arr"},{"luk_arr"}},
                dep = {{"doors_closing", 2, "g_to"},{"doors_closing", 2, "next_door"}},
				right_doors = true
            },
            {
                155,"White Forest",
                arr = {{"g_arr"},{"g_arr"}},
				arrlast = {{"prib", "white_forest","last_neid", "spec_attention_objects", "last_zakon"},{"prib", "white_forest","last_neid", "spec_attention_objects", "last_zakon"}, "white_forest"},
                dep = {{"doors_closing", 2, "p_to"},{"doors_closing", 2, "next_luk"}},
				not_last = {0.5, "m_train_goes_to", "m_white_forest"},
				right_doors = true
            },
            {
                156,"Urban Park",
                arr = {{"p_arr"},{"p_arr"}},
                dep = {{"doors_closing", 2, "next_hut"},{"doors_closing",2, "g_to"}},
				right_doors = true
            },
            {
                157,"Rocklake",
                arrlast = {{"hut_arr"}, nil, "hut_arr"},
                dep = {nil,{"doors_closing", "p_to"}},
            }
		}
	}
)

end 
if game.GetMap():find("kalinin") then 
    Metrostroi.AddANSPAnnouncer("Kyiv 1 ", 
	{
		click_start = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
		click_end = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
		announcer_ready = {"subway_announcers/kalininskaya_real/announcer_ready.mp3", 3.87},
		click1 = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
		click2 = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
		spec_attention_train_depart = {"subway_announcers/kalininskaya_real/spec_attention_train_depart.mp3", 5.16},
		spec_attention_train_stop = {"subway_announcers/kalininskaya_real/spec_attention_train_stop.mp3", 6.5},
		spec_attention_train_fast = {"subway_announcers/kalininskaya_real/spec_attention_train_fast.mp3", 4.37},
		doors_closing = {"kyiv_announce/d.mp3", 3.3},
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5}, 
		next_luk = {"kyiv_announce/25d.mp3", 10.5},
		luk_arr = {"kyiv_announce/26.mp3", 4.5},
		g_to = {"kyiv_announce/23d.mp3", 9.3},
		g_arr = {"kyiv_announce/24.mp3", 12.3}, 
		p_to = {"kyiv_announce/21d.mp3", 9.3},
		p_arr = {"kyiv_announce/22.mp3", 13.3},
		to_kl = {"kyiv_announce/19d.mp3", 4.5},  
		arr_kl = {"kyiv_announce/20.mp3", 3.3},  
		next_borysp = {"kyiv_announce/1d.mp3", 5.3},
		borysp_arr = {"kyiv_announce/2.mp3",  4.9},    
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},     
		next_sur = {"kyiv_announce/29d.mp3", 5.829}, 
},
	{
		{
            LED = {3, 3, 3, 4, 4, 4, 4, 5},
            Name = "Калининская линия",
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			Loop = false,
            {
                801,"Новокосино",
				arrlast = {nil, {"sur_arr"}, "sur_arr"},
				dep = {{"doors_closing", 2, "next_dor"}, nil},
				have_inrerchange = true,
            },
            {
                802,"Новогиреево",
                arr = {{"door_arr"},{"door_arr"}},
                dep = {{"doors_closing",2, "next_luk"}, {"doors_closing", 2, "next_sur"}},
			    not_last = {"sled_02"},
				arrlast = {{"prib_02_m_neid"},{"prib_02_g_neid"}, "name_02_g"},
				have_inrerchange = true,
            },
            {
                803,"Перово",
                arr = {{"luk_arr"},{"luk_arr"}},
                dep = {{"doors_closing", 2, "g_to"},{"doors_closing",2, "next_dor"}},
				have_inrerchange = true,
            },
            {
                804,"Ш. Энтузиастов",
                arr = {{"g_arr"},{"g_arr"}},
                dep = {{"doors_closing", 2, "p_to"},{"doors_closing", 2, "next_luk"}},
				not_last = {"sled_04"},
				arrlast = {{"prib_04_m_neid"},{"prib_04_g_neid"}, "name_04_g"},
				have_inrerchange = true,
            },
            {
                805,"Авиамоторная",
                arr = {{"p_arr"},{"p_arr"}},
                dep = {{"doors_closing", 2, "to_kl"},{"doors_closing", 2, "g_to"}},
				have_inrerchange = true,
            },
            {
                806,"Площадь Ильича",
                arr = {{"arr_kl"},{"arr_kl"}},
                dep = {{"doors_closing", 2, "next_borysp"},{"doors_closing", 2, "p_to"}},
				have_inrerchange = true,
            },
            {
                807,"Марксистская",
                arr = {{"borysp_arr"},{"borysp_arr"}},
                dep = {{"doors_closing", 2, "next_hut"},{"doors_closing", 2, "to_kl"}},
			    not_last = {"sled_07"},
				arrlast = {{"prib_07_m_neid"}, nil, "name_07_g"},
				have_inrerchange = true,
            },	
            {
                808,"Третьяковск.",
				arrlast = {{"hut_arr"}, nil, "hut_arr"},
                dep = {nil, {"doors_closing", 2, "next_borysp"}},
				have_inrerchange = true,
            }
        }
    }
)   
Metrostroi.AddANSPAnnouncer("Kyiv RRI",
{
	click_start = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
	click_end = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
	announcer_ready = {"subway_announcers/kalininskaya_real/announcer_ready.mp3", 3.87},
	click1 = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
	click2 = {"subway_announcers/kalininskaya_real/click.mp3", 0.2},
	spec_attention_train_depart = {"subway_announcers/kalininskaya_real/spec_attention_train_depart.mp3", 5.16},
	spec_attention_train_stop = {"subway_announcers/kalininskaya_real/spec_attention_train_stop.mp3", 6.5},
	spec_attention_train_fast = {"subway_announcers/kalininskaya_real/spec_attention_train_fast.mp3", 4.37},
	doors_closing = {"kyiv_announce/rri/d.mp3", 3.3},
	sur_arr = {"kyiv_announce/rri/30.mp3", 14.829},
	next_dor = {"kyiv_announce/rri/27d.mp3", 5.5},
	door_arr = {"kyiv_announce/rri/28.mp3", 4.5}, 
	next_luk = {"kyiv_announce/rri/25d.mp3", 10.5},
	luk_arr = {"kyiv_announce/rri/26.mp3", 4.5},
	g_to = {"kyiv_announce/rri/23d.mp3", 9.3},
	g_arr = {"kyiv_announce/rri/24.mp3", 12.3}, 
	p_to = {"kyiv_announce/rri/21d.mp3", 9.3},
	p_arr = {"kyiv_announce/rri/22.mp3", 13.3},
	to_kl = {"kyiv_announce/rri/19d.mp3", 4.5}, 
	arr_kl = {"kyiv_announce/rri/20.mp3", 3.3},  
	next_borysp = {"kyiv_announce/rri/1d.mp3", 5.3},
	borysp_arr = {"kyiv_announce/rri/2.mp3", 4.9}, 
	hut_arr = {"kyiv_announce/rri/31.mp3", 15.829},
	next_hut = {"kyiv_announce/rri/31d.mp3", 9.829},
	next_sur = {"kyiv_announce/rri/29d.mp3", 5.829}, 
},
{
	{
		LED = {3, 3, 3, 4, 4, 4, 4, 5},
		Name = "Калининская линия",
		spec_last = {"spec_attention_train_fast"},
		spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
		Loop = false,
		{
			801,"Новокосино",
			arrlast = {nil, {"sur_arr"}, "sur_arr"},
			dep = {{"doors_closing", 2, "next_dor"}, nil},
			have_inrerchange = true,
		}, 
		{
			802,"Новогиреево",
			arr = {{"door_arr"},{"door_arr"}},
			dep = {{"doors_closing",2, "next_luk"}, {"doors_closing", 2, "next_sur"}},
			not_last = {"sled_02"},
			arrlast = {{"prib_02_m_neid"},{"prib_02_g_neid"}, "name_02_g"},
			have_inrerchange = true,
		},
		{
			803,"Перово",
			arr = {{"luk_arr"},{"luk_arr"}},
			dep = {{"doors_closing", 2, "g_to"},{"doors_closing",2, "next_dor"}},
			have_inrerchange = true,
		},
		{
			804,"Ш. Энтузиастов",
			arr = {{"g_arr"},{"g_arr"}},
			dep = {{"doors_closing", 2, "p_to"},{"doors_closing", 2, "next_luk"}},
			not_last = {"sled_04"},
			arrlast = {{"prib_04_m_neid"},{"prib_04_g_neid"}, "name_04_g"},
			have_inrerchange = true,
		},
		{
			805,"Авиамоторная",  
			arr = {{"p_arr"},{"p_arr"}},
			dep = {{"doors_closing", 2, "to_kl"},{"doors_closing", 2, "g_to"}},
			have_inrerchange = true,
		},
		{
			806,"Площадь Ильича",
			arr = {{"arr_kl"},{"arr_kl"}},
			dep = {{"doors_closing", 2, "next_borysp"},{"doors_closing", 2, "p_to"}},
			have_inrerchange = true,
		},
		{
			807,"Марксистская",
			arr = {{"borysp_arr"},{"borysp_arr"}},
			dep = {{"doors_closing", 2, "next_hut"},{"doors_closing", 2, "to_kl"}},
			not_last = {"sled_07"},
			arrlast = {{"prib_07_m_neid"}, nil, "name_07_g"},
			have_inrerchange = true,
		},	
		{
			808,"Третьяковск.",
			arrlast = {{"hut_arr"}, nil, "hut_arr"},
			dep = {nil, {"doors_closing", 2, "next_borysp"}},
			have_inrerchange = true,
		}
	}
}
)
end 
if game.GetMap():find("pll_remastered") then 

	Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		click_start = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click_end = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		announcer_ready = {"subway_announcers/ru_romanova/announcer_ready.mp3", 3.871},
		click1 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		click2 = {"subway_announcers/ru_romanova/click.mp3", 0.251},
		doors_closing = {"kyiv_announce/d.mp3", 3.5}, 
		
        next_borysp = {"kyiv_announce/1d.mp3", 5.3},
        borysp_arr = {"kyiv_announce/2.mp3", 4.9},  
        next_vyr = {"kyiv_announce/3d.mp3", 11.6},
        vyr_arr = {"kyiv_announce/4.mp3", 6.8},     
        next_kh = {"kyiv_announce/5d.mp3", 11.8},
        kh_arr = {"kyiv_announce/6.mp3", 11.5},
        next_luk = {"kyiv_announce/25d.mp3", 10.5},  
        luk_arr = {"kyiv_announce/26.mp3", 4.5},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5}, 
		next_sur = {"kyiv_announce/29d.mp3", 5.829},
		next_poz = {"kyiv_announce/7d.mp3", 5.6},
		poz_arr = {"kyiv_announce/8.mp3", 4.5},  
		next_osk = {"kyiv_announce/9d.mp3", 8.5},
		osk_arr = {"kyiv_announce/10.mp3", 4.5},


		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},
   
		
},{
		{
            LED = {4,4,5,4,5,4,4,0,0},
            Name = "Ленинградская линия",
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
            Loop = false,
            {
                150,"Лесопарковая",
                arrlast = {nil,{"hut_arr"},"hut_arr"},
                dep = {{"doors_closing", 2, "next_borysp"}, nil},
            },
            {
                151,"Селигерская",
                arr = {{"borysp_arr"},{"borysp_arr"}},
                dep = {{"doors_closing", 2, "next_vyr"},{"doors_closing", 2, "next_hut"}},
				arrlast = {{"prib", "seligerskaya","doors_right","last_neid", "spec_attention_objects", "last_zakon"},{"prib", "seligerskaya","doors_right","last_neid", "spec_attention_objects", "last_zakon"},"seligerskaya"},
				not_last = {0.5,"train_goes_to","seligerskaya"},
				right_doors = true
            },
            {
                152,"Двиг. Революции",
                arr = {{"vyr_arr"},{"vyr_arr"}},
                dep = {{"doors_closing", 2, "next_kh"},{"doors_closing", 2, "next_borysp"}},
            },
            {  
                153,"Строгино",
                arr = {{"kh_arr"},{"kh_arr"}},
                dep = {{"doors_closing", 2, "next_poz"},{"doors_closing", 2, "next_vyr"}},
            },
            {
                154,"Черкасск. пл",
                arr = {{"poz_arr"},{"poz_arr"}},
                dep = {{"doors_closing", 2, "next_osk"},{"doors_closing", 2, "next_kh"}},
				arrlast = {{"prib", "cherkasskaya_ploshad","doors_right","last_neid", "spec_attention_objects", "last_zakon"},{"prib", "cherkasskaya_ploshad","doors_right","last_neid", "spec_attention_objects", "last_zakon"},"cherkasskaya_ploshad"},
				not_last = {0.5,"train_goes_to","cherkasskaya_ploshad"},
				right_doors = true
            },
            {
                155,"Арсенальная",
                arr = {{"osk_arr"},{"osk_arr"}},
                dep = {{"doors_closing", 2, "next_sur"},{"doors_closing", 2, "next_poz"}},
            },
            {
                156,"Новомосковская",
                arrlast = {{"sur_arr"},nil, "sur_arr"},
                dep = {{"pause"},{"doors_closing", 2, "next_osk"}},
            },
        },
        {
            LED = {10,10,10},
            Name = "Пролетарская линия",
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
            Loop = false,
            {
                157,"Динамо",
                arrlast = {nil,{"prib", "dinamo","last","to_novomoskovskaya_rechnaya","last_neid", "spec_attention_objects", "last_zakon"},"dinamo"},
                dep = {{"otpr", "proletarskaya","spec_attention_handrails"}, nil},
            },
            {
                158,"Пролетарская",
                arr = {{"prib", "proletarskaya"},{"prib", "proletarskaya"}},
                dep = {{"otpr", "oktyabrskaya","spec_attention_objects"},{"otpr", "dinamo","spec_attention_exit"}},
            },
            {
                159,"Октябрьская",
                arrlast = {{"prib", "oktyabrskaya","last","last_neid", "spec_attention_objects", "last_zakon"},nil,"oktyabrskaya"},
                dep = {nil,{"otpr", "proletarskaya","spec_attention_handrails"}},
            },
        },
    }
)
end 
if game.GetMap():find("redux") then 
Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
		click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
        click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
		bezp = {"5m_sbl/bezpechno.mp3", 5},
        

		last = {"kyiv_announce/special/last2.mp3", 6.180},
		doors_closing = {"kyiv_announce/d.mp3", 3.5},
		
        arr_leningradskaya = {"kyiv_announce/3d.mp3", 11.6},
        arr1_leningradskaya = {"kyiv_announce/4.mp3", 6.8}, 
		arr_prospekt_mira = {"kyiv_announce/31d.mp3", 12.142},
		next_bor = {"kyiv_announce/1d.mp3", 5.3},
		bor = {"kyiv_announce/2.mp3", 4.9},  
        -- bor = {"5m_sbl/arr_borispilska.mp3", 3.5},
		
		 
		
        --luk.mp3
        prosp = {"kyiv_announce/31.mp3", 15.5},

		arr_seligerskaya = {"kyiv_announce/syrec.wav", 4.829},

	},
	{
		{ 
			LED = {10,10,10},
			Name = "ПЛЛ",
			spec_last = {"last"},
			spec_wait = {{"train_stop"},{"train_depeat"}},
			Loop = false,
			{
				505,"Бориспильска",
				arrlast = {nil, {"bor","last"}, "bor"},
				dep = {{"doors_closing", 3, "arr_leningradskaya"}, nil},
			},
			{
				506,"Вирлиця",
				arr = {{"arr1_leningradskaya"},{"arr1_leningradskaya"}},
				dep = {{"doors_closing", 3, "arr_prospekt_mira"}, {"doors_closing", 3, "next_bor",}},
				arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
				not_last = {0.7,"train_goes_to","leningradskaya"}
			},
			{
				507,"Черв. Хутор",
				arrlast = {{"prosp"}, nil, "prosp"},
				dep = {nil, {"doors_closing", 3, "arr_leningradskaya"}}  
			}
		}
	}
)

Metrostroi.AddANSPAnnouncer("ASNP Kyiv RRI",
	{
		announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
		click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
        click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
		bezp = {"5m_sbl/bezpechno.mp3", 5}, 
        

		last = {"kyiv_announce/special/last2.mp3", 6.180},
		doors_closing = {"kyiv_announce/rri/d.mp3", 3.5},
		
        arr_leningradskaya = {"kyiv_announce/rri/3d.mp3", 11.6},
        arr1_leningradskaya = {"kyiv_announce/rri/4.mp3", 6.8}, 
		arr_prospekt_mira = {"kyiv_announce/rri/31d.mp3", 12.142},
		next_bor = {"kyiv_announce/rri/1d.mp3", 5.3},
		bor = {"kyiv_announce/rri/2.mp3", 4.9},    
        -- bor = {"5m_sbl/arr_borispilska.mp3", 3.5},
		
		 
		
        --luk.mp3
        prosp = {"kyiv_announce/rri/31.mp3", 15.5},

		arr_seligerskaya = {"kyiv_announce/rri/syrec.wav", 4.829},

	},
	{  
		{ 
			LED = {10,10,10},
			Name = "ПЛЛ",
			spec_last = {"last"},
			spec_wait = {{"train_stop"},{"train_depeat"}},
			Loop = false,
			{
				505,"Бориспильска",
				arrlast = {nil, {"bor","last"}, "bor"},
				dep = {{"doors_closing", 3, "arr_leningradskaya"}, nil},
			},
			{
				506,"Вирлиця",
				arr = {{"arr1_leningradskaya"},{"arr1_leningradskaya"}},
				dep = {{"doors_closing", 3, "arr_prospekt_mira"}, {"doors_closing", 3, "next_bor",}},
				arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
				not_last = {0.7,"train_goes_to","leningradskaya"}
			},
			{
				507,"Черв. Хутор",
				arrlast = {{"prosp"}, nil, "prosp"},
				dep = {nil, {"doors_closing", 3, "arr_leningradskaya"}}  
			}
		}
	}
)
end 
if game.GetMap():find("surface") then 
    Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
		click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
        click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
		bezp = {"5m_sbl/bezpechno.mp3", 5},
        
		
		last = {"5m_sbl/lasteng.mp3", 6.180},
		doors_closing = {"kyiv_announce/d.mp3", 3.5},
		
        next_borysp = {"kyiv_announce/1d.mp3", 5.3},
        borysp_arr = {"kyiv_announce/2.mp3", 4.9}, 
        next_vyr = {"kyiv_announce/3d.mp3", 11.6},
        vyr_arr = {"kyiv_announce/4.mp3", 6.8},
        next_kh = {"kyiv_announce/5d.mp3", 11.8},
		kh_arr = {"kyiv_announce/6.mp3", 11.5},
		next_poz = {"kyiv_announce/21d.mp3", 9.5},
		poz_arr = {"kyiv_announce/22.mp3", 9.5},

        next_luk = {"kyiv_announce/25d.mp3", 10.5},
        luk_arr = {"kyiv_announce/26.mp3", 4.5},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5},
		next_sur = {"kyiv_announce/29d.mp3", 5.829},
		
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},

  

	},
	{
		{ 
			LED = {10,10,10},
			Name = "ПЛЛ",
			spec_last = {"last"},
			spec_wait = {{"train_stop"},{"train_depeat"}},
			Loop = false,
			{
				100,"Хутир",
				arrlast = {{"hut_arr"}, "hut_arr", "hut_arr"},
				dep = {{"doors_closing", 3, "next_borysp"}, nil},
			},
			{
				101,"Бориспильска",
				arr = {{"borysp_arr"},{"borysp_arr"}},
				dep = {{"doors_closing", 3, "next_vyr"}, {"doors_closing", 3, "next_hut",}},
				arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
				not_last = {0.7,"train_goes_to","leningradskaya"}
			},
			{ 
				102,"Вирлиця",
				arr = {{"vyr_arr"}, {"vyr_arr"}},
				dep = {{"doors_closing", 3, "next_kh"}, {"doors_closing", 3, "next_borysp"}}
            },
            {
				103,"Харькивська",
				arr = {{"kh_arr"}, {"kh_arr"}}, 
				dep = {{"doors_closing", 3, "next_luk"}, {"doors_closing", 3, "next_vyr"}}
            }, 
            {
				104,"Лукяновская",
				arr = {{"luk_arr"}, {"luk_arr"}},
				dep = {{"doors_closing", 3, "next_dor"}, {"doors_closing", 3, "next_kh"}}
            },
            {
				105,"Дорогожичи",
				arr = {{"door_arr"}, {"door_arr"} },
				dep = {{"doors_closing", 3, "next_sur"}, {"doors_closing", 3, "next_luk"}}
            },
            {
				106,"Сирец",
				arrlast = {{"sur_arr"}, nil, "sur_arr"},
				dep = {nil, {"doors_closing", 3, "next_dor"}} 
			}
		}
	}
)
Metrostroi.AddANSPAnnouncer("ASNP RRI KYIV",
{
	announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
	click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
	click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
	bezp = {"5m_sbl/bezpechno.mp3", 5},
	
	
	last = {"5m_sbl/lasteng.mp3", 6.180},
	doors_closing = {"kyiv_announce/rri/d.mp3", 3.5},
	
	next_borysp = {"kyiv_announce/rri/1d.mp3", 5.3},
	borysp_arr = {"kyiv_announce/rri/2.mp3", 4.9}, 
	next_vyr = {"kyiv_announce/rri/3d.mp3", 11.6},
	vyr_arr = {"kyiv_announce/rri/4.mp3", 6.8},
	next_kh = {"kyiv_announce/rri/5d.mp3", 11.8},
	kh_arr = {"kyiv_announce/rri/6.mp3", 11.5},
	next_poz = {"kyiv_announce/rri/21d.mp3", 9.5},
	poz_arr = {"kyiv_announce/rri/22.mp3", 9.5},

	next_luk = {"kyiv_announce/rri/13d.mp3", 8.7},
	luk_arr = {"kyiv_announce/rri/14.mp3", 12.5},
	next_dor = {"kyiv_announce/rri/27d.mp3", 5.5},
	door_arr = {"kyiv_announce/rri/28.mp3", 4.5},
	next_sur = {"kyiv_announce/rri/29d.mp3", 5.829},
	
	sur_arr = {"kyiv_announce/rri/30.mp3", 14.829},
	hut_arr = {"kyiv_announce/rri/31.mp3", 15.829},
	next_hut = {"kyiv_announce/rri/31d.mp3", 9.829},

 

},
{
	{ 
		LED = {10,10,10},
		Name = "ПЛЛ",
		spec_last = {"last"},
		spec_wait = {{"train_stop"},{"train_depeat"}},
		Loop = false,
		{
			100,"Хутир",
			arrlast = {{"hut_arr"}, "hut_arr", "hut_arr"},
			dep = {{"doors_closing", 3, "next_borysp"}, nil},
		},
		{
			101,"Бориспильска",
			arr = {{"borysp_arr"},{"borysp_arr"}},
			dep = {{"doors_closing", 3, "next_vyr"}, {"doors_closing", 3, "next_hut",}},
			arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
			not_last = {0.7,"train_goes_to","leningradskaya"}
		},
		{ 
			102,"Вирлиця",
			arr = {{"vyr_arr"}, {"vyr_arr"}},
			dep = {{"doors_closing", 3, "next_kh"}, {"doors_closing", 3, "next_borysp"}}
		},
		{
			103,"Харькивська",
			arr = {{"kh_arr"}, {"kh_arr"}}, 
			dep = {{"doors_closing", 3, "next_luk"}, {"doors_closing", 3, "next_vyr"}}
		}, 
		{
			104,"Лукяновская",
			arr = {{"luk_arr"}, {"luk_arr"}},
			dep = {{"doors_closing", 3, "next_dor"}, {"doors_closing", 3, "next_kh"}}
		},
		{
			105,"Дорогожичи",
			arr = {{"door_arr"}, {"door_arr"} },
			dep = {{"doors_closing", 3, "next_sur"}, {"doors_closing", 3, "next_luk"}}
		},
		{
			106,"Сирец",
			arrlast = {{"sur_arr"}, nil, "sur_arr"},
			dep = {nil, {"doors_closing", 3, "next_dor"}} 
		}
	}
}
)
end     
if SERVER then
util.AddNetworkString("CabinDoor")
end 
if game.GetMap():find("virus") then 
    Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		doors_closing = {"kyiv_announce/d.mp3", 3.5},
		next_borysp = {"kyiv_announce/1d.mp3", 5.3},
        borysp_arr = {"kyiv_announce/2.mp3", 4.9}, 
        next_vyr = {"kyiv_announce/3d.mp3", 11.6},
        vyr_arr = {"kyiv_announce/4.mp3", 6.8},
        next_kh = {"kyiv_announce/5d.mp3", 11.8},
        kh_arr = {"kyiv_announce/6.mp3", 11.5},
        next_luk = {"kyiv_announce/25d.mp3", 10.5},
        luk_arr = {"kyiv_announce/26.mp3", 4.5},
		next_dor = {"kyiv_announce/27d.mp3", 5.5},
		door_arr = {"kyiv_announce/28.mp3", 4.5},
		next_sur = {"kyiv_announce/29d.mp3", 5.829},
		
		sur_arr = {"kyiv_announce/30.mp3", 14.829},
		hut_arr = {"kyiv_announce/31.mp3", 15.829},
		next_hut = {"kyiv_announce/31d.mp3", 9.829},
},
	{
		{
			LED = {5, 5, 5, 5, 5, 5},
			Name = "Первая линия",
			spec_last = {"spec_attention_train_fast"},
			spec_wait = {{"spec_attention_train_stop"},{"spec_attention_train_depart"}},
			Loop = false,
			{
				900, "Пр. Независимости",
				arrlast = {nil, "sur_arr", "sur_arr"},
				dep = {{"doors_closing", 3, "next_dor"}, nil},
			},
			{
				901, "Хорошавино",
                arr = {{"door_arr"},{"door_arr"}},
                dep = {{"doors_closing", 3, "next_luk"},{"doors_closing", 3, "next_sur"}},
			},
			{
				902, "Савёловская",
                arr = {{"luk_arr"},{"luk_arr"}},
                dep = {{"doors_closing", 3, "next_kh"},{"doors_closing", 3, "next_dor"}},
			},
			{
				903, "Аллея Космонавтов",
                arr = {{"kh_arr"},{"kh_arr"}},
				dep = {{"doors_closing", 3, "next_vyr"},{"doors_closing", 3, "next_luk"}},
				arrlast = {{"prib", "kosmonavtov", "last_neid", "spec_attention_objects", "last_zakon"}, {"prib", "kosmonavtov", "last_neid", "spec_attention_objects", "last_zakon"}, "kosmonavtov"},
			    not_last = {0.5, "train_goes_to", "kosmonavtov"},
			},
			{
				904, "Южная",
                arr = {{"vyr_arr"},{"vyr_arr"}},
				arrlast = {{"prib", "yuzhnaya", "last_neid", "spec_attention_objects", "last_zakon"}, nil, "yuzhnaya"},
				dep = {{"doors_closing", 3, "next_hut"},{"doors_closing", 3, "next_kh"}},
			    not_last = {0.5, "train_goes_to", "yuzhnaya"},
			},
			{
				905, "Зябликово",
				arrlast = {{"hut_arr"}, nil, "hut_arr"},
				dep = {nil, {"doors_closing", 3, "next_vyr"}}
			}
		}
	}
)

end 
if game.GetMap():find("c4") or game.GetMap():find("n3") then  
	Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
		click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
        click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
		bezp = {"5m_sbl/bezpechno.mp3", 5},
        
		
		last = {"kyiv_announce/last.wav", 14.180},
		doors_closing = {"kyiv_announce/d.mp3", 4.2},
		
        arr_leningradskaya = {"5m_sbl/doroh.mp3", 3.9},
        arr1_leningradskaya = {"5m_sbl/doroharr.mp3", 3.9}, 
		arr_prospekt_mira = {"5m_sbl/arr_lukyanovska.mp3", 4.142},
        luk = {"5m_sbl/nextluk.mp3", 8.142},
		
        g_to = {"kyiv_announce/23d.mp3", 9.3},
        g_arr = {"kyiv_announce/24.mp3", 12.3}, 
        p_to = {"kyiv_announce/21d.mp3", 9.3},
        p_arr = {"kyiv_announce/22.mp3", 13.3},
        k_to = {"kyiv_announce/31d.mp3", 9.5}, 
		k_arr = {"kyiv_announce/31.mp3", 15.5},
		to_kl = {"kyiv_announce/19d.mp3", 4.5}, 
		arr_kl = {"kyiv_announce/20.mp3", 3.3},  
		to_ph = {"kyiv_announce/17d.mp3", 7.6}, 
		arr_ph = {"kyiv_announce/18.mp3", 3.15},
		to_kh = {"kyiv_announce/5d.mp3", 5.1},
		arr_kh = {"kyiv_announce/6.mp3", 10.1},   
		to_vr = {"kyiv_announce/3d.mp3", 11.3},  
		arr_vr = {"kyiv_announce/4.mp3", 6},
		to_khu = {"kyiv_announce/31d.mp3", 10},
		arr_khu = {"kyiv_announce/31.mp3", 15.5 },

        --luk.mp3
        prosp = {"5m_sbl/luk.mp3", 3.142},

		arr_seligerskaya = {"kyiv_announce/syrec.wav", 4.829},

	},
	{
		{ 
			LED = {10,10,10},
			Name = "ПЛЛ",
			spec_last = {"last"},
			spec_wait = {{"train_stop"},{"train_depeat"}},
			Loop = false,
			{
				110,"Лукяновская",
				arrlast = {nil, {"arr_prospekt_mira","last"}, "seligerskaya"},
				dep = {{"doors_closing", 3, "g_to"}, nil},
			},
			{
				111,"Золотi Ворота",
				arr = {{"g_arr"},{"g_arr"}},
				dep = {{"doors_closing", 3, "p_to"}, {"doors_closing", 3, "luk",}},
				arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
				not_last = {0.7,"train_goes_to","leningradskaya"}
			},
			{ 
				112,"Палац Спорту",
				arr = {{"p_arr"}, {"p_arr"}},
				dep = {{"doors_closing", 3, "to_kl"}, {"doors_closing", 3, "g_to", "bezp"}}
            },
            {
				113,"Кловська",
				arr = {{"arr_kl"}, {"arr_kl"}}, 
				dep = {{"doors_closing", 3, "to_ph"}, {"doors_closing", 3, "p_to"}}
            }, 
            {
				114,"Печерська",
				arr = {{"arr_ph"}, {"arr_ph"}},
				dep = {{"doors_closing", 3, "to_kh"}, {"doors_closing", 3, "to_kl"}}
			},
			{
				115,"Харькiвська",
				arr = {{"arr_kh"}, {"arr_kh"}},
				dep = {{"doors_closing", 3, "to_vr"}, {"doors_closing", 3, "to_ph"}}
			},
			{
				116,"Вирлиця",
				arr = {{"arr_vr"}, {"arr_vr"}},
				dep = {{"doors_closing", 3, "to_khu"}, {"doors_closing", 3, "to_kh"}}
            },
            {
				117,"Червоний Хутiр",
				arr = {{"arr_khu"}, {"arr_khu"} },
				dep = {nil, {"doors_closing", 3, "to_vr", "bezp"}}
            },
		}
	}
)
Metrostroi.AddANSPAnnouncer("ASNP Kyiv RRI",
{
	announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
	click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
	click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
	bezp = {"5m_sbl/bezpechno.mp3", 5},
	
	
	last = {"kyiv_announce/last.wav", 14.180},
	doors_closing = {"kyiv_announce/rri/d.mp3", 4.2},
	
	arr_leningradskaya = {"5m_sbl/doroh.mp3", 3.9},
	arr1_leningradskaya = {"5m_sbl/doroharr.mp3", 3.9}, 
	arr_prospekt_mira = {"5m_sbl/arr_lukyanovska.mp3", 4.142},
	luk = {"5m_sbl/nextluk.mp3", 8.142},
	
	g_to = {"kyiv_announce/rri/23d.mp3", 9.3},
	g_arr = {"kyiv_announce/rri/24.mp3", 12.3}, 
	p_to = {"kyiv_announce/rri/21d.mp3", 9.3},
	p_arr = {"kyiv_announce/rri/22.mp3", 13.3},
	k_to = {"kyiv_announce/rri/31d.mp3", 9.5}, 
	k_arr = {"kyiv_announce/rri/31.mp3", 15.5},
	to_kl = {"kyiv_announce/rri/19d.mp3", 4.5}, 
	arr_kl = {"kyiv_announce/rri/20.mp3", 3.3},  
	to_ph = {"kyiv_announce/rri/17d.mp3", 7.6}, 
	arr_ph = {"kyiv_announce/rri/18.mp3", 3.15},
	to_kh = {"kyiv_announce/rri/5d.mp3", 5.1},
	arr_kh = {"kyiv_announce/rri/6.mp3", 10.1},   
	to_vr = {"kyiv_announce/rri/3d.mp3", 11.3},  
	arr_vr = {"kyiv_announce/rri/4.mp3", 6},
	to_khu = {"kyiv_announce/rri/31d.mp3", 10},
	arr_khu = {"kyiv_announce/rri/31.mp3", 15.5 },

	--luk.mp3
	prosp = {"5m_sbl/luk.mp3", 3.142},

	arr_seligerskaya = {"kyiv_announce/syrec.wav", 4.829},   

},
{
	{ 
		LED = {10,10,10},
		Name = "ПЛЛ",
		spec_last = {"last"},
		spec_wait = {{"train_stop"},{"train_depeat"}},
		Loop = false,
		{
			110,"Лукяновская",
			arrlast = {nil, {"arr_prospekt_mira","last"}, "seligerskaya"},
			dep = {{"doors_closing", 3, "g_to"}, nil},
		},
		{
			111,"Золотi Ворота",
			arr = {{"g_arr"},{"g_arr"}},
			dep = {{"doors_closing", 3, "p_to"}, {"doors_closing", 3, "luk",}},
			arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
			not_last = {0.7,"train_goes_to","leningradskaya"}
		},
		{ 
			112,"Палац Спорту",
			arr = {{"p_arr"}, {"p_arr"}},
			dep = {{"doors_closing", 3, "to_kl"}, {"doors_closing", 3, "g_to", "bezp"}}
		},
		{
			113,"Кловська",
			arr = {{"arr_kl"}, {"arr_kl"}}, 
			dep = {{"doors_closing", 3, "to_ph"}, {"doors_closing", 3, "p_to"}}
		}, 
		{
			114,"Печерська",
			arr = {{"arr_ph"}, {"arr_ph"}},
			dep = {{"doors_closing", 3, "to_kh"}, {"doors_closing", 3, "to_kl"}}
		},
		{
			115,"Харькiвська",
			arr = {{"arr_kh"}, {"arr_kh"}},
			dep = {{"doors_closing", 3, "to_vr"}, {"doors_closing", 3, "to_ph"}}
		},
		{
			116,"Вирлиця",
			arr = {{"arr_vr"}, {"arr_vr"}},
			dep = {{"doors_closing", 3, "to_khu"}, {"doors_closing", 3, "to_kh"}}
		},
		{
			117,"Червоний Хутiр",
			arr = {{"arr_khu"}, {"arr_khu"} },
			dep = {nil, {"doors_closing", 3, "to_vr", "bezp"}}
		},
	}
}
)
end 
if game.GetMap():find("dnipro") then 
	
	Metrostroi.AddANSPAnnouncer("ASNP Kyiv",
	{
		announcer_ready = {"subway_announcers/belkin/announcer_ready.mp3", 3.030},
		click1 = {"subway_announcers/belkin/click3.mp3", 0.480},
        click2 = {"subway_announcers/belkin/click4.mp3", 0.384},
		bezp = {"5m_sbl/bezpechno.mp3", 5},
        
		
		last = {"kyiv_announce/last.wav", 14.180},
		doors_closing = {"5m_sbl/odznew.mp3", 3},
		
        arr_leningradskaya = {"5m_sbl/doroh.mp3", 3.9},
        arr1_leningradskaya = {"5m_sbl/doroharr.mp3", 3.9}, 
        arr_prospekt_mira = {"5m_sbl/nextluk.mp3", 8.142},
        g_to = {"5m_sbl/nextgold.mp3", 7.8}, 
        g_arr = {"5m_sbl/gold.mp3", 11.8},  
        p_to = {"5m_sbl/next_palac.mp3", 7.5},
        p_arr = {"5m_sbl/palac.mp3", 10.5},
        k_to = {"5m_sbl/next_khutir.mp3", 9.5},
        k_arr = {"5m_sbl/khutir_arr.mp3", 15.5},
        prosp = {"5m_sbl/luk.mp3", 3.142},
		arr_seligerskaya = {"kyiv_announce/syrec.wav", 4.829},

	},
	{ 
		{ 
			LED = {10,10,10},
			Name = "ПЛЛ",
			spec_last = {"last"},
			spec_wait = {{"train_stop"},{"train_depeat"}},
			Loop = false,
			{
				100,"Сирець",
				arrlast = {nil, {"arr_seligerskaya","last"}, "seligerskaya"},
				dep = {{"doors_closing", 3, "arr_leningradskaya", "bezp"}, nil},
			},
			{
				101,"Дорогожичi",
				arr = {{"arr1_leningradskaya"},{"arr1_leningradskaya"}},
				dep = {{"doors_closing", 3, "arr_prospekt_mira"}, {"doors_closing", 3, "seligerskaya",}},
				arrlast = {{"arr_leningradskaya", 0.5, "last"}, {"arr_leningradskaya", 0.5, "last", 0.5, "deadlock"}, "leningradskaya"},
				not_last = {0.7,"train_goes_to","leningradskaya"}    
			},
			{
				102,"Лукянiвська",
				arr = {{"prosp"}, {"prosp"}},
				dep = {{"doors_closing", 3, "g_to"}, {"doors_closing", 3, "arr_leningradskaya", "bezp"}}
            },
            {
				103,"Золотi Ворота",
				arr = {{"g_arr"}, {"g_arr"}}, 
				dep = {{"doors_closing", 3, "p_to"}, {"doors_closing", 3, "arr_prospekt_mira", "bezp"}}
            }, 
            {
				104,"Палац Спорту",
				arr = {{"p_arr"}, {"p_arr"}},
				dep = {{"doors_closing", 3, "k_to"}, {"doors_closing", 3, "g_to", "bezp"}}
            },
            {
				105,"Червоний Хутiр",
				arr = {{"k_arr"}, {"prosp"} },
				dep = {nil, {"doors_closing", 3, "p_to", "bezp"}}
            },
		}
	}
)
end  