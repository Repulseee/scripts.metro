 --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- All the models, materials, sounds belong to their corresponding authors. Permission is granted to only distribute these models through Garry's Mod Steam Workshop and the official Metrostroi GitHub accounts for use with Garry's Mod and Metrostroi Subway Simulator.
--
-- It is forbidden to use any of these models, materials, sounds and other content for any commercial purposes without an explicit permission from the authors. It is forbidden to make any changes in these files in any derivative projects without an explicit permission from the author.
--
-- The following models are (C) 2015-2018 oldy (Aleksandr Kravchenko). All rights reserved.
-- models\metrostroi_train\81-502:
-- - 81-502  (Ema-502 head)
-- - 81-501  (Em-501 intermediate)dsawq
-- models\metrostroi_train\81-702:
-- - 81-702  (D head)
-- - 81-702  (D intermediate)
-- models\metrostroi_train\81-703:
-- - 81-703  (E head)
-- - 81-508  (E intermediate)
-- models\metrostroi_train\81-707:
-- - 81-707  (Ezh head)
-- - 81-708  (Ezh1 intermediate)
-- models\metrostroi_train\81-710:
-- - 81-710  (Ezh3 head)
-- - 81-508T (Em-508T intermediate)
-- models\metrostroi_train\81-717:
-- - 81-717  (Moscow head)
-- - 81-714  (Moscow intermediate)
-- - 81-717  (St. Petersburg head)
-- - 81-714  (St. Petersburg intermediate)
-- models\metrostroi_train\81-718:
-- - 81-718  (TISU head)
-- - 81-719  (TISU intermediate)
-- models\metrostroi_train\81-720: 
-- - 81-720  (Yauza head)
-- - 81-721  (Yauza intermediate)
-- - 81-722  (Yubileyniy head)
-- models\metrostroi_train\81-722:
-- - 81-723  (Yubileyniy intermediate motor) 
-- - 81-724  (Yubileyniy intermediate trailer)

--------------------------------------------------------------------------------
include("shared.lua")

--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.ClientSounds = {} 
for i = 0,11 do
    ENT.ClientProps["lamp1_"..i+1] = {
        model = "models/metrostroi_train/81-717/lamps/lamp_typ1.mdl",
        pos = Vector(333.949 - 66.66*i,0,67.7),
        ang = Angle(0,0,0),
        color = Color(255,255,255),
        hideseat = 1.1,
    }
end
matproxy.Add{
    name = "announcer_light",
    init = function( self, mat, values )
        -- Store the name of the variable we want to set
        if values then self._MATresultVarC = values.resultvar end
    end,
    bind = function( self, mat, ent )
        if ( self._MATresultVarC and ent.announcer_light ) then
            mat:SetFloat( self._MATresultVarC, ent.announcer_light )
        end
    end
}
ENT.ClientProps["kapli"] = {
    model = "models/metrostroi_train/81-7175k/kapli_glass.mdl",
    pos = Vector(462,0,17.5),
    ang = Angle(0,0,0),
    hide=2,
    scale=0.97,
}
ENT.ClientProps["kapli_cab"] = {
    model = "models/metrostroi_train/81-7175k/kapli_glass_cab.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    scale=1,
}
ENT.ClientProps["kapli_left"] = {
    model = "models/metrostroi_train/81-7175k/kapli_glass_left.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    scale=1,
}
ENT.ClientProps["kapli_right"] = {
    model = "models/metrostroi_train/81-7175k/kapli_glass_right.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255,0),
    hide=2,
    scale=1,
}
ENT.ClientProps["trafaret"] = {
	model = "models/metrostroi_train/81-717/heroiv_dnipra.mdl",
	pos = Vector(458.709991,0.000000,-3.600000),
    ang = Angle(-92.000000,-180.100006,0.000000),
    scale=5.5,
    nohide=true,
}
ENT.ClientProps["pamyatki"] = {
	model = "models/metrostroi_train/81-717/kyiv_helpers_717.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["shedule"] = {
	model = "models/metrostroi_custom/81-717/pult/schedule_clamp.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    scale=5,
}
ENT.ClientProps["reklama"] = {
	model = "models/metrostroi_train/81-717/reklama.mdl",
	pos = Vector(161,-60.8,25),
    ang = Angle(0,180,0),
    scale=1,
}
ENT.ClientProps["reklama2"] = {
	model = "models/metrostroi_train/81-717/reklama2.mdl",
	pos = Vector(-24,60.8,25),
    ang = Angle(0,180,0),
    scale=1,
}
ENT.ClientProps["em_com"] = {  -- ЕКСТРЕНИЙ ЗВ'ЯЗОК З МАШИНІСТОМ
	model = "models/metrostroi_train/81-717/em_com.mdl",
	pos = Vector(55,58,17),
    ang = Angle(0,90,0),
    scale=1,
}
ENT.ClientProps["visor_1"] = {
	model = "models/metrostroi_custom/81-717/kiev/visor.mdl",
	pos = Vector(454.865, 25.844,49.149),
    ang = Angle(0,180,0),
    scale=1,
}
ENT.ClientProps["visor_2"] = {
	model = "models/metrostroi_custom/81-717/kiev/visor.mdl",
	pos = Vector(454.865,-25.844,49.149),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["mesta"] = {
	model = "models/metrostroi_train/81-717/kyiv_priority_places_label.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,90,0),
    scale=1,
}
ENT.ClientProps["handrail"] = {
	model = "models/metrostroi_train/81-717/handrails_717.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    scale=1,
}
ENT.ClientProps["trafaret_2"] = {
	model = "models/metrostroi_train/81-717/teremky.mdl",
	pos = Vector(458.709991,0.000000,-3.600000),
    ang = Angle(-92.000000,-180.100006,0.000000),
    scale=5.5,
    nohide=true,
}
ENT.ClientProps["trafaret_3"] = {
	model = "models/metrostroi_train/81-717/lybidska.mdl",
	pos = Vector(458.709991,0.000000,-3.600000),
    ang = Angle(-92.000000,-180.100006,0.000000),
    scale=5.5,
    nohide=true,
}
ENT.ClientProps["trafaret_4"] = {
	model = "models/metrostroi_train/81-717/lybidska.mdl",
	pos = Vector(458.709991,0.000000,-3.600000),
    ang = Angle(-92.000000,-180.100006,0.000000),
    scale=5.5,
    nohide=true,
}
ENT.ClientProps["cab_labels"] = {
	model = "models/metrostroi_train/81-717/labels_kkl.mdl",
	pos = Vector(409.92,-27,15),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["m2new"] = {
    model = "models/metrostroi_train/81-717/m2new.mdl",
    pos = Vector(338,59.8,54),
    ang = Angle(0,180,0),
    nohide=true,
}
ENT.ClientProps["m2new_r"] = {
    model = "models/metrostroi_train/81-717/m2new.mdl",
    pos = Vector(338,-60.5,54),
    ang = Angle(0,180,0),
    nohide=true,
}
ENT.ClientProps["kyiv_map"] = {
    model = "models/metrostroi_train/81-717/map.mdl",
    pos = Vector(285,-61,23),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["kyiv_map2"] = {
    model = "models/metrostroi_train/81-717/map.mdl",
    pos = Vector(-298,60.8,23),
    ang = Angle(0,180,0),
    nohide=true,
}
ENT.ClientProps["kkl_motorolla"] = {
	model = "models/metrostroi_train/81-717/kkl_motorola.mdl",
	pos = Vector(0,0,0.4),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ButtonMap["schedule"] = {
    pos = Vector(451.15,9.6,8.6),
    ang = Angle(0,-90,90-32),
    width = 60,
    height = 100,
    scale = 0.085,
    buttons = {
    {ID = "ScheduleSet",x=0,y=0,w=60,h=50, tooltip="Установить/снять расписание"},
    {ID = "ScheduleReverse",x=0,y=50,w=60,h=50, tooltip="Перевернуть расписание"},
    }
}
ENT.ClientProps["schedule"] = {
	model = "models/metrostroi_train/schedule/schedule_717.mdl",
	pos = Vector(0.05,0,0),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["clamp2"] = {
	model = "models/metrostroi_train/81-717/pult/schedule_skrep2.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["radiokkl"] = {
	model = "models/metrostroi_train/81-717/radio_kkl.mdl",
	pos = Vector(440.7,29.5,-6.45),
    ang = Angle(0,0,0),
    scale=0, 
}
ENT.ClientProps["cab_labels"] = {
	model = "models/metrostroi_train/81-717/lamps_kkl_new.mdl",
	pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    scale=1,
}
ENT.ClientProps["door2_lock"] = {
    model = "models/metrostroi_custom/81-717/door_cabine_lock.mdl",
    pos = Vector(377.322,26.267,-1.599),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["ohrana"] = {
    model = "models/metrostroi_train/81-717/ohrana_ukr.mdl",
    pos = Vector(410.000000,-52.419353,33.158),
    ang = Angle(180.100006,90.580002,90.029999),
    scale=1,
}

ENT.ClientProps["BigLamp_2_Motorolla"] = {
    model = "models/metrostroi_train/81-717/kkl_motorolla_lamp.mdl",
    pos = Vector(0,0,0.4),
    ang = Angle(0,0,0),
    scale=1,
    color=Color(255, 255, 0),
}

ENT.ClientProps["BigLamp_3_Motorolla"] = {
    model = "models/metrostroi_train/81-717/kkl_motorolla_lamp.mdl",
    pos = Vector(0,0,-0.42),
    ang = Angle(0,0,0),
    scale=1,
    color=Color(0, 255, 0),
}
ENT.ClientProps["BigLamp_1_Motorolla"] = {
    model = "models/metrostroi_train/81-717/kkl_motorolla_lampred.mdl",
    pos = Vector(0,0,0.4),
    ang = Angle(0,0,0),
    scale=1,
    color=Color(255, 0, 0),
}
ENT.ButtonMap["Motorolla"] = {
    pos = Vector(414.709991,-23.400000,9.600000),
    ang = Angle(-180.100006,0.580002,-90.029999),
    width = 100,
    height = 105,
    scale = 0.0625,
    hideseat = 0.2,
    buttons = {
        {ID = "!LampMotorolla1",x=42,y=43.2,w=10,h=4,tooltip="",model = {
            name="Motorolla1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-11.2,ang=0,var="Motorolla_Channel2"}, 
        }},
        {ID = "!LampMotorolla2",x=41.3,y=29.8,w=10,h=4,tooltip="",model = {
            name="Motorolla2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-11.84,ang=0,var="Motorolla_Channel1"}, 
        }},
        {ID = "!LampMotorolla3",x=41.2,y=59,w=10,h=4,tooltip="",model = {
            name="Motorolla3",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-11.5,ang=0,var="Motorolla_Channel3",scale=1}, 
        }},
        {ID = "!LampMotorolla4",x=42,y=76,w=10,h=4,tooltip="",model = {
            name="Motorolla4",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-13.25,ang=0,var="Motorolla_Channel4",scale=1}, 
        }},
        {ID = "!LampMotorollaR1",x=60,y=35,w=10,h=4,tooltip="",model = {
            name="MotorollaR1",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-13.25,ang=0,var="Motorolla_RChannel1",scale=1}, 
        }},
        {ID = "!LampMotorollaR2",x=60,y=65,w=10,h=4,tooltip="",model = {
            name="MotorollaR2",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",color=Color(255/1.5,0,0),z=-13.5,ang=0,var="Motorolla_RChannel2",scale=1}, 
        }},
        {ID = "Motorolla_C1Set",x=34,y=31,radius=5,tooltip="Радиостанция: 1 канал",model = {
            var="Motorolla_C1",z=-13,
        }},
        {ID = "Motorolla_C2Set",x=34,y=44,radius=5,tooltip="Радиостанция: 2 канал",model = {
            var="Motorolla_C2",z=-13,
        }},
        {ID = "Motorolla_C3Set",x=34,y=60,radius=5,tooltip="Радиостанция: 3 канал",model = {
            var="Motorolla_C3",z=-13,
        }},
        {ID = "Motorolla_C4Set",x=34,y=75,radius=5,tooltip="Радиостанция: 4 канал",model = {
            var="Motorolla_C4",z=-13,
        }},
        {ID = "Motorolla_R1Set",x=55,y=38,radius=5,tooltip="Радиостанция: R1",model = {
            var="Motorolla_R1",z=-13,
        }},
        {ID = "Motorolla_R2Set",x=55,y=62,radius=5,tooltip="Радиостанция: R2",model = {
            var="Motorolla_R2",z=-13,
        }},
        {ID="Motorolla_Voice-",x=46, y=0, w=10,h=10, tooltip="Громкость: -"},
        {ID="Motorolla_Voice+",x=65, y=0, w=10,h=10, tooltip="Громкость: +"},
    }
}
ENT.ButtonMap["bars-m_channels"] = {
    pos = Vector(410.709991,-25.400000,13.600000),
    ang = Angle(180.100006,90.580002,90.029999),
    width = 100,
    height = 100,
    scale = 0.0625,
    hideseat = 0.2,
    buttons = {
        {ID = "BARSLockSwitch",x=33,y=25,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 0,z=-16,
           speed=16,scale=1.2,min=1,max=0.01,
            getfunc = function(ent) return ent:GetPackedRatio("BARSLockSwitch") end, var="BARSLockSwitch",
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID="BARSLockSwitch-",x=23, y=29, w=20,h=30, tooltip="Комплект БАРС: +"},
		{ID="BARSLockSwitch+",x=23, y=0, w=20,h=30, tooltip="Комплект БАРС: -"},
    }
}

ENT.ButtonMap["ohrana_block"] = {
    pos = Vector(414.000000,-49.419353,29.500000),
    ang = Angle(180.100006,90.580002,90.029999),
    width = 100,
    height = 100,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {   ID = "SAB1Toggle",x=10,y=25,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 0,z=-3,
            var="SAB1",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
   
        {ID = "OhraneGood",x=70,y=25,radius=20,tooltip="Охрана хвостовой кабины",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,color=Color(255, 127, 80),z=-2,scale=1.3,
            lamp = {model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",var="VH1",color=Color(255, 140, 0),scale=1.35,z=1}
        }},
        {ID = "!OhraneWork",x=40,y=25,radius=20,tooltip="Лампа питания блока охраны хвостовой кабины",model = {
            model = "models/metrostroi_train/81-717/lamps/ad1622_white.mdl",ignorepanel = true,scale=1.3,z=-5,color=Color(165,15,25),
            lamp = {speed=1000000000000,model = "models/metrostroi_train/81-717/lamps/ad1622_white_emissive.mdl",scale=1.35,z=1,var= "VH2",color=Color(255,25,40)}
        }},
    }
}
ENT.ClientProps["screenspower"] = {
    model = "models/metrostroi_train/81-717/block_monitors.mdl",
    pos = Vector(405,-3,59),
    ang = Angle(0,0,0),
    hide=2,
    scale=5,
}
ENT.ClientProps["repairbook"] = {
    model = "models/metrostroi_train/81-717/kyiv_train_book.mdl",
    pos = Vector(0,0,-0.5),
    ang = Angle(0,0,0),
    hide=2,
    scale=1,
}
ENT.ButtonMap["PredbPanel"] = {
    pos = Vector(415,-46,26),
    ang = Angle(-90,180,0),
    width = 100,
    height = 300,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "Pred1CToggle",x=0,y=27,w=100,h=50,tooltip="П-11 (резервный пуск)",model = {
            var="Pred1C", 
        }},
        {ID = "Pred2CToggle",x=0,y=70,w=100,h=50,tooltip="П-1 (аккумуляторная батарея)",model = {
            var="Pred2C", 
        }},
        {ID = "Pred3CToggle",x=0,y=120,w=100,h=50,tooltip="П-5 (БВ)",model = {
            var="Pred3C", 
        }},
        {ID = "Pred4CToggle",x=0,y=150,w=100,h=50,tooltip="П-6 (Освещение салона)",model = {
            var="Pred4C", 
        }},
        {ID = "Pred5CToggle",x=0,y=200,w=100,h=50,tooltip="Запасной предохранитель ",model = {
            var="Pred5C", 
        }},
        {ID = "Pred6CToggle",x=0,y=242,w=100,h=50,tooltip="Запасной предохранитель",model = {
            var="Pred6C", 
        }},   
    }
}
ENT.ButtonMap["PredPanel"] = {
    pos = Vector(415,-46,32),
    ang = Angle(-90,180,0),
    width = 100,
    height = 300,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "Pred1",x=0,y=27,w=100,h=50,tooltip="П-11 (резервный пуск)",model = {
            var="Pred1", 
        }},
        {ID = "Pred2",x=0,y=70,w=100,h=50,tooltip="П-1 (аккумуляторная батарея)",model = {
            var="Pred2", 
        }},
        {ID = "Pred3",x=0,y=120,w=100,h=50,tooltip="П-5 (БВ)",model = {
            var="Pred3", 
        }},
        {ID = "Pred4",x=0,y=150,w=100,h=50,tooltip="П-6 (Освещение салона)",model = {
            var="Pred4", 
        }},
        {ID = "Pred5",x=0,y=200,w=100,h=50,tooltip="Запасной предохранитель",model = {
            var="Pred5", 
        }},
        {ID = "Pred6",x=0,y=242,w=100,h=50,tooltip="Запасной предохранитель",model = {
            var="Pred6", 
        }},
    }
}
ENT.ClientProps["pred1b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-43,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred2b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-40.3,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred3b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-37.5,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred4b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-35,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred5b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-32.3,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred6b"] = {
    model = "models/metrostroi_train/81-5402/BP15_sg.mdl",
    pos = Vector(412,-30,32.5),
    ang = Angle(-90,180,0),
	hide = 1.5, 
}
ENT.ClientProps["pred1"] = {
	model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-43,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
} 
ENT.ClientProps["pred2"] = {
	model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-40.3,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
} 
ENT.ClientProps["pred3"] = {
    model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-37.5,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
} 
ENT.ClientProps["pred4"] = {
	model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-35,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred5"] = {
    model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-32.3,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["pred6"] = {
    model = "models/metrostroi_train/81-5402/BP15.mdl",
    pos = Vector(410,-30,32),
    ang = Angle(-90,180,0),
	hide = 1.5,
}
ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-717/salon_otl.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["body_additional"] = {
    model = "models/metrostroi_train/81-717/717_body_additional.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
--[[ENT.ClientProps["schemes"] = {
    model = "models/metrostroi_train/81-717/labels/schemes.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
    callback = function(ent)
        ent.PassSchemesDone = false
    end,
}]]
ENT.ButtonMap["LastStation"] = {
    pos = Vector(457.7,-27.4,1.75),
    ang = Angle(0,90,90),
    width = 876,
    height = 205,
    scale = 0.0625,
    buttons = {
        {ID = "LastStation-",x=000,y=0,w=438,h=205, tooltip="Промотать конечную станцию назад"},
        {ID = "LastStation+",x=438,y=0,w=438,h=205, tooltip="Промотать конечную станцию вперед"},
    }
}
ENT.ClientProps["brake_valve_334"] = {
    model = "models/metrostroi_train/81-717/brake_valves/334.mdl",
    pos = Vector(-2.5,0,3),
    ang = Angle(0,0,0),
    hideseat=1,
}
ENT.ClientProps["seats_old"] = {
    model = "models/metrostroi_train/81-717/couch_old_n.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    hide=1.5,
}
ENT.ClientProps["seats_old_cap"] = {
    model = "models/metrostroi_train/81-717/couch_cap_l.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ClientProps["bars-m"] = {
    model = "models/metrostroi_train/81-717/BARS-M.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    nohide=true
}
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-717/underwagon.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,180,0),
    nohide=true
}
ENT.ClientProps["mask141_def"] = {
    model = "models/metrostroi_train/81-717/mask_141.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["mask222_def"] = {
    model = "models/dev4you/fedot/mask_pds222_mvm.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    nohide=true,
}
ENT.ClientProps["mask242_def_g"] = {
    model = "models/metrostroi_train/81-717/mask_242_kiev_glass.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["mask242_def"] = {
    model = "models/metrostroi_train/81-717/mask_242_kiev.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}

ENT.ClientProps["mask22_d"] = {
    model = "models/metrostroi_train/81-717/mask_22_kkl_mvm.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true, 
}
ENT.ClientProps["Headlights222p_1"] = {
    model = "models/dev4you/fedot/headlights_pds222_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    nohide=true,
}
ENT.ClientProps["Headlights222p_2"] = {
    model = "models/dev4you/fedot/headlights_pds222_group2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    nohide=true,
} 
 
ENT.ClientProps["Headlights222_1"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_222_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights222_2"] = {
    model = "models/metrostroi_train/81-717/lamps/headlights_222_group.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}
ENT.ClientProps["Headlights22_1"] = {
    model = "models/metrostroi_train/81-717/22_lights_1.mdl",
    pos = Vector(0.2,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    nohide=true,
}
ENT.ClientProps["Headlights22_2"] = {
    model = "models/metrostroi_train/81-717/22_lights_2.mdl",
    pos = Vector(0.2,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}

ENT.ClientProps["Headlights141_1"] = {
    model = "models/metrostroi_train/81-717/mask_242_kiev_lights_1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    nohide=true,
}
ENT.ClientProps["Headlights141_2"] = {
    model = "models/metrostroi_train/81-717/mask_242_kiev_lights_2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true,
}

ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-717/mask_lights_red1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    nohide=true,
}
ENT.ClientProps["door_otsek1"] = {
    model = "models/metrostroi_train/81-717/door_otsek1.mdl",
    pos = Vector(375.35,-15.324,5.167),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["door_otsek2"] = {
    model = "models/metrostroi_train/81-717/door_otsek2.mdl",
    pos = Vector(375.35,-59.65,5.167),
    ang = Angle(0,-90,0),
    hideseat=1.7,
}
ENT.ClientProps["cap_l"] = {
    model = "models/metrostroi_train/81-717/couch_cap_r.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-717/door_torec.mdl",
    pos = Vector(-476,15.75,-2.7),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["door2"] = {
    model = "models/metrostroi_custom/81-717/door_cabine.mdl",
    pos = Vector(377.322,26.267,-1.599),
    ang = Angle(0,0,0),
    nohide=true,
}

ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-717/door_cabine_kkl.mdl",
    pos = Vector(0,-1,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["cabine_mvm"] = {
    model = "models/metrostroi_extensions/81-717/cabine/cab_AV_717", 
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["cabine_mvm2"] = {
    model = "models/metrostroi_extensions/81-717/cabine/cab_AV_717", 
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["case"] = {
    model = "models/metrostroi_custom/81-717/sid_case.mdl", 
    pos = Vector(0.1,1.35,2),
    ang = Angle(0,-90,0),
    hide=2,
}
ENT.ClientProps["mirror_1"] = {
    model = "models/metrostroi_train/81-717/otl_717_mirror_new1.mdl", 
    pos = Vector(0.5,0.5,-3),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ClientProps["mirror_2"] = {
    model = "models/metrostroi_train/81-717/otl_717_mirror_new2.mdl", 
    pos = Vector(0,0,-3),
    ang = Angle(0,0,0),
    hide=2,
}
ENT.ButtonMap["MirrorScreen1"] = {
    pos = Vector(466.2,74.5,29.14),
    ang = Angle(0,-67,90-2.8),
    width = 128,
    height = 276,
    scale = 0.045,

    hideseat=0.2,
    hide=true,
}
ENT.ButtonMap["MirrorScreen2"] = {
    pos = Vector(469,-68.705,29.15),
    ang = Angle(0,-90 + -23,90-2.8),
    width = 128,
    height = 276,
    scale = 0.045,

    hideseat=0.2,
    hide=true,
} 
ENT.ClientProps["ring_old_kkl"] = {
    model = "models/metrostroi_custom/81-717/717_ring.mdl", 
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    nohide = true,
} 

ENT.ClientProps["cabine_volt"] = {
    model = "models/metrostroi_train/81-717/cabine_kkl_w.mdl", 
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}


ENT.ClientProps["cabine_lvz"] = {
    model = "models/metrostroi_train/81-717/cabine_kkl_2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
} 
ENT.ClientProps["Controller"] = {
    model = "models/metrostroi_train/81-717/grkv_old.mdl",
    pos = Vector(435.84,7.4,-14.928),
    ang = Angle(0,0,0),
    hideseat=0.2,
}

ENT.ClientProps["Controller5"] = {
    model = "models/metrostroi_train/81-5401/5401_grkv.mdl",
    pos = Vector(-18.223,-6.7371,2.4739),
    ang = Angle(0,0,0),
    hideseat=0.8,
}
ENT.ClientProps["kv2"] = {
    model = "models/metrostroi_train/81-717/kv2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,-90,0),
    hideseat=0.8,
}
ENT.ClientProps["body_gray"] = {
    model = "models/metrostroi_train/81-717/pult/body_classic.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hide=2.5,
}
ENT.ClientProps["body_new"] = {
    model = "models/metrostroi_custom/81-717/pult/body_kkl_new.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hide=2.5,
}
ENT.ClientProps["pult_nakl"] = {
    model = "models/metrostroi_custom/81-717/pult/717_kiev_pult_stickers.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hide=2.5,
}
local informs = {"models/metrostroi_custom/81-717/pult/announcer_otl_1.mdl","models/metrostroi_custom/81-717/pult/announcer_otl_2.mdl","models/metrostroi_custom/81-717/pult/announcer_otl_white.mdl"}
ENT.ClientProps["pult_mvm_classic"] = {
    model = informs[1], 
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
    skin=5,
    scale = 1,
}
ENT.ClientProps["pult_mvm_classicw"] = {
    model = informs[2], 
    pos = Vector(-0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
    scale = 1,
}
ENT.ClientProps["pult_mvm_classicwd"] = {
    model = informs[3], 
    pos = Vector(-0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
    scale = 1,
}

ENT.ClientProps["pult_mvm_classic2"] = {
    model = "models/metrostroi_train/81-717_kkl/pult/pult_var_2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
}
ENT.ClientProps["pult_mvm_classic22"] = {
    model = "models/metrostroi_train/81-717_kkl/pult/pult_var_2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    color = Color(255,255,255),
    hideseat=0.8,
    scale = 1,

}

ENT.ClientProps["ars_mvm"] = {
    model = "models/metrostroi_train/81-717/pult/ars_flars.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=0.8,
}

ENT.ButtonMap["Block5_6"] = {
    pos = Vector(455.0-6,12.3,2.5-10.5+5.35),--446 -- 14 -- -0,5
    ang = Angle(0,-90,44),
    width = 480,
    height = 225,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "R_UNchToggle",x=44+25.5*0,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_UNch",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {   ID = "R_VPRToggle",x=44+25.5*1,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_VPR",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "R_ZSToggle",x=44+25.5*2,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_ZS",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-270,x=-0,y=-22,var="R_ZSPl",ID="R_ZSPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
      
        {   ID = "R_ASNPOnToggle",x=44+25.5*3,y=40,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="R_ASNPOn",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!R_ProgramToggle",x=159,y=45,radius=0,model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",ang = 90,z=-3,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
            var="R_Program1",speed=16,vmin=1,vmax=0,
        }},
        {ID = "R_Program1Set",x=159-20,y=40-10,w=20,h=20,tooltip="",model = {
            var="R_Program1",sndid = "!R_ProgramToggle",
            sndvol = 0.5,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
      

        --{ID = "1:KVTSet",x=247,y=33,radius=20,tooltip=""},
        {   ID = "1:KVTRSet",x=293,y=36,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVTR",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {   ID = "1:KVTSet",x=263-(263-234)/2,y=36,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {   ID = "2:KVTRSet",x=293,y=36,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVTR",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {   ID = "2:KVTSet",x=263-(263-234)/2--[[240]],y=36,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -3,
            var="KVT",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
       
        {ID = "VZ1Set",x=372.5,y=36,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="VZ1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {   ID = "VNToggle",x=333,y=42,radius=20,tooltip="ВН",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-3,
            var="VN",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90,x=0,y=-15,z=2,var="VNPl",ID="VNPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},



        --{ID = "AutodriveToggle",x=420,y=92,radius=20,tooltip=""},

        {ID = "VUD1Toggle",x=60,y=103,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudblack.mdl",z=-20,
            var="VUD1",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLSet",x=60,y=170,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_2.mdl",
            var="KDL",speed=16,min=1,max=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,255,255)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLKToggle",x=40,y=180,w=40,h=20,tooltip="",model = {
            var="KDLK",speed=8,min=0.32,max=0.68,disable="KDLSet",
            model = "models/metrostroi_train/81-5402/torc_krish.mdl",ang = 0,z = -3,
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLRSet",x=155,y=170,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="KDLR",speed=16,min=1,max=0,z=-2,
            -- lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsLeftL",speed=9,z=2.2,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDLRKToggle",x=135,y=180,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81-5402/torc_krish.mdl",ang = 0,z = -3,
            var="KDLRK",speed=8,min=0.32,max=0.68,disable="KDLRSet",
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "DoorSelectToggle",x=107,y=183,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 0,z=-6,
            var="DoorSelect",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KRZDSet",x=155,y=85,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",z = -3,
            var="KRZD",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "ReverserOT",x=200,y=110,radius=20,tooltip="Положить реверсивную рукоятку",model = {
            var="ReverserOT",
        }},
        {ID = "OtklAVUToggle",x=107,y=85,radius=20,tooltip="ПВУ",model = { 
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-6,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=1,y=22,z=2,var="OtklAVUPl",ID="OtklAVUPl",},
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VozvratRPSet",x=107,y=132,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",z = -3,
            var="VozvratRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},

        {ID = "!GreenRPLight",x=155,y=132,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -3,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=2,x=-0.3,y=-0.3,z=20.6,var="GreenRP",color=Color(100,255,100)}
        }},
       
        {ID = "!preobrazovatle",x=333,y=98,radius=20,tooltip="Защита блока питания",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",skin = 1,z = -3,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6,var="RZP",color=Color(255,60,40)},
        }},
        {ID = "!LKVPLight",x=377,y=98,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",ignorepanel = true,skin = 3,z = -3,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=25,x=-0.3,y=-0.3,z=21.3,var="LKVP",color=Color(255,170,110),scale=1},
        }},
        {ID = "LKVPLightB",x=377,y=98,radius=20,tooltip="ЛКВП: Лампа контроля включения преобразователя",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="LKVP",scale=0.4,x=0,z=18.6,color=Color(255,170,110)},
        }},
        {ID = "Preobr",x=333,y=98,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="RZP",scale=0.4,x=0,z=18.9,color=Color(255,60,40)},
        }},
        {ID = "rpbl",x=155,y=132,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="GreenRP",scale=0.4,x=0,z=18.9,color=Color(100,255,100)},
        }},
        {ID = "!SPLight",x=412,y=42,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",ignorepanel = true,skin = 1,z = -3,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=63,x=-0.3,y=-0.3,z=20.6,var="LSP",color=Color(100,255,50)},
        }},

        
        --{ID = "KAHPl",x=37,y=68,radius=20,tooltip=""},
        

        {   ID = "V11Toggle",x=357,y=70,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="V11",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "V12Toggle",x=400,y=70,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="V12",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {   ID = "V13Toggle",x=438,y=42,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-3,
            var="V13",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RPU2Set",x=325,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",
            var="RPU2",speed=16,min=1,max=0,z=-4,
        --    lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_2.mdl",anim=true,var="RZP",speed=9,z=2.2},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KSNSet",x=373,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",z = -3,
            var="KSN",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "RingSet",x=420,y=133,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_metal.mdl",z = -3,
            var="Ring",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    

        {ID = "ALSToggleSwitch",x=263,y=134,radius=0,tooltip="АЛС: Автоматическая локомотивная сигнализация",model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",scale=1,z=-6,ang=0,
			getfunc = function(ent) return ent:GetPackedRatio("ALSToggleSwitch") end, var="ALSToggleSwitch",
			speed=16,min=1,max=0.1,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(0,180,0),
        }},
        {ID="ALSToggleSwitch+",x=255, y=100, w=20,h=30, tooltip="АЛС: +"},
		{ID="ALSToggleSwitch-",x=255, y=140, w=20,h=30, tooltip="АЛС: -"},
    
        {ID = "ARSRToggle",x=293,y=134,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t2.mdl",ang = 180,z=-6,
            var="ARSR",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "OVTToggle",x=240,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 0,z=-8,
            var="OVT",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=90,x=1,y=-23,z=4,var="OVTPl",ID="OVTPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "ARSToggle",x=278,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="ARS",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
       
        {ID = "L_1Toggle",x=316,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_1",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_2Toggle",x=353,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_2",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "L_3Toggle",x=391,y=181,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="L_3",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "Vent1CabToggle",x=429,y=181,radius=20,tooltip="Вентиляция кабины",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-8,
            var="Vent1Cab",speed=16,
           -- plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=26,z=4,var="VPPl",ID="VPPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

-- Front panel
ENT.ButtonMap["Block7"] = {
    pos = Vector(446.22,-17.6,-5.48+5.35),
    ang = Angle(0,-90,58),
    width = 178,
    height = 222,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "L_4Toggle",x=42,y=180.5,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="L_4",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VUSToggle",x=74.5,y=180.5,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VUS",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VADToggle",x=107,y=180.5,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAD",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VADPl",ID="VADPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "VAHToggle",x=140,y=180.5,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-4,
            var="VAH",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=28,z=4,var="VAHPl",ID="VAHPl",},
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RezMKSet",x=43,y=90,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="RezMK",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KRPSet",x=43,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="KRP",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button1_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
       
      
        {ID = "KDPSet",x=90,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-502/buttons/button_717_3.mdl",--models/metrostroi_train/81-710/ezh3_button_black.mdl
            var="KDP",speed=16,min=1,max=0,z=-2,
            lamp = {model = "models/metrostroi_train/81-717/buttons/lamp_button_1.mdl",anim=true,var="DoorsRightL",speed=9,z=2.2,color=Color(255,130,80)},
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "KDPKToggle",x=70,y=140,w=40,h=20,tooltip="",model = {
            model = "models/metrostroi_train/81/krishka.mdl",ang = 0,z = -1,
            var="KDPK",speed=8,min=0.33,max=0.685,disable="KDPSet",
            sndvol = 1,snd = function(val,realval) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},

        {ID = "!PNW",x=135,y=130,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",skin = 4,z = -1,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=81,x=-0.3,y=-0.3,z=20.6,var="PN",color=Color(255,130,90)},
        }},
        {ID = "pnbl",x=135,y=130,radius=20,tooltip="",model = {
            lamp = {model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",var="PN",scale=0.4,x=0,z=20,color=Color(255,130,90)},
        }},
    }
}

ENT.ButtonMap["Block1"] = {
    pos = Vector(450.4,28.2,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = { 
        {ID = "VMKToggle",x=39,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="VMK",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "BPSNonToggle",x=80,y=30,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-5,
            var="BPSNon",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "AVOSVToggle",x=120,y=30,radius=20,tooltip="Аварийное освещение",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_pp250.mdl",ang = 180,z=-3,
            var="AVOSV",speed=16,
            sndvol = 1,snd = function(val) return val and "switch_on" or "switch_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "KAHSet",x=80,y=80,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",z = -2,
            var="KAH",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button2_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        --{ID = "KAHPl",x=37,y=68,radius=20,tooltip=""},
        {ID = "KAHKToggle",x=70,y=75,w=20,h=10,tooltip="",model = {
            model = "models/metrostroi_train/81-717/pult/717_metalcap.mdl",ang = 0,z = 1,
            var="KAHK",speed=4,min=0.8,max=0,disable="KAHSet",ang=Angle(0,0,-90),scale=0.8,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=-90,x=-3,y=31,z=-0,var="KAHPl",ID="KAHPl",},
            sndvol = 1,snd = function(val) return val and "kr_close" or "kr_open" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "ARS13Set",x=130,y=80,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -2,
            var="ARS13",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button2_off" end,sndmin = 60,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "!BatteryVoltage", x=220,y=55,radius=60,tooltip=""},
    }
}

ENT.ButtonMap["Block3"] = {
    pos = Vector(450.4,-10,1.3+5.35),
    ang = Angle(0,-90,58),
    width = 290,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!BLTLPressure", x=62, y=55, radius=55, tooltip=""},
        {ID = "!BCPressure", x=182, y=55, radius=55, tooltip=""},
    }
}
ENT.ButtonMap["Block4"] = {
    pos = Vector(445.25,25,5.0-11.5+5.35),
    ang = Angle(0,-90,58.0),
    width = 250,
    height = 200,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!ASNPState",x=56,y=18,tooltip="",radius=3,model = {
            name="ASNPState",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",color=Color(255,56,30),z=-6.08,var="InfLamp1",scale=0.609},
        }},
        {ID = "!ASNPState2",x=56,y=36,tooltip="",radius=3,model = {
            name="ASNPState2",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",color=Color(255,56,30),z=-6.08,var="InfLamp2",scale=0.609},
        }},
        {ID = "!ASNPState3",x=56,y=54,tooltip="",radius=3,model = {
            name="ASNPState3",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",color=Color(255,56,30),z=-6.08,var="InfLamp3",scale=0.61},
        }},
        {ID = "!ASNPState4",x=55.9,y=71.9,tooltip="",radius=3,model = {
            name="ASNPState4",lamp = {speed=24,model = "models/metrostroi_train/81-502/lamps/svetodiod_small_502.mdl",color=Color(255,56,30),z=-6.08,var="InfLamp4",scale=0.61},
        }},
        {ID = "INF_Do1Set",x=32,y=22,radius=8,tooltip = "MCARD: Площадь Независимости на пересадку",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Do1Set",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
            -- sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_NextSet",x=32,y=131,radius=8,tooltip = "MCARD: Далее",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Next",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_PrevSet",x=32,y=149,radius=8,tooltip = "MCARD: Назад",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Prev",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_Do2Set",x=32,y=39,radius=8,tooltip = "MCARD: Олимпийская закрыта",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Do2",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            -- sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_Do3Set",x=32,y=60,radius=8,tooltip = "MCARD: До Васильковской",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Do3",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            -- sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_Do4Set",x=32,y=79,radius=8,tooltip = "MCARD: Площадь Независимости закрыта",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_Do4",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            -- sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNP1Set",x=32,y=96,radius=8,tooltip = "MCARD: Выход к городской электричке",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="R_ASNP1",speed=12,vmin=0,vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNP2Set",x=32,y=113,radius=8,tooltip = "MCARD: Прислоняться к дверям небезопасно",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="R_ASNP2",speed=12,vmin=0,vmax=0.9,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_5Set",x=145,y=30,radius=8,tooltip = "MCARD: Отпустите двери",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_5",speed=12,vmin=0,vmax=0.9,
            -- sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            -- sndmin = 50,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "INF_6Set",x=145,y=49,radius=8,tooltip = "MCARD: Освободите вагоны",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_6",speed=12,vmin=0,vmax=0.9,
     
        }},
        {ID = "INF_4Set",x=145,y=70,radius=8,tooltip = "MCARD: Заходите быстрее",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_4",speed=12,vmin=0,vmax=0.9,

        }},
        {ID = "INF_81Set",x=145,y=89,radius=8,tooltip = "MCARD: Соблюдайте спокойствее",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_81",speed=12,vmin=0,vmax=0.9,
        }},
        {ID = "INF_7Set",x=145,y=107,radius=8,tooltip = "MCARD: Техническая остановка",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_7",speed=12,vmin=0,vmax=0.9,
        }},
        {ID = "INF_8Set",x=145,y=127,radius=8,tooltip = "MCARD: Без маневров",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_8",speed=12,vmin=0,vmax=0.9,
        }},
        {ID = "INF_9Set",x=145,y=141,radius=8,tooltip = "MCARD: Осторожно, двери закрываются",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z=-15,
            var="INF_9",speed=12,vmin=0,vmax=0.9,
        }},
        {ID = "INF_PlaySet",x=145,y=161,radius=8,tooltip="MCARD: Пуск записи",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",z = -15,
            var="INF_Play",speed=16,vmin=1,vmax=0,
            -- sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,
            -- sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        
    }
}

ENT.ButtonMap["Block2_2"] = {
    pos = Vector(450.10+0.35,10.0,1.3+5.50),
    ang = Angle(0,-90,58),
    width = 400,
    height = 110,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {ID = "!Speedometer1",x=142,y=33,w=17,h=25,tooltip="",model = {
            name="SSpeed2",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(155, 235, 0),skin=0,getfunc=function(ent) return (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end,z=-6.1,ang=Angle(0,0,-90),
        }},
        {ID = "!Speedometer1B",x=142,y=33,w=17,h=25,tooltip="",model = {
            name="SSpeed2B",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(155, 235, 0),skin=0,scale=0,getfunc=function(ent) return (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end,z=-6.1,ang=Angle(0,0,-90),
        }},

        {ID = "!SpeedBl1",x=163,y=39,w=10,h=10,tooltip="",model = {
            name="SpeedBl1",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="LUDS",color=Color(155, 235, 0),scale=0.9, getfunc=function(ent) return ent:GetPackedBool("LUDS") and (ent:GetNW2Int("YarSpeed",1)==1 and 0.05 or ent:GetNW2Int("YarSpeed",1)==2 and 0.08 or ent:GetNW2Int("YarSpeed",1)==3 and 0.1 or ent:GetNW2Int("YarSpeed",1)==4 and 0.15 or ent:GetNW2Int("YarSpeed",1)==5 and 0.17 or 0 ) or 0 end},
        }},
        {ID = "!SpeedBl2",x=145,y=39,w=10,h=10,tooltip="",model = {
            name="SpeedBl2",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="LUDS",color=Color(155, 235, 0),scale=0.9, getfunc=function(ent) return ent:GetNW2Int("BARS-M:Speed")>9 and (ent:GetNW2Int("YarSpeed",1)==1 and 0.05 or ent:GetNW2Int("YarSpeed",1)==2 and 0.08 or ent:GetNW2Int("YarSpeed",1)==3 and 0.1 or ent:GetNW2Int("YarSpeed",1)==4 and 0.15 or ent:GetNW2Int("YarSpeed",1)==5 and 0.17 or 0 ) or 0 end},
        }},
        {ID = "YarSpeedSet",x=70,y=28,radius=20,tooltip="Яркость скоростемера",model = {
            var="YarSpeed",z=9,
        }},
        {ID = "!Speedometer2",x=160.5,y=33,w=17,h=25,tooltip="",model = {
            name="SSpeed1",model = "models/metrostroi_train/81-717/segments/segment_spb.mdl",color=Color(155, 235, 0),skin=0,getfunc=function(ent) return (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end,z=-6.1,ang=Angle(0,0,-90),
        }},
        {ID = "!ARSOch",x=100,y=72,w=10,h=10,tooltip="",model = {
            name="SAOCh",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-5.3,var="AR04", getfunc=function(ent) return ent:GetPackedBool("AR04") and (ent:GetPackedBool("R_ZS") and 1 or 0.9) or 0 end},
        }},
        {ID = "!ARSOchB",x=100,y=72,w=10,h=10,tooltip="",model = {
            name="SAOChB",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="AR04",color=Color(255,0,0),scale=0.3, getfunc=function(ent) return ent:GetPackedBool("AR04") and 0.4 or 0 end},
        }},
        {ID = "!ARS0",x=112.5,y=72,w=10,h=9,tooltip="",model = {
            name="SA0",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",z=-5.3,var="AR0", getfunc=function(ent) return ent:GetPackedBool("AR0") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!ARS0B",x=112.5,y=72,w=10,h=9,tooltip="",model = {
            name="SA0B",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="AR0",color=Color(255,0,0),scale=0.3, getfunc=function(ent) return ent:GetPackedBool("AR0") and 0.4 or 0 end},
        }},
        {ID = "!ARS40",x=125.8,y=72,w=10,h=10,tooltip="",model = {
            name="SA40",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-5.3,var="AR40",color=Color(255,127,90),  getfunc=function(ent) return ent:GetPackedBool("AR40") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!ARS40B",x=126.6,y=72,w=10,h=10,tooltip="",model = {
            name="SA40B",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="AR40",color=Color(255,127,90),scale=0.3,  getfunc=function(ent) return ent:GetPackedBool("AR40") and 0.4 or 0 end},
        }},
        {ID = "!ARS60",x=140,y=72,w=10,h=10,tooltip="",model = {
            name="SA60",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-5.3,color=Color(175,250,20),var="AR60", getfunc=function(ent) return ent:GetPackedBool("AR60") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!ARS60B",x=140,y=72,w=10,h=10,tooltip="",model = {
            name="SA60B",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="AR60",scale=0.3, getfunc=function(ent) return ent:GetPackedBool("AR60") and 0.4 or 0 end},
        }},
        {ID = "!ARS70",x=153.6,y=72,w=10,h=10,tooltip="",model = {
            name="SA70",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-5.3,color=Color(175,250,20),var="AR70",  getfunc=function(ent) return ent:GetPackedBool("AR70") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!ARS70B",x=153.3,y=72,w=10,h=10,tooltip="",model = {
            name="SA70B",lamp = {speed=10,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="AR70",scale=0.3,  getfunc=function(ent) return ent:GetPackedBool("AR70") and 0.4 or 0 end},
        }},
        {ID = "!ARS80",x=165.5,y=72,w=10,h=10,tooltip="",model = {
            name="SA80",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-5.3,color=Color(175,250,20),var="AR80",  getfunc=function(ent) return ent:GetPackedBool("AR80") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!ARS80B",x=166.5,y=72,w=10,h=10,tooltip="",model = {
            name="SA80B",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="AR80", scale=0.3, getfunc=function(ent) return ent:GetPackedBool("AR80") and 0.4 or 0 end},
        }},

        {ID = "!LampLSD1",x=209.8,y=31.5,w=10,h=4,tooltip="",model = {
            name="SSD1",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-5.3,color=Color(175,250,20),var="SD", getfunc=function(ent) return ent:GetPackedBool("SD") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLSD1B",x=209.8,y=30.5,w=10,h=4,tooltip="",model = {
            name="SSD1B",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="SD", scale=0.3,getfunc=function(ent) return ent:GetPackedBool("SD") and 0.4 or 0 end},
        }},
        {ID = "!LampLSD1B2",x=219.8,y=30.5,w=10,h=4,tooltip="",model = {
            name="SSD1B2",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="SD", scale=0.3,getfunc=function(ent) return ent:GetPackedBool("SD") and 0.4 or 0 end},
        }},
        {ID = "!LampLSD2",x=219.8,y=31.5,w=10,h=4,tooltip="",model = {
            name="SSD2",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-5.3,ang=90,color=Color(175,250,20),var="SD",  getfunc=function(ent) return ent:GetPackedBool("SD") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
       

        {ID = "!LampLVD",x=209.8,y=50.1,w=10,h=3,tooltip="",model = {
            name="SVD",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-5.3,color=Color(175,250,20),var="VD",  getfunc=function(ent) return ent:GetPackedBool("VD") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLVDB",x=209.8,y=50.1,w=10,h=3,tooltip="",model = {
            name="SVDB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,color=Color(175,250,20),var="VD", scale=0.3,  getfunc=function(ent) return ent:GetPackedBool("VD") and 0.4 or 0 end},
        }},
        {ID = "!LampLHRK",x=210,y=59,w=10,h=3,tooltip="",model = {
            name="SRK",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-5.3,var="HRK",color=Color(255,127,90), getfunc=function(ent) return ent:GetPackedBool("HRK") and (ent:GetPackedBool("HRK2") and 1 or 0.1) or 0 end},
        }},
        {ID = "!LampLHRKB",x=210,y=59,w=10,h=3,tooltip="",model = {
            name="SRKB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.6,var="HRK2",color=Color(255,127,90),scale=0.3, getfunc=function(ent) return ent:GetPackedBool("HRK2") and 0.4 or 0 end},
        }},
        {ID = "!LampLST",x=210.8,y=68,w=10,h=4,tooltip="",model = {
            name="SST",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-5.3,var="ST",color=Color(255,127,90), getfunc=function(ent) return ent:GetPackedBool("ST") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end },
        }},
        {ID = "!LampLSTB",x=210.8,y=68,w=10,h=4,tooltip="",model = {
            name="SSTB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.6,var="ST",color=Color(255,127,90),scale=0.3, getfunc=function(ent) return ent:GetPackedBool("ST") and 0.3 or 0 end },
        }},
        {ID = "!LampKT",x=190.8,y=41,w=10,h=4,tooltip="Лампа КТ",model = { 
            name="SRD",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",z=-5.3,var="KT",color=Color(255,127,90), getfunc=function(ent) return ent:GetPackedBool("KT") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampKTB",x=190.8,y=41,w=10,h=4,tooltip="Лампа КТ",model = { 
            name="SRDB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.6,var="KT",color=Color(255,127,90), scale=0.3,getfunc=function(ent) return ent:GetPackedBool("KT") and 0.4 or 0 end},
        }},
        {ID = "!LampLKVC",x=209.9,y=77,w=10,h=4,tooltip="Лампа ЛКВЦ",model = {
            name="SKVC",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),z=-5.3 ,var="KVC",color=Color(255,127,90), getfunc=function(ent) return ent:GetPackedBool("KVC") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLKVD",x=188,y=29.5,w=18,h=10,tooltip="Лампа ЛКВД",model = {
            name="SKVD",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),z=-5.3,var="KVD",color=Color(255,127,90),getfunc=function(ent) return ent:GetPackedBool("KVD") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLN",x=188,y=56,w=18,h=10,tooltip="Лампа ЛН",model = {
            name="LN",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ya.mdl",ang=Angle(0,0,90),color=Color(175,250,20),z=-5.3,var="LN",getfunc=function(ent) return ent:GetPackedBool("LN") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLNB",x=188,y=56,w=18,h=10,tooltip="Лампа ЛН",model = {
            name="LNB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",ang=Angle(0,0,90),color=Color(175,250,20),z=-4.6,var="LN",scale=0.3,getfunc=function(ent) return ent:GetPackedBool("LN") and 0.4 or 0 end},
        }},
        {ID = "!Lamp144",x=186,y=65,w=18,h=10,tooltip="Лампа 1Ч",model = {
            name="144",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),color=Color(255,127,90),z=-5.3,var="1X",getfunc=function(ent) return ent:GetPackedBool("1X") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampRS",x=188,y=74,w=18,h=10,tooltip="Код: Неисправность БАРС",model = {
            name="RS",lamp = {speed=100000,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_ra.mdl",ang=Angle(0,0,90),z=-5.3,var="KOD",getfunc=function(ent) return ent:GetPackedBool("KOD") and (ent:GetPackedBool("KOD") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampLEKK",x=210,y=86.6,w=10,h=4,tooltip="ЛЭКК",model = {
            name="SLEKK",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",ang=Angle(0,0,90),color=Color(175,250,20),z=-5.3 ,var="LEKK",getfunc=function(ent) return ent:GetPackedBool("LEKK") and (ent:GetPackedBool("R_ZS") and 1 or 0.8) or 0 end},
        }},
        {ID = "!LampRP",x=219.8,y=41,w=10,h=4,tooltip="",model = {
            name="SRP",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-5.3,var="RP",getfunc = function(ent) return ent:GetPackedRatio("RPR") end},
        }},
        {ID = "!LampRPB",x=219.8,y=41,w=10,h=4,tooltip="",model = {
            name="SRPB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,var="RP",scale=0.3, color = Color(255,0,0), getfunc = function(ent) return ent:GetPackedRatio("RPR") end},
        }},
        {ID = "!LampLSN",x=209.8,y=41,w=10,h=4,tooltip="",model = {
            name="SSN",lamp = {speed=100,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_rb.mdl",z=-5.3,ang=-90,var="SN"},
        }},
        {ID = "!LampLSNB",x=209.8,y=41,w=10,h=4,tooltip="",model = {
            name="SSNB",lamp = {speed=100,model = "models/metrostroi_train/81-5402/pult/5402_blik_white.mdl",z=-4.8,ang=-90,scale=0.3, color=Color(255,0,0),var="SN",getfunc=function(ent) return ent:GetPackedBool("SN") and 0.3 or 0 end},
        }},
    
        {ID = "!LampDV",x=219,y=43.8+8.8*3,w=10,h=4,tooltip="",model = {
            name="SDV",lamp = {speed=10,model = "models/metrostroi_train/81-717/lamps/lamp_panelspb_yb.mdl",z=-0.2,color=Color(175,250,20),var="DV",getfunc=function(ent) return ent:GetPackedBool("ddd") and (ent:GetPackedBool("ddddd") and 1 or 0.8) or 0 end}, 
        }},
    
    }
}  



-- AV panel
ENT.ButtonMap["AV_C"] = {
    pos = Vector(396,-17.5,44.6),
    ang = Angle(0,90,90),
    width = 680,
    height = 590,
    scale = 0.0625,
    nohide=true,

    buttons = {
        {ID = "A53Toggle",x=30+36.7*0,y=60+157*0,radius=25,tooltip=""},
        {ID = "A56Toggle",x=30+36.7*1,y=60+157*0,radius=25,tooltip=""},
        {ID = "A54Toggle",x=30+36.7*2,y=60+157*0,radius=25,tooltip=""},
        {ID = "A17Toggle",x=30+36.7*3,y=60+157*0,radius=25,tooltip=""},
        {ID = "A44Toggle",x=30+36.7*4,y=60+157*0,radius=25,tooltip=""},
        {ID = "A39Toggle",x=30+36.7*5,y=60+157*0,radius=25,tooltip=""},
        {ID = "A70Toggle",x=30+36.7*6,y=60+157*0,radius=25,tooltip=""},
        {ID = "A14Toggle",x=30+36.7*7,y=60+157*0,radius=25,tooltip=""},
        {ID = "A74Toggle",x=30+36.7*8,y=60+157*0,radius=25,tooltip=""},
        {ID = "A26Toggle",x=30+36.7*9,y=60+157*0,radius=25,tooltip=""},
        {ID = "AR63Toggle",x=30+36.7*10,y=60+157*0,radius=25,tooltip=""},
        {ID = "AS1Toggle",x=30+36.7*11,y=60+157*0,radius=25,tooltip=""},
        {ID = "A13Toggle",x=30+36.7*12,y=60+157*0,radius=25,tooltip=""},
        {ID = "A21Toggle",x=30+36.7*13,y=60+157*0,radius=25,tooltip=""},
        {ID = "A31Toggle",x=30+36.7*14,y=60+157*0,radius=25,tooltip=""},
        {ID = "A32Toggle",x=30+36.7*15,y=60+157*0,radius=25,tooltip=""},
        {ID = "A16Toggle",x=30+36.7*16,y=60+157*0,radius=25,tooltip=""},
        {ID = "A12Toggle",x=30+36.7*17,y=60+157*0,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A24Toggle",x=30+36.7*0,y=60+157*1,radius=25,tooltip=""},
        {ID = "A49Toggle",x=30+36.7*1,y=60+157*1,radius=25,tooltip=""},
        {ID = "A15Toggle",x=30+36.7*2,y=60+157*1,radius=25,tooltip=""}, -- 30+36.7*2
        {ID = "A27Toggle",x=30+36.7*3,y=60+157*1,radius=25,tooltip=""},
        {ID = "A72Toggle",x=30+36.7*4,y=60+157*1,radius=25,tooltip=""},
        {ID = "A50Toggle",x=30+36.7*5,y=60+157*1,radius=25,tooltip="",lab=8},
        {ID = "AV2Toggle",x=30+36.7*6,y=60+157*1,radius=25,tooltip=""},
        {ID = "AV3Toggle",x=30+36.7*7,y=60+157*1,radius=25,tooltip="",lab=9},
        {ID = "AV4Toggle",x=30+36.7*8,y=60+157*1,radius=25,tooltip="",lab=10},
        {ID = "AV5Toggle",x=30+36.7*9,y=60+157*1,radius=25,tooltip="",lab=11},
        {ID = "AV6Toggle",x=30+36.7*10,y=60+157*1,radius=25,tooltip="",lab=12},
        {ID = "AV1Toggle",x=30+36.7*11,y=60+157*1,radius=25,tooltip="",lab=13},
        {ID = "A29Toggle",x=30+36.7*12,y=60+157*1,radius=25,tooltip=""},
        {ID = "A46Toggle",x=30+36.7*13,y=60+157*1,radius=25,tooltip=""},
        {ID = "A47Toggle",x=30+36.7*14,y=60+157*1,radius=25,tooltip="",lab=17},
        {ID = "A71Toggle",x=30+36.7*15,y=60+157*1,radius=25,tooltip=""},
        {ID = "A7Toggle",x=30+36.7*16,y=60+157*1,radius=25,tooltip=""},
        {ID = "A9Toggle",x=30+36.7*17,y=60+157*1,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A84Toggle",x=30+36.7*0,y=60+157*2,radius=25,tooltip=""},
        {ID = "A8Toggle",x=30+36.7*1,y=60+157*2,radius=25,tooltip=""},
        {ID = "A52Toggle",x=30+36.7*2,y=60+157*2,radius=25,tooltip=""},
        {ID = "A19Toggle",x=30+36.7*3,y=60+157*2,radius=25,tooltip=""},
        {ID = "A48Toggle",x=30+36.7*4,y=60+157*2,radius=25,tooltip=""},
        {ID = "A10Toggle",x=30+36.7*5,y=60+157*2,radius=25,tooltip=""},
        {ID = "A22Toggle",x=30+36.7*6,y=60+157*2,radius=25,tooltip=""},
        {ID = "A30Toggle",x=30+36.7*7,y=60+157*2,radius=25,tooltip=""},
        {ID = "A1Toggle",x=30+36.7*8,y=60+157*2,radius=25,tooltip=""},
        {ID = "A2Toggle",x=30+36.7*9,y=60+157*2,radius=25,tooltip=""},
        {ID = "A3Toggle",x=30+36.7*10,y=60+157*2,radius=25,tooltip=""},
        {ID = "A4Toggle",x=30+36.7*11,y=60+157*2,radius=25,tooltip=""},
        {ID = "A5Toggle",x=30+36.7*12,y=60+157*2,radius=25,tooltip=""},
        {ID = "A6Toggle",x=30+36.7*13,y=60+157*2,radius=25,tooltip=""},
        {ID = "A18Toggle",x=30+36.7*14,y=60+157*2,radius=25,tooltip=""},
        {ID = "A73Toggle",x=30+36.7*15,y=60+157*2,radius=25,tooltip=""},
        {ID = "A20Toggle",x=30+36.7*16,y=60+157*2,radius=25,tooltip=""},
        {ID = "A25Toggle",x=30+36.7*17,y=60+157*2,radius=25,tooltip=""},
        ------------------------------------------------------------------------
        {ID = "A11Toggle",x=30+36.7*0,y=60+157*3,radius=25,tooltip=""},
        {ID = "A37Toggle",x=30+36.7*1,y=60+157*3,radius=25,tooltip=""},
        {ID = "A45Toggle",x=30+36.7*2,y=60+157*3,radius=25,tooltip=""},
        {ID = "A38Toggle",x=30+36.7*3,y=60+157*3,radius=25,tooltip=""},
        {ID = "A51Toggle",x=30+36.7*4,y=60+157*3,radius=25,tooltip=""},
        {ID = "A65Toggle",x=30+36.7*5,y=60+157*3,radius=25,tooltip=""},
        {ID = "A66Toggle",x=30+36.7*6,y=60+157*3,radius=25,tooltip="",lab=16},
        {ID = "A42Toggle",x=30+36.7*7,y=60+157*3,radius=25,tooltip=""},
        {ID = "A43Toggle",x=30+36.7*8,y=60+157*3,radius=25,tooltip=""},
        {ID = "A41Toggle",x=30+36.7*9,y=60+157*3,radius=25,tooltip=""},
        {ID = "A40Toggle",x=30+36.7*10,y=60+157*3,radius=25,tooltip=""},
        {ID = "A75Toggle",x=30+36.7*11,y=60+157*3,radius=25,tooltip=""},
        {ID = "A76Toggle",x=30+36.7*12,y=60+157*3,radius=25,tooltip=""},
        {ID = "A60Toggle",x=30+36.7*13,y=60+157*3,radius=25,tooltip=""},
        {ID = "A58Toggle",x=30+36.7*14,y=60+157*3,radius=25,tooltip="",lab=14},
        {ID = "A57Toggle",x=30+36.7*15,y=60+157*3,radius=25,tooltip=""},
        {ID = "A59Toggle",x=30+36.7*16,y=60+157*3,radius=25,tooltip="",lab=15},
        {ID = "A28Toggle",x=30+36.7*17,y=60+157*3,radius=25,tooltip=""},
    }
}
for i,button in pairs(ENT.ButtonMap.AV_C.buttons) do
    button.model = {
        model = "models/metrostroi_train/81-720/button_av1.mdl",z=-25,
        var=button.ID:Replace("Toggle",""),speed=8,
        sndvol = 0.8,snd = function(val) return val and "av_on" or "av_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
    }
    button.ID = "1:"..button.ID
  
end
ENT.ButtonMap["Battery_C"] = {
    pos = Vector(410.0,-50,21),
    ang = Angle(0,90,90),
    width = 255,
    height = 280,
    scale = 0.0625,
    hide=0.8,

    buttons = {      
        {ID = "1:VBToggle",x=40,y=240,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_vb_kkl.mdl",z=17,ang=180,
            var="VB",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
        {ID = "1:RC1Toggle",x=40,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rc1_kkl.mdl",z=17,ang=180,
            var="RC1",speed=0.5,vmin=1,vmax=0.87,
            plomb = {model = "models/metrostroi_train/81/plomb_b.mdl",ang=230,x=-28,y=28,var="RC1Pl",ID="RC1Pl",z=-15,},
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["UOS_C"] = {
    pos = Vector(410.0,-30,60),
    ang = Angle(0,90,90),
    width = 100,
    height = 100,
    scale = 0.0625,
    hide=0.8,

    buttons = {
        {ID = "1:UOSToggle",x=40,y=40,radius=40,tooltip="",model = {
            model = "models/metrostroi_train/81-717/buttons/breaker_rcuos_kkl.mdl",z=17,ang=180,
            var="UOS",speed=0.5,vmin=1,vmax=0.87,
            sndvol = 0.8,snd = function(val) return val and "pak_on" or "pak_off" end,sndmin = 80,sndmax = 1e3/3,sndang = Angle(-90,0,0),
        }},
    }
}




-- Train driver helpers panel
ENT.ButtonMap["HelperPanel_C"] = {
    pos = Vector(447,62.6,17.75),
    ang = Angle(0,0,90),
    width = 76,
    height = 305,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
       
        {ID = "VDLSet",x=0,y=86,w=76,h=86,tooltip="",model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl",z=25,scale=0,
            var="VDL",speed=6,
            sndvol = 1,snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program1HSet",x=38,y=230,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="R_Program1H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button3_on" or "button2_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2HSet",x=38,y=285,radius=20,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            var="R_Program2H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["HelperPanel_R"] = table.Copy(ENT.ButtonMap["HelperPanel_C"])
ENT.ButtonMap["HelperPanel_R"].pos = ENT.ButtonMap["HelperPanel_R"].pos - Vector(0.7,0,-0.65)
for k,v in pairs(ENT.ButtonMap["HelperPanel_R"].buttons) do v.ID = "1:"..v.ID end

ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_custom/reversor/reversor_kiev_dirty.mdl",
    pos = Vector(436.9,-29.4,-14.7),
    ang = Angle(90+65,180,90),
    hideseat=0.2,
    scale=1,
} 

ENT.ClientProps["reverserOT"] = {
	model = "models/metrostroi_custom/reversor/reversor_kiev_dirty.mdl",
	pos = Vector(446.100006,-0.2,-4.650000),
	ang = Angle(230.161285,180.000000,177.000000),
    hideseat=0.2,
}
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_custom/reversor/reversor_kiev_dirty.mdl",
    pos = Vector(443.8,-24.5,-3.2),
    ang = Angle(0,-90,60),
    hideseat=0.2,
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(423,-57,-25.0),
    ang = Angle(0,180,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVAContactSet",x=60, y=0, w=120, h=200, tooltip=""},
    }
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(422.7-2.5,-59.4,-31.6+3),
    ang = Angle(3,-180,0),
    hideseat=0.2,
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(401,62,17),
    ang = Angle(0,0,90),
    width = 200,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0,y=0,w=200,h=1300,tooltip=""},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(408.45,62.15,11.5),
    ang = Angle(0,0,0),
    hideseat=0.2,
}
ENT.ClientProps["pnevmogalmo"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(410.45,-40.15,-29),
    ang = Angle(0,90,0),
    hideseat=0.2,
}

ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(410.45,-40.15,-30.5),
    ang = Angle(0,-90,-90),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeToggle",x=0,y=0,w=200,h=120,tooltip="Стояночный тормоз",model = {
            var="ParkingBrake",sndid="parking_brake",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0)
        }},
    }
}

ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(426.1,-27.3,-20),
    ang = Angle(90,-150,90),
    width = 200,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(429.3,-23,-15),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["EPKDisconnect"] = {
    pos = Vector(435,-40,-23),
    ang = Angle(0,-90-45,45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK"--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["EPVDisconnect"] = {
    pos = Vector(435,-40,-23),
    ang = Angle(0,-90-45,45),
    width = 200,
    height = 120,
    scale = 0.0625,

    buttons = {
        {ID = "EPKToggle",x=0,y=0,w=200,h=120,tooltip="",model = {
            var="EPK"--,sndid="EPK_disconnect",
            --sndvol = 1,snd = function(val) return "disconnect_valve" end,
            --sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}


ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(427.3-2.5,-28.9,-32.5+3),
    ang = Angle(90,-60,90),
    hideseat=0.2,
}
ENT.ClientSounds["EPK"] = {
    {"EPK_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
    {"EPV_disconnect",function() return "disconnect_valve" end,1,1,90,1e3,Angle(-90,0,0)},
}
ENT.ClientProps["EPK_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(432.4-2.5,-44.25,-24.7+3),
    ang = Angle(0,-90,0),
    hideseat=0.2,
}
ENT.ClientProps["EPV_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(431.15-2.5,-43.5,-24.7+3),
    ang = Angle(0,-90,0),
    hideseat=0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(430.1-2.5,-24.0,-24.1+3),
    ang = Angle(90,-60,90),
    hideseat=0.2,
}


ENT.ButtonMap["DriverValveDisconnect"] = {
    pos = Vector(425,-23,-27),
    ang = Angle(90,-150,90),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveDisconnectToggle",x=0,y=0,w=200,h=90,tooltip="",model = {
            var="DriverValveDisconnect",sndid="valve_disconnect",
            sndvol = 1,snd = function(val) return "disconnect_valve" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}


ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470-9,-45.0,-58.0+5),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(449+11, -31, -62),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(449+11, 31, -62),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473-1,45.0,-58.0+5),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,
    hideseat=0.2,
    hide=true,
    screenHide = true,
    buttons = {
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip=""},
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip=""},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-22, -34, -62),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-22, 34, -62),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["GV"] = {
    pos = Vector(170-3-9.5,50+20,-60+2),
    ang = Angle(0,225-15,90),
    width = 260,
    height = 260,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 260,h = 260, tooltip="", model = {
            var="GV",sndid = "gv",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(153.5-3-9.5,36+20,-78+2),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-185,-68,-50),
    ang = Angle(0,0,90),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ТЦ ОТЦ"},
    }
}
ENT.ButtonMap["AirDistributor2"] = {
    pos = Vector(-185,68,-50),
    ang = Angle(0,180,90),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "3:AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ТЦ ОТЦ"},
    }
}
ENT.ButtonMap["AirDistributorSalon"] = {
    pos = Vector(-210,50,-30),
    ang = Angle(0,0,0),
    width = 170,
    height = 80,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "2:AirDistributorDisconnectToggle",x=0,y=0,w= 170,h = 80,tooltip="ВРН"},
    }
}

for i=0,4 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_"..i..".mdl",
        pos = Vector(41+16+i*6.6-5*6.6/2,67.4,-17.8),
        ang = Angle(0,90,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/81-714_mmz/bortnumber_"..i..".mdl",
        pos = Vector(64+16-i*6.6-5*6.6/2,-67.4,-17.8),
        ang = Angle(0,-90,0),
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end

ENT.ButtonMap["Route"] = {
    pos = Vector(457,43.4,-3.5),
    ang = Angle(0,99,90),
    width = 153,
    height = 130,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=65,w=76.5,h=65,tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=65,w=76.5,h=65,tooltip=""},
    }
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_holder.mdl",
    pos = Vector(-8,0,-5.65),
    ang = Angle(0,1,0),
    hide = 2,
}

ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number1.mdl",
    pos = ENT.ClientProps["route"].pos,
    ang = ENT.ClientProps["route"].ang,
    skin=6,
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number2.mdl",
    pos = ENT.ClientProps["route"].pos,
    ang = ENT.ClientProps["route"].ang,
    skin=1,
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(414.5,64,56.7),
    ang = Angle(0,0,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=2000,tooltip="",model = {
            var="door2",sndid="door2",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["OtsekDoor1"] = {
    pos = Vector(394.5,28,12.6),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor1",x=0,y=0,w=310,h=130,tooltip="",model = {
            var="door_otsek1",sndid="door_otsek1",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["OtsekDoor2"] = {
    pos = Vector(394.5,28,-15.5),
    ang = Angle(0,180,90),
    width = 310,
    height = 130,
    scale = 0.1/2,
    buttons = {
        {ID = "OtsekDoor2",x=0,y=0,w=310,h=130,tooltip="",model = {
            var="door_otsek2",sndid="door_otsek2",
            sndvol = 1,snd = function(val) return "otsek_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(390-12.2,29,50.6),--28
    ang = Angle(0,90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=500,h=2000,tooltip="",model = {
            var="door3",sndid="door3",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "UnlockDoor",x=500,y=0,w=142,h=2000,tooltip="Открытие замка двери",model = {
            var="UnlockDoor",
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(390-12.2,29+32,50.6),--28
    ang = Angle(0,-90,90),
    width = 642,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=500,h=2000,tooltip=""},
        {ID = "UnlockDoor",x=0,y=0,w=142,h=2000,tooltip="Открытие замка двери",model = {
            var="UnlockDoor",
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(411,64,50),
    ang = Angle(0,0,90),
    width = 665,
    height = 2000,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=665,h=2000,tooltip="",model = {
            var="door2",sndid="door2",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470-3,-16,48.4-2),
    ang = Angle(0,90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=642,h=1900,tooltip="",model = {
            var="door1",sndid="door1",
            sndvol = 1,snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}
--[[ ENT.ButtonMap["LeftMirror"] = {
    pos = Vector(470.0-0.1,72.75,37.4),
    ang = Angle(0,-60,90),
    width = 128,
    height = 256,
    scale = 0.06,
}
ENT.ButtonMap["RightMirror"] = {
    pos = Vector(470.0+3.4,-72.75+6,37.4),
    ang = Angle(0,-60-60,90),
    width = 128,
    height = 256,
    scale = 0.06,
}--]]
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false

ENT.ClientProps["brake334"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(432.27-2.5,-22.83,-5.2),
    ang = Angle(0,-230,0),
    hideseat = 0.2,
}
if not ENT.ClientSounds["br_013"] then ENT.ClientSounds["br_013"] = {} end
table.insert(ENT.ClientSounds["br_013"],{"brake013",function(ent,_,var) return "br_013" end,0.7,1,50,1e3,Angle(-90,0,0)})
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake334",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})



ENT.ClientProps["PB"] = {
    model = "models/metrostroi_train/81-720/720_pb.mdl",
    pos = Vector(450, 18, -37),
    ang = Angle(0,-90,8),
    hideseat = 0.2,
}
if not ENT.ClientSounds["PB"] then ENT.ClientSounds["PB"] = {} end
table.insert(ENT.ClientSounds["PB"],{"PB",function(ent,var) return var > 0 and "pb_on" or "pb_off" end,1,1,50,1e3,Angle(-90,0,0)})

ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.665070,-15.255391,-3.192689+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_tm.mdl",
    pos = Vector(450.684143,-15.267894,-3.204609+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(450.535736,-22.815704,-3.113149+5.35),
    ang = Angle(-62.299999,-33.400002,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(452.269592,-30.540430,16.922098),
    ang = Angle(90.500000,0.000000,40.000000),
    hideseat = 0.2,
}
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(452.246277,-30.519978,12.287716),
    ang = Angle(90.500000,0.000000,40.000000),
    hideseat = 0.2,
}

ENT.ClientProps["ampermeter_1"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(449.799988,-33.349998,14.5),
    ang = Angle(90,0,20),
    hideseat = 0.2,
}
ENT.ClientProps["voltmeter_1"] = {
    model = "models/metrostroi/81-717/volt_arrow.mdl",
    pos = Vector(451.399994,-28.923000,14.300000),
    ang = Angle(90,0,20),
    hideseat = 0.2,
}
ENT.ButtonMap["HVMeters"] = {
    pos = Vector(453.3,-28.7,20.1),
    ang = Angle(0,-130,90),
    width = 68,
    height = 138,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesCurrent", x=0, y=0, w=68, h=64, tooltip=""},
        {ID = "!HighVoltage", x=0, y=74, w=68, h=64, tooltip=""},
    }
}
ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(449.501740,15.141174,0.812889),
    ang = Angle(-58.299999,0.000000,27.968136),
    bscale = Vector(1,1,1.47),
    hideseat = 0.2,
}


ENT.ClientProps["bortlamps1"] = {
    model = "models/metrostroi_train/81-717/540_olights.mdl",
    pos = Vector(-15,0,0.5),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["bortlamp1_w"] = {
    model = "models/metrostroi_train/81-717/540_light_w.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,-0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_g"] = {
    model = "models/metrostroi_train/81-717/540_light_g.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,-0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["bortlamp1_y"] = {
    model = "models/metrostroi_train/81-717/540_light_o.mdl",
    pos = ENT.ClientProps.bortlamps1.pos+Vector(0,0,-0),
    ang = Angle(0,0,0),
    nohide = true,
}
ENT.ClientProps["cabine_voltmeterdot51"] = {
    model = "models/dev4you/new_voltm/new_voltm.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}



ENT.ClientProps["door0x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(337.55+1.2,64.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale=1,
}
ENT.ClientProps["door1x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(109.524+1.2-2.2,64.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0, 
    scale=1,
}
ENT.ClientProps["door2x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-123.182+1.6,64.164,0.807),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-350.3+0.8-2.2,64.164,0.6),
    ang = Angle(0,0,0),
    hide = 2.0,
    scale=1,
}
ENT.ClientProps["door0x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(337.2+1.2,-64.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(109.524+1.2-2.2,-64.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-123.182+1.6,-64.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/2k_int/2k_doors.mdl",
    pos = Vector(-350.3+0.8-2.2,-64.164,0.6),
    ang = Angle(0,180,0),
    hide = 2.0,
} 
ENT.ClientProps["Lamp_RTM1"] = {
    model = "models/metrostroi_train/81-717/rtmlamp.mdl",
    pos = Vector(414.367554,-32.449749,6.717192),
    ang = Angle(0.000000,180.000000,0.000000),
    hideseat = 0.2,
}
ENT.ClientProps["Lamp_RTM2"] = {
    model = "models/metrostroi_train/81-717/rtmlamp.mdl",
    pos = Vector(447.35,-32.82,-0.90),
    ang = Angle(0,-5,0),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps_cab2"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps2_cab1"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine1.mdl",
    pos = Vector(0.5,0,-0.7),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}
ENT.ClientProps["Lamps2_cab2"] = {
    model = "models/metrostroi_train/81-717/lamps/lamp_cabine2.mdl",
    pos = Vector(0,0,-0.8),
    ang = Angle(0,0,0),
    hideseat = 0.9,
}


ENT.ClientProps["lamps1"] = {
    model = "models/metrostroi_train/81-717/monitor_int_head.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    nohide=true
}


--scale=0.1,

ENT.Lights = {
    -- Headlight glow
    [1] = { "headlight",Vector(460,0,-40),Angle(0,0,180),Color(255,255,255),farz=6000,brightness = 4, fov=120, texture = "models/metrostroi_train/equipment/headlight",shadows = nil,headlight=true},
    -- LED Headlight
    [11] = { "headlight",Vector(460,0,-40),Angle(0,0,0),Color(240, 230, 140),farz=5144,brightness = 4, fov=100, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,50), Angle(-20,0,0), Color(255,0,0), fov=160 ,brightness = 0.8, farz=450,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [221] = { "headlight",        Vector(25,-70,45), Angle(-20,0,0), Color(0,255,0), fov=130 ,brightness = 0.1, farz=100,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [222] = { "headlight",        Vector(25,-70,38), Angle(-20,0,0), Color(254,210,18), fov=130 ,brightness = 0.1, farz=100,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [223] = { "headlight",        Vector(25,-70,50), Angle(-20,0,0), Color(255,255,255), fov=130 ,brightness = 0.1, farz=100,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},

    [3] = { "headlight",        Vector(365,-9,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},
    [4] = { "headlight",        Vector(365,-51,50), Angle(50,40,-0), Color(206,135,80), hfov=80, vfov=80,farz=100,brightness = 6,shadows=1},

    -- Manometers
    [40] = { "headlight",Vector(451.9,-13.5,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062) ,Color(255,125,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 145 },
    [41] = { "headlight",Vector(451.8,-21,-2+5.35),Angle(52.571899-15-5,-129.269775+25+15,49.853062),Color(255,125,25),farz = 8,nearz = 2,shadows = 1,brightness = 1,fov = 140 },
    [42] = { "headlight",Vector(450.3,13.1,-4.4+5.35),Angle(-136.613632-33,-95.636734-28,137.434570),Color(255,125,34),farz = 8,nearz = 2,shadows = 1,brightness = 1.5,fov = 120 },
    [43] = { "headlight",Vector(452-3,4.3+0.5,3.7+0.5),Angle(0,-90,0),Color(255,125,25),farz = 8,nearz = 3,shadows = 0,brightness = 4,fov = 90 },
    [48] = { "headlight",Vector(451.9-2.9,-4+0.5,3.7+0.5),Angle(0,90,0),Color(255,125,25),farz = 8,nearz = 3,shadows = 0,brightness = 4,fov = 90 },

    -- Voltmeter
    [44] = { "headlight",Vector(450.273468,-32.306019,13.236823),Angle(-18.000000,25.541767,-90.600349),Color(255,145,25),farz = 10,nearz = 2,shadows = 1,brightness = 1,fov = 100 },
    [45] = { "headlight",Vector(450.273468,-32.306019,18.236823),Angle(-12.000000,25.541767,-90.600349),Color(255,125,25),farz = 10,nearz = 2,shadows = 1,brightness = 1,fov = 100 },

    [46] = { "headlight",ENT.ClientProps["ampermeter_1"].pos+Vector(-0.25,-0.06,3.75),Angle(70,-20,180),Color(255,130,60),farz = 4.5,nearz = 2,shadows = 1,brightness = 5,fov = 140 },
    [47] = { "headlight",ENT.ClientProps["voltmeter_1"].pos+Vector(-0.25,-0.06,3.75),Angle(70,-20,180),Color(255,130,60),farz = 4.5,nearz = 2,shadows = 1,brightness = 5,fov = 140 },
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self.LeftMirror = self:CreateRT("LeftMirror",1024,1024)
    self.RightMirror = self:CreateRT("RightMirror",128,256) 
    self.ScreenKyiv = self:CreateRT("717ScreenKyiv", 2048, 1024)
    self.Schedule = self:CreateRT("717Schedule",1650,1000)


    self.CraneRamp = 0
    self.CraneLRamp = 0
    self.CraneRRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
    self.FrontLeak = 0
    self.RearLeak = 0

    self.VentCab = 0
    self.VentG1 = 0
    self.VentG2 = 0
end

function ENT:UpdateWagonNumber()
    local count = math.max(4,math.ceil(math.log10(self.WagonNumber+1)))
    for i=0,4 do
        self:ShowHide("TrainNumberL"..i,i<count)
        self:ShowHide("TrainNumberR"..i,i<count)
        if i< count and self.WagonNumber then
            local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
            local num = --[[string.sub(nums[tostring(self:GetNW2Int("CoupleNumber"))..'_'..tostring(num_seed)],i,i)]]            math.floor(self.WagonNumber%(10^(i+1))/10^i)
            if IsValid(leftNum) then
                leftNum:SetPos(self:LocalToWorld(Vector(41+16+i*6.6-count*6.6/2,67.4,-17.8)))
                leftNum:SetModel("models/metrostroi_train/81-714_mmz/bortnumber_"..num..".mdl")
            end
            if IsValid(rightNum) then
                rightNum:SetPos(self:LocalToWorld(Vector(64+16-i*6.6-count*6.6/2,-67.4,-17.8)))
                rightNum:SetModel("models/metrostroi_train/81-714_mmz/bortnumber_"..num..".mdl")
            end
        end
    end
end 

local Cpos = {
    0,0.2,0.4,0.5,0.6,0.8,1
}
function ENT:DrawSchedule(gray_scale)
	local config = Metrostroi.StationsK["gm_metro_kalinin_v2"]
	local W, H = 0, 0
	local reversed = not self:GetNW2Bool("SCH:Reverse")
	surface.SetDrawColor(gray_scale, gray_scale, gray_scale)
    if reversed then 
    draw.SimpleTextOutlined("3:00","sched_4",95+65,83,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
	draw.SimpleTextOutlined("38:40","sched_4",95,83,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- время хода
	draw.SimpleTextOutlined(self:GetNW2String("SCH:Pozd"),"sched_4",95,67,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,0,Color(0,0,0,0)) -- н поезда
	draw.SimpleTextOutlined(self:GetNW2String("SCH:Route"),"sched_4",95+75,65,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,0,Color(0,0,0,0)) -- н маршрут
    else
    draw.SimpleTextOutlined("3:00","sched_4",95+65+13,83,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
    draw.SimpleTextOutlined("38:40","sched_4",95+10,83,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- время хода
    draw.SimpleTextOutlined(self:GetNW2String("SCH:Pozd"),"sched_4",95+5,67,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,0,Color(0,0,0,0)) -- н поезда
    draw.SimpleTextOutlined(self:GetNW2String("SCH:Route"),"sched_4",95+75+15,65+3,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,0,Color(0,0,0,0)) -- н маршрут
    end
	-- станции
 
	local start_time = self:GetNW2Float("SCH:StartTime", Metrostroi.GetSyncTime())


	local k = 1

	local add_time = 0
	local oldhour = -1

	local tbl = {}

	for k, v in pairs(config) do
		table.insert(tbl, v)
	end

	if path == 2 then
		tbl = table.Reverse(tbl)
	end

	local function fixTime(inTime)
		if #tostring(inTime) == 1 then
			return "0" .. inTime
		end
		return inTime
	end

	local path = reversed and 2 or 1
	local font = reversed and "sched_4" or "sched_4"

	if reversed then
		for i, v in pairs(config) do
			local time = v["path" .. path .. "t"]
			add_time = add_time + time
		end
		add_time = add_time + 5*60
	end

	for i, v in pairs(tbl) do
		local hx = {[1] = 80, [2] = 97, [3] = 98+17, [4] = 98+17*2, [5] = 98+17*3, [6] = 98+17*4, [7] = 98+17*5, [8] = 98+17.1*6, [9] = 98+18*7, [10] = 98+17.5*8, [11] = 98+17*9, [12] = 98+17.1*10, [13] = 98+17.1*11, [14] = 98+17.1*12, [15] = 98+17.1*13, [16] = 98+17.1*14, [17] = 98+17.1*15, [18] = 98+17.1*16}
		
		if reversed then
			hx = {[1] = 120, [2] = 132, [3] = 132+11, [4] = 132+11*2, [5] = 132+11.5*3, [6] = 132+11.5*4, [7] = 132+11.5*5, [8] = 132+11.7*6, [9] = 98+18*7, [10] = 89+16.5*8, [11] = 89+16*9, [12] = 89+16.1*10, [13] = 89+16.1*11, [14] = 89+16.1*12, [15] = 89+16.1*13, [16] = 89+16.1*14, [17] = 89+16.1*15, [18] = 89+16.1*16}
		end
		local time = v["path" .. path .. "t"]

		add_time = add_time + time 

		local date = os.date("!*t", start_time + add_time)

		local sec = math.floor(date.sec/5)*5

		if oldhour ~= date.hour then
			oldhour = date.hour
            if reversed then 
			draw.SimpleTextOutlined(fixTime(date.hour),font,W*.65+135,H*.45+hx[k],Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
            else
			draw.SimpleTextOutlined(fixTime(date.hour),font,W*.65+150,H*.45+hx[k]+38,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
            end
		end
        if reversed then 
		draw.SimpleTextOutlined(fixTime(date.min),font,W*.65+165,H*.45+hx[k],Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
		draw.SimpleTextOutlined(fixTime(sec),font,W*.65+186,H*.45+hx[k],Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
        else
        draw.SimpleTextOutlined(fixTime(date.min),font,W*.65+172,H*.45+hx[k]+38,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал
        draw.SimpleTextOutlined(fixTime(sec),font,W*.65+196,H*.45+hx[k]+37,Color(0,0,255/2.1,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0,0)) -- интервал  
        end

		k = k + 1
	end
end 
--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        self.RKTimer = nil
        self.OldBPSNType = nil
        self.RingType = nil
        return
    end 
    render.PushRenderTarget(self.Schedule, 0, 0, 1650, 1000)
    render.Clear(0, 0, 0, 0)
          cam.Start2D()
                local color = Color(255,255,255) 
                local gray_scale = (color.r+color.g+color.b)/3
                if self:GetNW2Bool("ScheduleH") then 
                self:DrawSchedule(gray_scale)
                end 
          cam.End2D() 
    render.PopRenderTarget()  
    self:ShowHide("schedule", self:GetNW2Bool("ScheduleH"))
    self:Animate("schedule", self:GetNW2Bool("ScheduleRV") and 1 or 0,0,1,1,false)
    self:ShowHide("kapli",GetGlobalBool("rain"))
    self:ShowHide("kapli_left",GetGlobalBool("rain")) 
    self:ShowHide("kapli_right",GetGlobalBool("rain"))
    self:ShowHide("kapli_cab",GetGlobalBool("rain"))
    for i = 1,3 do
         self:ShowHide("BigLamp_"..i.."_Motorolla", self:GetNW2Bool("Motorolla_Lamp" .. i)) 
    end  
    local b1 = self:GetNW2Int("BrightALS",5)
    local tr = self:GetNW2Int("LastStation1",1)
    self:ShowHide("trafaret_2",tr==1)
    self:ShowHide("trafaret",tr==2)
    self:ShowHide("trafaret_3",tr==3)
    self:ShowHide("trafaret_4",tr==4)
    self:ShowHide("pult_mvm_classic2",not self:GetNW2Bool("PultGray"))
    self:ShowHide("pult_mvm_classic22",self:GetNW2Bool("PultGray"))
    self:ShowHide("pult_nakl",not self:GetNW2Bool("PultGray"))
    self:ShowHide("body_gray",self:GetNW2Bool("PultGray_2"))
    self:ShowHide("body_new",!self:GetNW2Bool("PultGray_2"))

    local wolt = self:GetNW2Bool("NewCabVolt")
    self:ShowHide("cabine_mvm2",not self:GetNW2Bool("CabType"))
    self:ShowHide("cabine_mvm",self:GetNW2Bool("CabType") and not wolt)
    self:ShowHide("cabine_volt",wolt)
    self:ShowHide("cabine_voltmeterdot51",wolt)
    self:ShowHide("voltmeter",not wolt)
    self:ShowHide("ampermeter",not wolt)
    self:ShowHide("ampermeter_1",wolt)
    self:ShowHide("voltmeter_1",wolt)
    self:SetLightPower(44,self:GetPackedBool("PanelLights") and not wolt)
    self:SetLightPower(45,self:GetPackedBool("PanelLights") and not wolt)
    self:SetLightPower(46,self:GetPackedBool("PanelLights") and wolt)
    self:SetLightPower(47,self:GetPackedBool("PanelLights") and wolt)
    local m = self:GetNW2Int("MaskT",1)
   
    self:ShowHide("mask242_def",m==2)
    self:ShowHide("mask242_def_g",m==2)
    self:ShowHide("mask141_def",m==1)
    self:ShowHide("mask222_def",m==4)
    self:ShowHide("mask22_d",m==3)
    for i = 1,12 do
        self:ShowHide("lamp1_3",false)
        self:ShowHide("lamp1_9",false)
        if i~=3 and i~=9 then 
        self:ShowHideSmooth("lamp1_"..i,self:Animate("Lamp1_"..i,self:GetPackedBool("lightsActive"..i) and 1 or 0,0,1,6,false))
        end
    end
    local it = self:GetNW2Int("InfType",1)
    local inf = self.ClientEnts["pult_mvm_classic"] 

    local svetinfo = self:Animate("announcer_light",(self:GetNW2Bool("InformSvet")) and 0.15 or 0,0,0.45,10,false)
    if IsValid(inf) then 
    self.ClientEnts["pult_mvm_classic"].announcer_light  = svetinfo
    end
    if IsValid(self.ClientEnts["pult_mvm_classicw"]) then 
        self.ClientEnts["pult_mvm_classicw"].announcer_light  = svetinfo
    end

    if IsValid(self.ClientEnts["pult_mvm_classicwd"]) then 
        self.ClientEnts["pult_mvm_classicwd"].announcer_light  = svetinfo
    end
    self:ShowHide("pult_mvm_classic",it==1)
    self:ShowHide("pult_mvm_classicw",it==2)
    self:ShowHide("pult_mvm_classicwd",it==3)
    self:HidePanel("Block4",self:GetNW2Int("Inform",1)~=1)

    if self.Scheme ~= self:GetNW2Int("Scheme",1) then
        self.PassSchemesDone = false
        self.Scheme = self:GetNW2Int("Scheme",1)
    end
    if self.RelaysConfig ~= self:GetNW2String("RelaysConfig") then
        self.RelaysConfig = self:GetNW2String("RelaysConfig")
        self:SetRelays()
    end
    if not self.PassSchemesDone and IsValid(self.ClientEnts.schemes) then
        local scheme = Metrostroi.Skins["717_new_schemes"] and Metrostroi.Skins["717_new_schemes"][self.Scheme]
        self.ClientEnts.schemes:SetSubMaterial(1,scheme and scheme[1])
        self.PassSchemesDone = true
    end
    self:SetLightPower(40,self:GetPackedBool("PanelLights"))
    self:SetLightPower(41,self:GetPackedBool("PanelLights"))
    self:SetLightPower(42,self:GetPackedBool("PanelLights"))
    local HL1 = self:Animate("Headlights1",self:GetPackedBool("Headlights1") and 1 or 0,0,1,6,false)
    local HL2 = self:Animate("Headlights2",self:GetPackedBool("Headlights2") and 1 or 0,0,1,6,false)
    local RL = self:Animate("RedLights_a",self:GetPackedBool("RedLights") and 1 or 0,0,1,6,false)


    local artype = self:GetNW2Int("ARSKKL",-1)
    for i=1,6 do 
        self:Animate("pred"..i, self:GetPackedBool("Pred"..i) and 1 or 0,0,1, 3, false)
    end 
    for i=1,6 do 
        self:ShowHide("pred"..i.."b", self:GetPackedBool("PredC"..i)) 
    end 
    self:ShowHideSmooth("RedLights",RL)
    local headlight = HL1*0.6+HL2*1
    local cht1 = self:GetNW2Int("MaskT",1)
    if cht1~=4 then 
    self:SetLightPower(11,0,0)
    self:SetLightPower(1,headlight>0,headlight)
    else
    self:SetLightPower(1,0,0)
    self:SetLightPower(11,headlight>0,0.8)
    end 
    self:SetLightPower(2,self:GetPackedBool("RedLights"),RL)

    self:SetLightPower(221,self:GetPackedBool("GRP"),1)
    self:SetLightPower(222,self:GetPackedBool("BrW"),1)
    self:SetLightPower(223,self:GetPackedBool("DoorsW"),1)

    local newBortlamps = self:GetNW2Bool("NewBortlamps")
    local Bortlamp_w = self:Animate("Bortlamp_w",self:GetPackedBool("DoorsW") and 1 or 0,0,1,16,false)
    local Bortlamp_g = self:Animate("Bortlamp_g",self:GetPackedBool("GRP") and 1 or 0,0,1,16,false)
    local Bortlamp_y = self:Animate("Bortlamp_y",self:GetPackedBool("BrW") and 1 or 0,0,1,16,false)
    if newBortlamps then
        self:ShowHide("bortlamps1",true)
        self:ShowHide("bortlamps2",true)
        self:ShowHide("bortlamps3",false)
        self:ShowHide("bortlamps4",false)
        self:ShowHideSmooth("bortlamp1_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp1_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp1_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp2_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp2_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp2_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp3_w",0)
        self:ShowHideSmooth("bortlamp3_g",0)
        self:ShowHideSmooth("bortlamp3_y",0)
        self:ShowHideSmooth("bortlamp4_w",0)
        self:ShowHideSmooth("bortlamp4_g",0)
        self:ShowHideSmooth("bortlamp4_y",0)
    else
        self:ShowHide("bortlamps1",false)
        self:ShowHide("bortlamps2",false)
        self:ShowHide("bortlamps3",true)
        self:ShowHide("bortlamps4",true)
        self:ShowHideSmooth("bortlamp1_w",0)
        self:ShowHideSmooth("bortlamp1_g",0)
        self:ShowHideSmooth("bortlamp1_y",0)
        self:ShowHideSmooth("bortlamp2_w",0)
        self:ShowHideSmooth("bortlamp2_g",0)
        self:ShowHideSmooth("bortlamp2_y",0)
        self:ShowHideSmooth("bortlamp3_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp3_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp3_y",Bortlamp_y)
        self:ShowHideSmooth("bortlamp4_w",Bortlamp_w)
        self:ShowHideSmooth("bortlamp4_g",Bortlamp_g)
        self:ShowHideSmooth("bortlamp4_y",Bortlamp_y)
    end

    local kvs = {
        [0] = 0.26,
        [1] = 0.18,
        [3] = 0,
        [2] = 0.1,
        [-1] = 0.6,
        [-2] = 0.8,
        [-3] = 1,
    }
    self:Animate("Controller",kvs[self:GetNW2Int("KVPos",1)],0.95,0.02,4,false) 
    self:Animate("Controller5",self:GetPackedRatio("ControllerPosition"),0,1,2,false)
    local kv = self:GetNW2Bool("Kv") 
    self:ShowHide("Controller", not kv) 
    self:ShowHide("Controller5", kv)
    self:ShowHide("kv2", kv)



    self:Animate("reverser",self:GetNW2Int("ReverserPosition")/2,0,0.24,4,false)
    self:Animate("krureverser",self:GetNW2Int("KRUPosition")/2,0.53,1,4,false)
    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("reverserOT",self:GetNW2Bool("ReverserOT"))
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)

    self:ShowHide("brake013",self:GetPackedBool("Crane013"))
    self:ShowHide("brake_valve_013",self:GetPackedBool("Crane013"))
    self:ShowHide("valve_disconnect",self:GetPackedBool("Crane013"))
    self:ShowHide("EPV_disconnect",self:GetPackedBool("Crane013"))
    self:HidePanel("DriverValveDisconnect",not self:GetPackedBool("Crane013"))

    self:ShowHide("brake334",not self:GetPackedBool("Crane013"))
    self:ShowHide("brake_valve_334",not self:GetPackedBool("Crane013"))
    self:ShowHide("brake_disconnect",not self:GetPackedBool("Crane013"))
    self:ShowHide("EPK_disconnect",not self:GetPackedBool("Crane013"))
    self:ShowHide("train_disconnect",not self:GetPackedBool("Crane013"))
    self:HidePanel("DriverValveBLDisconnect",self:GetPackedBool("Crane013"))
    self:HidePanel("DriverValveTLDisconnect",self:GetPackedBool("Crane013"))

    self:Animate("brake334",self:GetPackedRatio("CranePosition")/5,0.35,0.65,256,24)

    local speed = self:GetNW2Int("BARS-M:Speed")

    self:ShowHide("SSpeed1",self:GetPackedBool("LUDS"))
    self:ShowHide("SSpeed2",self:GetPackedBool("LUDS") and speed>= 10)
    self:ShowHide("SpeedBl2",self:GetPackedBool("LUDS") and speed>= 10)
   
    if self:GetPackedBool("LUDS") then
        if IsValid(self.ClientEnts["SSpeed1"])then self.ClientEnts["SSpeed1"]:SetSkin(math.floor(speed)%10) end
        if IsValid(self.ClientEnts["SSpeed2"])then self.ClientEnts["SSpeed2"]:SetSkin(math.floor(speed/10)) end
      
    end

    local handrails = self:GetNW2Bool("HandRails")
    local dot5 = self:GetNW2Bool("Dot5")
    local lvz = self:GetNW2Bool("LVZ")
    local newSeats = self:GetNW2Bool("NewSeats")
    local mask = self:GetNW2Bool("Mask")
    local mask22 = self:GetNW2Bool("Mask22")

    self:ShowHide("destination",not dot5)


    self:HidePanel("HelperPanel_C",dot5)
    self:ShowHide("cabine_lvz",dot5)
    self:ShowHide("destination1",dot5)
    self:ShowHide("handrails_old",dot5)
    self:ShowHide("handrails_new",dot5)
    self.LastStation.EntityName = dot5 and "destination1" or "destination"

    local lamps_cab2 = self:Animate("lamps_cab2",self:GetPackedBool("EqLights") and 1 or 0,0,1,5,false)
    local lamps_cab1 = self:Animate("lamps_cab1",self:GetPackedBool("CabLights") and 1 or 0,0,1,5,false)
    self:ShowHideSmooth("Lamps_cab2",dot5 and 0 or lamps_cab2)
    self:ShowHideSmooth("Lamps_cab1",dot5 and 0 or lamps_cab1)
    self:ShowHideSmooth("Lamps2_cab2",dot5 and lamps_cab2 or 0)
    self:ShowHideSmooth("Lamps2_cab1",dot5 and lamps_cab1 or 0)


    self:ShowHideSmooth("Lamp_RTM1",not dot5 and lamps_rtm or 0)
    self:ShowHideSmooth("Lamp_RTM2",dot5 and lamps_rtm or 0)
    local cht = self:GetNW2Int("MaskT",1)
    self:ShowHide("1:KVTSet",not lvz)
    self:ShowHide("1:KVTRSet",not lvz)
    self:ShowHide("2:KVTSet",lvz)
    self:ShowHide("2:KVTRSet",lvz)
    self:ShowHideSmooth("Headlights222_1",(not mask and not mask22) and HL1 or 0)
    self:ShowHideSmooth("Headlights222_2",(not mask and not mask22) and HL2 or 0)
    self:ShowHideSmooth("Headlights141_1",(mask and not mask22 and cht~=4 and cht~=3) and HL1 or 0)
    self:ShowHideSmooth("Headlights141_2",(mask and not mask22 and cht~=4 and cht~=3) and HL2 or 0)
    self:ShowHideSmooth("Headlights22_1",(cht==3) and HL1 or 0)
    self:ShowHideSmooth("Headlights22_2",(cht==3) and HL2 or 0)
    self:ShowHideSmooth("Headlights222p_1",cht==4 and HL1 or 0) 
    self:ShowHideSmooth("Headlights222p_2",cht==4 and HL2 or 0)
  

    
    self:ShowHide("seats_old",not newSeats)
    self:ShowHide("seats_old_cap",not newSeats)
    self:ShowHide("seats_new",newSeats)
    self:ShowHide("seats_new_cap",newSeats)
    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)
    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("pnevmogalmo",   self:GetPackedBool("ParkingBrake") and 0 or 1,0.25,0,  4,false)
    self:Animate("EPK_disconnect",   self:GetPackedBool("EPK") and 1 or 0,0.25,0,  4,false)
    self:Animate("EPV_disconnect",   self:GetPackedBool("EPK") and 1 or 0,0.25,0,  4,false)
    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("valve_disconnect",self:GetPackedBool("DriverValveDisconnect") and 1 or 0,0.25,0,  4,false)
    self:Animate("stopkran",   self:GetPackedBool("EmergencyBrakeValve") and 0 or 1,     0.25,0, 128,  3,false)
    self:Animate("stopkran1",   self:GetPackedBool("DoorOff1") and 0 or 1,     0.25,0, 128,  3,false)
    self:Animate("stopkran2",   self:GetPackedBool("DoorOff2") and 0 or 1,     0.25,0, 128,  3,false)



    local c013 = self:GetNW2Int("Crane",2)==1
    self:ShowHide("brake_valve_334",not c013)
    self:ShowHide("brake334",not c013)
    self:ShowHide("brake_disconnect",not c013)
    self:ShowHide("train_disconnect",not c013)
    self:HidePanel("DriverValveBLDisconnect",c013)
    self:HidePanel("DriverValveTLDisconnect",c013)
    self:HidePanel("EPKDisconnect",c013)
    self:ShowHide("EPK_disconnect",not c013)
    self:ShowHide("brake_valve_013",c013)
    self:ShowHide("brake013",c013)
    self:ShowHide("valve_disconnect",c013)
    self:ShowHide("EPV_disconnect",c013)
    self:HidePanel("EPVDisconnect",not c013)
    self:HidePanel("DriverValveDisconnect",not c013)

    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.143,0.88,256,2)--,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.143,0.88,256,0)--,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"),0.134,0.874,256,0.03)--,0.03)

    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.396,0.658,256,0.2,false)
    self:Animate("volt1",self:GetPackedRatio("BatteryVoltage"),0.625,0.376,256,0.2,false)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.39,0.655,256,0.2,false)
    self:Animate("ampermeter_1",self:GetPackedRatio("EnginesCurrent"),0.39,0.655,256,0.2,false)
    self:Animate("voltmeter_1",self:GetPackedRatio("EnginesVoltage"),0.396,0.658,256,0.2,false)
    local otsek1 = self:Animate("door_otsek1",self:GetPackedBool("OtsekDoor1") and 1 or 0,0,0.25,4,0.5)
    local otsek2 = self:Animate("door_otsek2",self:GetPackedBool("OtsekDoor2") and 1 or 0,0,0.25,4,0.5)
    local door1 = self:Animate("door1",self:GetPackedBool("RearDoor") and 1 or 0,0,0.25,4,0.5)
    local door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,0,0.56,3,0.5)
    local door2_l = self:Animate("door2_lock",self:GetPackedBool("DoorLock") and 1 or 0,0,1,2,false)

    self:ShowHide("door2_lock",door2==0)
    if IsValid(self.ClientEnts["door2"]) then 
        if door2>0 then 
            self.ClientEnts["door2"]:SetModel("models/metrostroi_custom/81-717/door_cabine2.mdl")
            door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,0,0.56,3,0.5)
        else
            self.ClientEnts["door2"]:SetModel("models/metrostroi_custom/81-717/door_cabine.mdl")
            door2 = self:Animate("door2",self:GetPackedBool("PassengerDoor") and 1 or 0,0,0.56,3,0.5)
        end 
    end 

    --Неебический расчёт неебической физики неебической двери
    local a = self:GetNW2Float("Accel") --Ускорение
    local open = self:GetPackedBool("CabinDoor") --Открыта ли дверь
    local threshold = 3.8 --Множитель
    if not self.Door3State then self.Door3State = open and 1 or 0 end 
    if open and self.Door3State == 0 then self.Door3State = 1 end --Открываем дверь
    
    if open then --Расчет неебической физики, если неебическая дверь открыта
        local dT = self.DeltaTime --Для синхры клиентской ФПС (ФПС - мазь от геморроя, Юзя)
        local door_v = math.Clamp(self.Door3State+a*threshold*dT,0,1) --Математика на [0,1]
        self.Door3State = math.Clamp(door_v,0,1) --Ограничиваем [0,1]
        if self.Door3State < 0.002 and open then --Если оно захлопнется, то закрываем насовсем и отправляем в init.lua
            --self:SetPackedBool("CabinDoor",false)
            net.Start("CabinDoor")
            net.WriteEntity(self)
            net.WriteBool(false)
            net.SendToServer()
        end
    end
    
    if not open and self.Door3State ~= 0 then --Если профмаш прохладился и решил закрыть дверь
        self.Door3State = 0
    end
    local door3 = self:Animate("door3",self.Door3State,0,0.400,4,0.5)
     --Анимация неебической двери
  
    if self.Door3 ~= (door3 > 0) then --Неебическая дверь с неебической физикой
        self.Door3 = door3 > 0
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end 
    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 >0) then
        self.Door2 = door2 >0
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end

    if self.Otsek1 ~= (otsek1 > 0) then
        self.Otsek1 = otsek1 > 0
        if not self.Otsek1 then
            self:PlayOnce("door_otsek1","bass",1)
        end
    end
    if self.Otsek2 ~= (otsek2 > 0) then
        self.Otsek2 = otsek2 > 0
        if not self.Otsek2 then
            self:PlayOnce("door_otsek2","bass",1)
        end
    end
    self:SetLightPower(3,self.Otsek1 and self:GetPackedBool("EqLights"))
    self:SetLightPower(4,self.Otsek2 and self:GetPackedBool("EqLights"))

  
    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)


    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    --self:InitializeSounds()
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then dlo = self.Anims[n_l].oldspeed/14 end
            end

            self:Animate(n_l,state,0,0.95,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1,dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end

    local dT = self.DeltaTime
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*0.6,self.StreetCoeff)
    local speed = self:GetPackedRatio("Speed")*100.0
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    local rol40p = Lerp((speed-23)/50,0.6,1)
    local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    local rol80 = math.Clamp((speed-70)/5,0,1)
    local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_40",rollingi*rol40,rol40p)
    self:SetSoundState("rolling_70",rollingi*rol70,rol70p)
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp((self.ReleasedPdT-0.1)/0.8,0,1)^2
    self:SetSoundState("release1",release1,1)
    self:SetSoundState("release2",(math.Clamp(0.3-release1,0,0.3)/0.3)*(release1/0.3),1.0)
    local parking_brake = self:GetPackedRatio("ParkingBrakePressure_dPdT",0)
    local parking_brake_abs = math.Clamp(math.abs(parking_brake)-0.3,0,1)
    if self.ParkingBrake1 ~= (parking_brake<1) then
        self.ParkingBrake1 = (parking_brake<1)
        if self.ParkingBrake1 then self:PlayOnce("parking_brake_en","bass",1,1) end
    end
    if self.ParkingBrake2 ~= (parking_brake>-0.8) then
        self.ParkingBrake2 = (parking_brake>-0.8)
        if self.ParkingBrake2 then self:PlayOnce("parking_brake_rel","bass",0.6,1) end
    end
    self:SetSoundState("parking_brake",parking_brake_abs,1)
    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)


    local ramp = self:GetPackedRatio("Crane_dPdT",0)
    if c013 then
        if ramp > 0 then
            self.CraneRamp = self.CraneRamp + ((0.2*ramp)-self.CraneRamp)*dT
        else
            self.CraneRamp = self.CraneRamp + ((0.9*ramp)-self.CraneRamp)*dT
        end
        self.CraneRRamp = math.Clamp(self.CraneRRamp + 1.0*((1*ramp)-self.CraneRRamp)*dT,0,1)
        self:SetSoundState("crane334_brake",0,1.0)
        self:SetSoundState("crane334_brake_reflection",0,1.0)
        self:SetSoundState("crane334_brake_slow",0,1.0)
        self:SetSoundState("crane334_release",0,1.0)
        self:SetSoundState("crane013_release",self.CraneRRamp^1.5,1.0)
        self:SetSoundState("crane013_brake",math.Clamp(-self.CraneRamp*1.5-0.1,0,1)^1.3,1.0)
        local loudV = self:GetNW2Float("Crane013Loud",0)
        if loudV>0 then
            if ramp>0 then
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*0.5
            else
                self.CraneLRamp = self.CraneLRamp + (math.min(ramp,0)-self.CraneLRamp)*dT*1
            end
            self:SetSoundState("crane013_brake_l",(math.Clamp(-self.CraneRamp*2.5-0.1,0,1)^1.3)*(1-math.Clamp((-self.CraneLRamp-loudV)*3,0,1)),1.12-math.Clamp((-self.CraneLRamp-0.15)*2,0,1)*0.12)
        else
            self:SetSoundState("crane013_brake_l",0,1)
        end
        self:SetSoundState("crane013_brake2",math.Clamp(-self.CraneRamp*1.5-0.95,0,1.5)^2,1.0)
    else
        self:SetSoundState("crane013_brake",0,1.0)
        self:SetSoundState("crane013_release",0,1.0)
        --self:SetSoundState("crane013_brake2",0,1.0)

        self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)

        self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
        local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
        self:SetSoundState("crane334_brake_high",high,1.0)
        self:SetSoundState("crane013_brake2",high*2,1.0)
        self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
        self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

        self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)
    end
    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    if self.EmergencyValveEPKRamp < 0.01 then self.EmergencyValveEPKRamp = 0 end
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)

--[[
    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    --self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))
    local emerBrakeValve = self.EmergencyBrakeValveRamp
    self:SetSoundState("valve_brake_l",math.Clamp(emerBrakeValve/0.2,0,1),1)
    self:SetSoundState("valve_brake_m",math.Clamp((emerBrakeValve-0.2)/0.3,0,1),1)
    self:SetSoundState("valve_brake_h",math.Clamp((emerBrakeValve-0.5)/0.5,0,1),1)
--]]
    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+math.min(0.4,self.EmergencyBrakeValveRamp*0.8))

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    --self:SetSoundState("emer_brake",self.EmergencyValveRamp*0.8,1)
    -- Compressor
    self:SetSoundState("compressor",self:GetPackedBool("Compressor") and 0.6 or 0,1)
    self:SetSoundState("compressor2",self:GetPackedBool("Compressor") and 0.8 or 0,1)



    local v1state = self:GetPackedBool("M1_3") and 1 or 0
    local v2state = self:GetPackedBool("M4_7") and 1 or 0
    local vCstate = self:GetPackedRatio("M8")/2
    if self.VentCab < vCstate then
        self.VentCab = math.min(1,self.VentCab + dT/2.7)
    elseif self.VentCab > vCstate then
        self.VentCab = math.max(0,self.VentCab - dT/2.7)
    end
    self.VentG1 = math.Clamp(self.VentG1 + dT/2.7*(v1state*2-1),0,1)
    self.VentG2 = math.Clamp(self.VentG2 + dT/2.7*(v2state*2-1),0,1)
    -- self:SetSoundState("vent_cabl",math.Clamp(self.VentCab*2,0,1) ,1)
    self:SetSoundState("vent_cabl",self:GetPackedBool("VentCab") and 1 or 0,1)

    for i=1,7 do
        if i<4 then
            self:SetSoundState("vent"..i,self.VentG1,1)
        else
            self:SetSoundState("vent"..i,self.VentG2,1)
        end
    end
    if self.RingType ~= self:GetNW2Int("RingType",1) then
        self.RingType = self:GetNW2Int("RingType",1)
        self:SetSoundState(self.RingName,0,0)

        self.RingPitch = 1
        self.RingVolume = 1
        if self.RingType == 1 then
            self.RingName = "ring2"
        elseif self.RingType == 2 then
            self.RingName = "ring3"
            self.RingVolume = 1.4
            self.RingPitch = 0.6
        elseif self.RingType == 3 then
            self.RingName = "ring3"
            self.RingVolume = 1.2
            self.RingPitch = 0.8
        elseif self.RingType == 4 then
            self.RingName = "ring3"
            self.RingPitch = 0.95
        elseif self.RingType == 5 then
            self.RingName = "ring"
            self.RingPitch = 0.8
        elseif self.RingType == 6 then
            self.RingName = "ring"
        elseif self.RingType == 7 then
            self.RingName = "ring4"
        elseif self.RingType == 8 then
            self.RingName = "ring5"
        elseif self.RingType == 9 then
            self.RingName = "ring6"
        end
        self.RingFade = 0
    end
    self:SetSoundState("motorolla_on",self:GetNW2Bool("MotorollaStart") and 1 or 0,1)
    -- ARS/ringer alert
    local bzos = self.RingName=="ring" or self.RingName=="ring6" or self.RingName=="ring3" and RealTime()%0.8<0.35 or self.RingName~="ring3" and RealTime()%0.5>0.25
    local ringstate = (self:GetPackedBool("Buzzer") or self:GetPackedBool("BuzzerBZOS") and bzos) and 1 or 0
    if 6< self.RingType and self.RingType < 9 then
        self.RingFade = math.Clamp(self.RingFade+(ringstate-self.RingFade)*dT*(self:GetPackedBool("BuzzerBZOS") and 50 or 25),0,1)
        self:SetSoundState(self.RingName,self.RingFade*self.RingVolume,self.RingPitch)
    else
        self:SetSoundState(self.RingName,ringstate*self.RingVolume,self.RingPitch)
    end
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    self:SetSoundState("rk",(self.RKTimer and (CurTime() - self.RKTimer) < 0.2) and 0.7 or 0,1)

    -- BPSN sound
    self.BPSNType = self:GetNW2Int("BPSNType",13)
    if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
    if self.BPSNType ~= self.OldBPSNType then
        for i=1,12 do
            self:SetSoundState("bpsn"..i,0,1.0)
        end
    end
    self.OldBPSNType = self.BPSNType
    if self.BPSNType<13 then
        self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool("BPSN") and 1 or 0,1) --FIXME громкость по другому
    end

    local cabspeaker = self:GetPackedBool("AnnCab")
    local work = self:GetPackedBool("AnnPlay")
    local buzz = self:GetPackedBool("AnnBuzz") and self:GetNW2Bool("AnnouncerBuzz")
    for k in ipairs(self.AnnouncerPositions) do
        self:SetSoundState("announcer_buzz"..k,(buzz and (k ~= 1 and work or k==1 and cabspeaker)) and 1 or 0,1)
    end
    for k,v in ipairs(self.AnnouncerPositions) do
        if self.Sounds["announcer"..k] and IsValid(self.Sounds["announcer"..k]) then
            self.Sounds["announcer"..k]:SetVolume(1)
        end
    end
end

local ScreenMIRR = CreateMaterial("ScreenRT","UnlitGeneric")
function ENT:Draw()
    self.BaseClass.Draw(self)
    if IsValid(self.ClientEnts["lamps1"]) then
        self.ClientEnts["lamps1"]:SetSubMaterial(2,"!MetrostroiRT2") 
        self.RTMaterial2:SetTexture("$basetexture",self.ScreenKyiv)
    end
end 
function ENT:DrawPost(special)
    --local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))

    local distance = self:GetPos():Distance(LocalPlayer():GetPos())
    if distance > 1024 or special then return end
    self.RTMaterial:SetTexture("$basetexture", self.Schedule)
	self:DrawOnPanel("schedule", function(...)
			surface.SetMaterial(self.RTMaterial)
			surface.SetDrawColor(255, 255, 255)
			surface.DrawTexturedRectRotated(256, 128, 540, 256, 0)
	end)

    self.RTMaterial:SetTexture("$basetexture",self.LeftMirror)
    self:DrawOnPanel("MirrorScreen1", function()
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(64, 138, 128, 276, 0)
    end)

    self.RTMaterial:SetTexture("$basetexture",self.RightMirror)
    self:DrawOnPanel("MirrorScreen2", function()
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(64, 138, 128, 276, 0)
    end) 
    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
end

function ENT:OnButtonPressed(button)
    for i = 1 , 4 do 
    if button == "Motorolla_C"..i.."Set" and not self:GetNW2Bool("Motorolla_Channel" .. i) then
        self:PlayOnce("motorolla_on",Vector(414.709991,-23.400000,9.600000),1,1)
    end
    end 
    if button == "UnlockDoor" then 
        self:PlayOnce(self:GetNW2Bool("DoorLock") and "door_locker_on" or "door_locker_off",Vector(390-12.2,29+32,50.6),1,1)
    end 
    if button == "PrevSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
    if button == "NextSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end

    if button and button:sub(1,3) == "Num" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if soundid == "motorolla_on" then
           return "motorolla_on", location, 1, pitch 
    end 
    if location == "bass" then
        if soundid == "VDOL" then
            return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
        end
        if soundid == "VDOP" then
            return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
        end
        if soundid == "VDZ" then
            return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
        end
       
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK3" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk3_on" or "lk3_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK5" and range > 0 then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions["lk5_on"][1] = 350-Lerp(speed/0.1,0,250)
            return "lk5_on",location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "RVT" then
            return range > 0 and "rvt1_on" or "rvt_off",location,1,pitch
        end
        if soundid == "K6" then
            return range > 0 and "k6_on" or  "k6n_off",location,1,pitch
        end
        if soundid == "R1_5" then
            return range > 0 and "r1_5_on" or "r1_5_off",location,1,pitch
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd1_on" or "kd1_off",location,1,pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "K25" then
            return range > 0 and "k25_on" or "k25_off",location,1,pitch
        end
        if soundid == "RO" then
            return range > 0 and "ro1_on" or "ro1_off",location,1,pitch
        end
        if soundid == "Rp8" then
            return range > 0 and "rp8_on" or "rp8_off",location,1,pitch
        end
        if soundid == "ROT1" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "ROT2" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
    elseif soundid:sub(1,4)=="kv70" then return soundid .."_" .. self:GetNW2Int("KVSOUND", 1),location,range,pitch end
    return soundid,location,range,pitch
end
Metrostroi.GenerateClientProps()
