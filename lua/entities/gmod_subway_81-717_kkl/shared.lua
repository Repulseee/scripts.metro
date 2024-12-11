ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintName = "81-717 ККЛ (Номерной головной)"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Metrostroi (trains)"
ENT.SkinsType = "81-717_kyiv"
ENT.Model = "models/metrostroi_train/81-717/81-717_mvm.mdl"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false
ENT.DontAccelerateSimulation = false
function ENT:PassengerCapacity()
    return 300
end

function ENT:GetStandingArea()
    return Vector(-450,-30,-48),Vector(380,30,-48)
end

local function GetDoorPosition(i,k)
    return Vector(359.0 - 35/2 - 229.5*i,-65*(1-2*k),7.5)
end
ENT.AnnouncerPositions = {
    {Vector(420,-49 ,61),80,2},
    {Vector(-3,-60, 62),250,2},
    {Vector(-3,60 ,62),250,2},
    {Vector(0,0,0),250,2},
  --  {Vector(0,0,0),445.25,25,5.0-11.5+5.35},
}
ENT.Cameras = {
    {Vector(407.5+23,4,29),Angle(0,180,0),"Train.717.Breakers","AV_C"},
    {Vector(407.5+35,-49,20),Angle(0,180,0),"Train.717.VB","Battery_C"},
    {Vector(407.5+25,-40,27),Angle(0,180,0),"Train.717.Breakers","AV_R"},
    {Vector(407.5+20,-40.5,5.5),Angle(0,180,0),"Train.717.VB","Battery_R"},
    {Vector(407.5-0,-10.5,12),Angle(0,270-45,0),"Train.717.VBD","VBD_R"},
    {Vector(407.5+13,-47,-20),Angle(40,270-15,0),"Train.Common.UAVA"},
    {Vector(407.5+5,-20,-10),Angle(40,-30,0),"Train.Common.PneumoPanels"},
    {Vector(407.5+35,40,10),Angle(0,90-17,0),"Train.Common.HelpersPanel"},
    {Vector(407.5+31,18.8,0),Angle(30,0,0),"Train.Common.ASNP"},
    {Vector(407.5+39,-26.5,25),Angle(0,-20,0),"Train.Common.IGLA"},
    {Vector(407.5+70,51.5,0)  ,Angle(20,180+9,0),"Train.Common.RouteNumber"},
    {Vector(407.5+75,0.3,4.5)  ,Angle(20,180,0),"Train.Common.LastStation"},
    {Vector(450+7,0,30),Angle(60,0,0),"Train.Common.CouplerCamera"},
}

local ARSRelays = {"EK","EK1","KPK1","KPK2","FMM1","FMM2","PD1","PD2","ARS_VP","ARS_RT","NG","NH","BUM_RVD1","BUM_RVD2","BUM_RUVD","BUM_RB","BUM_TR","BUM_PTR","BUM_PTR1","BUM_EK","BUM_EK1","BUM_RVZ1","BUM_RET","BUM_LTR1","BUM_RVT1","BUM_RVT2","BUM_RVT4","BUM_RVT5","BUM_RIPP","BUM_PEK","BUM_KPP","BSM_GE","BSM_SIR1","BSM_SIR2","BSM_SIR3","BSM_SIR4","BSM_SIR5","BSM_SR1","BSM_SR2","BSM_KSR1","BSM_KSR2","BSM_KRO","BSM_KRH","BSM_KRT","BSM_BR1","BSM_BR2","BSM_PR1","BSM_RNT","BSM_RNT1","BLPM_1R1","BLPM_1R2","BLPM_1R3","BLPM_2R1","BLPM_2R2","BLPM_2R3","BLPM_3R1","BLPM_3R2","BLPM_3R3","BLPM_4R1","BLPM_4R2","BLPM_4R3","BLPM_5R1","BLPM_5R2","BLPM_5R3","BLPM_6R1","BLPM_6R2","BLPM_6R3","BIS_R0","BIS_R1","BIS_R2","BIS_R3","BIS_R4","BIS_R5","BIS_R6","BIS_R7","BIS_R8","BIS_R10",}
function ENT:InitializeSounds()
    self.BaseClass.InitializeSounds(self)
    self.SoundNames["rolling_5"] = {loop=true,"subway_trains/common/junk/junk_background3.wav"}
    self.SoundNames["rolling_10"] = {loop=true,"subway_trains/717/rolling/10_rolling.wav"}
    self.SoundNames["rolling_40"] = {loop=true,"subway_trains/717/rolling/40_rolling.wav"}
    self.SoundNames["rolling_70"] = {loop=true,"subway_trains/717/rolling/70_rolling.wav"}
    self.SoundNames["rolling_80"] = {loop=true,"subway_trains/717/rolling/80_rolling.wav"}
    self.SoundPositions["rolling_5"] = {480,1e12,Vector(0,0,0),0.15}
    self.SoundPositions["rolling_10"] = {480,1e12,Vector(0,0,0),0.20}
    self.SoundPositions["rolling_40"] = {480,1e12,Vector(0,0,0),0.55}
    self.SoundPositions["rolling_70"] = {480,1e12,Vector(0,0,0),0.60}
    self.SoundPositions["rolling_80"] = {480,1e12,Vector(0,0,0),0.75}
    
    self.SoundNames["av_on"] = "sl1desounds/automat_on.mp3"
    self.SoundNames["av_off"] = "sl1desounds/automat_off.mp3"
    local s = math.random(1,2)
    -- self.SoundNames["vu224_on"] = {"subway_trains/new_717c/common/switches/vu224_2/vu224_on1.mp3","subway_trains/new_717c/common/switches/vu224_2/vu224_on2.mp3","subway_trains/new_717c/common/switches/vu224_2/vu224_on3.mp3"}
    -- self.SoundNames["vu224_off"] = {"subway_trains/new_717c/common/switches/vu224_2/vu224_off1.mp3","subway_trains/new_717c/common/switches/vu224_2/vu224_off2.mp3","subway_trains/new_717c/common/switches/vu224_2/vu224_off3.mp3"}
    self.SoundNames["ro1_on"] = "717/spl/ro_on.mp3"
    self.SoundNames["ro1_off"] = "717/spl/ro_off.mp3"


    self.SoundNames["rolling_motors"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundNames["rolling_motors2"] = {loop=true,"subway_trains/common/junk/wind_background1.wav"}
    self.SoundPositions["rolling_motors"] = {250,1e12,Vector(200,0,0),0.33}
    self.SoundPositions["rolling_motors2"] = {250,1e12,Vector(-250,0,0),0.33}

    self.SoundNames["rolling_low"] = {loop=true,"subway_trains/717/rolling/rolling_outside_low.wav"}
    self.SoundNames["rolling_medium1"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium1.wav"}
    self.SoundNames["rolling_medium2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_medium2.wav"}
    self.SoundNames["rolling_high2"] = {loop=true,"subway_trains/717/rolling/rolling_outside_high2.wav"}
    self.SoundPositions["rolling_low"] = {480,1e12,Vector(0,0,0),0.6}
    self.SoundPositions["rolling_medium1"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_medium2"] = {480,1e12,Vector(0,0,0),0.90}
    self.SoundPositions["rolling_high2"] = {480,1e12,Vector(0,0,0),1.00}

    self.SoundNames["pneumo_disconnect2"] = "subway_trains/common/pneumatic/pneumo_close.mp3"
    self.SoundNames["pneumo_disconnect1"] = {
        "subway_trains/common/pneumatic/pneumo_open.mp3",
        "subway_trains/common/pneumatic/pneumo_open2.mp3",
    }
    self.SoundPositions["pneumo_disconnect2"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundPositions["pneumo_disconnect1"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),1}
    self.SoundNames["epv_on"]           = "subway_trains/common/pneumatic/epv_on.mp3"
    self.SoundNames["epv_off"]          = "subway_trains/common/pneumatic/epv_off.mp3"
    self.SoundPositions["epv_on"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.85}
    self.SoundPositions["epv_off"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.85}
    self.SoundPositions["epv_off"] = {60,1e9,Vector(437.2,-53.1,-32.0),0.85}
    -- Релюшки
    --self.SoundNames["rpb_on"] = "subway_trains/717/relays/new/ro_off.mp3"
    --self.SoundNames["rpb_off"] = "subway_trains/717/relays/ro_on.mp3"
    self.SoundNames["rpb_on"] = "subway_trains/717/relays/rev813t_on1.mp3"
    self.SoundNames["rpb_off"] = "subway_trains/717/relays/rev813t_off1.mp3"
    self.SoundPositions["rpb_on"] =     {80,1e9,Vector(440,16,66),1}
    self.SoundPositions["rpb_off"] =    {80,1e9,Vector(440,16,66),0.7}
    --self.SoundNames["rvt_on"] = "subway_trains/717/relays/new/rvt_on1.mp3"
    --self.SoundNames["rvt_off"] = "subway_trains/717/relays/new/rvt_off.mp3"
    self.SoundNames["rvt_on"] = "subway_trains/717/relays/rev811t_on2.mp3"
    self.SoundNames["rvt1_on"] = {"717/spb_additions/rvt_on2.mp3"}

    self.SoundNames["rvt_off"] = "subway_trains/717/relays/rev811t_off1.mp3"
    self.SoundPositions["rvt_on"] =     {80,1e9,Vector(440,18,66),1}
    self.SoundPositions["rvt1_on"] =     {80,1e9,Vector(440,18,66),1}
    self.SoundPositions["rvt_off"] =    {80,1e9,Vector(440,18,66),0.7}
    --self.SoundNames["k6_on"] = "subway_trains/717/relays/new/k6_on1.mp3"
    --self.SoundNames["k6_off"] = "subway_trains/717/relays/new/k6_off.mp3"
    self.SoundNames["k6_on"] = "subway_trains/717/relays/tkpm121_on1.mp3"

    self.SoundNames["k6_off"] = "subway_trains/717/relays/tkpm121_off1.mp3"
    self.SoundNames["k6n_off"] = "717/spb_additions/k6_off2.mp3"
    self.SoundPositions["k6_on"] =      {80,1e9,Vector(440,20,66),1}
    self.SoundPositions["k6_off"] = {80,1e9,Vector(440,20,66),1}
    self.SoundPositions["k6n_off"] = {80,1e9,Vector(440,20,66),1}
    --self.SoundNames["r1_5_on"] = "subway_trains/717/relays/new/r1_5_on.mp3"
    --self.SoundNames["r1_5_off"] = "subway_trains/717/relays/new/r1_5_off.mp3"
    self.SoundNames["r1_5_on"] = "subway_trains/717/relays/kpd110e_on1.mp3"--,"subway_trains/717/relays/kpd110e_on2.mp3"}
    self.SoundNames["r1_5_off"] = "subway_trains/717/relays/kpd110e_off1.mp3"--,"subway_trains/717/relays/kpd110e_off2.mp3"}
    self.SoundPositions["r1_5_on"] =    {80,1e9,Vector(440,22,66),1}
    self.SoundPositions["r1_5_off"] =   {80,1e9,Vector(440,22,66),0.7}

    self.SoundNames["rot_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["rot_on"] = "subway_trains/717/relays/relay_on.mp3"
    self.SoundPositions["rot_on"] = {80,1e9,Vector(380,-40,40),0.25}
    self.SoundPositions["rot_off"] = {80,1e9,Vector(380,-40,40),0.25}

    --self.SoundNames["k25_on"] = "subway_trains/717/relays/new/k25_on.mp3"
    --self.SoundNames["k25_off"] = "subway_trains/717/relays/new/k25_off.mp3"
    self.SoundNames["k25_on"] = self.SoundNames["r1_5_on"]
    self.SoundNames["k25_off"] = self.SoundNames["r1_5_off"]
    self.SoundPositions["k25_on"] =     {80,1e9,Vector(440,-16,66),1}
    self.SoundPositions["k25_off"] =    {80,1e9,Vector(440,-16,66),0.7}
    --self.SoundNames["rp8_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["rp8_on"] = "subway_trains/717/relays/rp8_on.wav"
    self.SoundNames["rp8_off"] = "subway_trains/717/relays/rev811t_off2.mp3"
    self.SoundNames["rp8_on"] = "subway_trains/717/relays/rev811t_on3.mp3"
    self.SoundPositions["rp8_on"] =     {80,1e9,Vector(440,-18,66),1}
    self.SoundPositions["rp8_off"] =    {80,1e9,Vector(440,-18,66),0.3}
    --self.SoundNames["kd_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["kd_on"] = "subway_trains/717/relays/new/kd_on.mp3"
    self.SoundNames["kd_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["kd_on"] = "subway_trains/717/relays/lsd_3.mp3"
    self.SoundNames["kd1_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["kd1_on"] = "subway_trains/717/relays/lsd_3.mp3"
    self.SoundPositions["kd_on"] =      {80,1e9,Vector(440,-20,66),1}
    self.SoundPositions["kd_off"] =     {80,1e9,Vector(440,-20,66),0.7}
    --self.SoundNames["ro_on"] = "subway_trains/717/relays/ro_on.mp3"
    --self.SoundNames["ro_off"] = "subway_trains/717/relays/new/ro_off.mp3"
    self.SoundNames["ro_on"] = self.SoundNames["r1_5_on"]
    self.SoundNames["ro_off"] = self.SoundNames["r1_5_off"]
    self.SoundPositions["ro_on"] =      {80,1e9,Vector(440,-22,66),1}
    self.SoundPositions["ro_off"] =     {80,1e9,Vector(440,-22,66),0.7}
    self.SoundPositions["ro1_on"] =      {80,1e9,Vector(440,-22,66),2}
    self.SoundPositions["ro1_off"] =      {80,1e9,Vector(440,-22,66),2}


    self.SoundNames["kk_off"] = "subway_trains/717/relays/lsd_2.mp3"
    self.SoundNames["kk_on"] = "subway_trains/717/relays/lsd_1.mp3"
    self.SoundPositions["kk_on"] =      {80,1e9,Vector(280,40,-30),0.85}
    self.SoundPositions["kk_off"] =     {80,1e9,Vector(280,40,-30),0.85}

    self.SoundNames["avu_off"] = "subway_trains/common/pneumatic/ak11b_off.mp3"
    self.SoundNames["avu_on"] = "subway_trains/common/pneumatic/ak11b_on.mp3"
    self.SoundPositions["avu_on"] = {60,1e9, Vector(432.4,-59.4,-31.6),0.7}
    self.SoundPositions["avu_off"] = self.SoundPositions["avu_on"]

    --self.SoundNames["avu_off"] = "subway_trains/717/relays/lsd_2.mp3"
    --self.SoundNames["avu_on"] = "subway_trains/717/relays/relay_on.mp3"
    --self.SoundPositions["avu_off"] = {60,1e9, Vector(436.0,-63,-25),1}
    --self.SoundNames["r1_5_close"] = {"subway_trains/drive_on3.wav","subway_trains/drive_on4.wav"}
    self.SoundNames["bpsn1"] = {"subway_trains/717/bpsn/bpsn_ohigh.wav", loop=true}
    self.SoundNames["bpsn2"] = {"subway_trains/717/bpsn/old.wav", loop=true}
    self.SoundNames["bpsn3"] = {"subway_trains/717/bpsn/bpsn_olow.wav", loop=true}
    self.SoundNames["bpsn4"] = {"subway_trains/717/bpsn/bpsn_spb.wav", loop=true}
    self.SoundNames["bpsn5"] = {"subway_trains/717/bpsn/bpsn_tkl.wav", loop=true}
    self.SoundNames["bpsn6"] = {"subway_trains/717/bpsn/bpsn_nnov.wav", loop=true}
    self.SoundNames["bpsn7"] = {"subway_trains/717/bpsn/bpsn_kiyv.wav", loop=true}
    self.SoundNames["bpsn8"] = {"subway_trains/717/bpsn/bpsn_old.wav", loop=true}
    self.SoundNames["bpsn9"] = {"subway_trains/717/bpsn/bpsn_1.wav", loop=true}
    self.SoundNames["bpsn10"] = {"subway_trains/717/bpsn/bpsn_2.wav", loop=true}
    self.SoundNames["bpsn11"] = {"subway_trains/717/bpsn/bpsn_piter.wav", loop=true}
    self.SoundNames["bpsn12"] = {"subway_trains/717/bpsn/bpsn1.wav", loop=true}
    self.SoundPositions["bpsn1"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn2"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn3"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn4"] = {500,1e9,Vector(0,45,-448),0.025}
    self.SoundPositions["bpsn5"] = {500,1e9,Vector(0,45,-448),0.08}
    self.SoundPositions["bpsn6"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn7"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn8"] = {500,1e9,Vector(0,45,-448),0.03}
    self.SoundPositions["bpsn9"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn10"] = {500,1e9,Vector(0,45,-448),0.02}
    self.SoundPositions["bpsn11"] = {500,1e9,Vector(0,45,-448),0.04}
    self.SoundPositions["bpsn12"] = {500,1e9,Vector(0,45,-448),0.04}
    --Подвагонка
    self.SoundNames["lk2_on"] = "subway_trains/717/pneumo/lk2_on.mp3"
    self.SoundNames["lk5_on"] = "subway_trains/717/pneumo/lk1_on.mp3"
    self.SoundNames["lk2_off"] = "subway_trains/717/pneumo/lk2_off.mp3"
    self.SoundNames["lk3_on"] = "subway_trains/717/pneumo/lk3_on.mp3"
    self.SoundNames["lk3_off"] = "subway_trains/717/pneumo/lk3_off.mp3"
    --self.SoundNames["ksh1_off"] = "subway_trains/717/pneumo/ksh1.mp3"
    self.SoundPositions["lk2_on"] = {440,1e9,Vector(-60,-40,-66),0.22}
    self.SoundPositions["lk5_on"] = {440,1e9,Vector(-60,-40,-66),0.30}
    self.SoundPositions["lk2_off"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_on"] = self.SoundPositions["lk2_on"]
    self.SoundPositions["lk3_off"] = self.SoundPositions["lk2_on"]
    --self.SoundPositions["ksh1_off"] = self.SoundPositions["lk1_on"]

    self.SoundNames["compressor"] = {loop=2.0,"subway_trains/d/pneumatic/compressor/compessor_d_start.wav","subway_trains/d/pneumatic/compressor/compessor_d_loop.wav", "subway_trains/d/pneumatic/compressor/compessor_d_end.wav"}
    self.SoundNames["compressor2"] = {loop=1.79,"subway_trains/717/compressor/compressor_717_start2.wav","subway_trains/717/compressor/compressor_717_loop2.wav", "subway_trains/717/compressor/compressor_717_stop2.wav"}
    self.SoundPositions["compressor"] = {600,1e9,Vector(-118,-40,-66),0.15}
    self.SoundPositions["compressor2"] = {480,1e9,Vector(-118,-40,-66),0.55}
    self.SoundNames["rk"] = {loop=0.8,"subway_trains/717/rk/rk_start.wav","subway_trains/717/rk/rk_spin.wav","subway_trains/717/rk/rk_stop.mp3"}
    self.SoundPositions["rk"] = {70,1e3,Vector(110,-40,-75),0.5}

    self.SoundNames["revers_0-f"] = {"717/spl/reverser_0_f.mp3"}
    self.SoundNames["revers_f-0"] = {"717/spl/reverser_b_0.mp3"}
    self.SoundNames["revers_0-b"] = {"717/spl/reverser_0_b.mp3"}
    self.SoundNames["revers_b-0"] = {"771/spl/reverser_b_0.mp3"}
    self.SoundNames["revers_in"] = {"717/spl/reverser_input.mp3"}
    self.SoundNames["revers_out"] = {"717/spl/reverser_n.mp3"}
    self.SoundPositions["revers_0-f"] = 	{80,1e9,Vector(445.5,-32+1.7,-7.5),1}
    self.SoundPositions["revers_f-0"] = 	{80,1e9,Vector(445.5,-32+1.7,-7.5),1}
    self.SoundPositions["revers_0-b"] = 	{80,1e9,Vector(445.5,-32+1.7,-7.5),0.85}
    self.SoundPositions["revers_b-0"] = 	{80,1e9,Vector(445.5,-32+1.7,-7.5),0.85}
    self.SoundPositions["revers_in"] = 		{80,1e9,Vector(445.5,-32+1.7,-7.5),5}
    self.SoundPositions["revers_out"] = 	{80,1e9,Vector(445.5,-32+1.7,-7.5),4}

    self.SoundNames["kru_in"] = {
        "subway_trains/717/kru/kru_insert1.mp3",
        "subway_trains/717/kru/kru_insert2.mp3"
    }
    self.SoundPositions["kru_in"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundNames["kru_out"] = {
        "subway_trains/717/kru/kru_eject1.mp3",
        "subway_trains/717/kru/kru_eject2.mp3",
        "subway_trains/717/kru/kru_eject3.mp3",
    }
    self.SoundPositions["kru_out"] = {80,1e9,Vector(452.3,-24.0,4.0)}

    self.SoundNames["kru_0_1"] = {
        "subway_trains/717/kru/kru0-1_1.mp3",
        "subway_trains/717/kru/kru0-1_2.mp3",
        "subway_trains/717/kru/kru0-1_3.mp3",
        "subway_trains/717/kru/kru0-1_4.mp3",
    }
    self.SoundNames["kru_1_2"] = {
        "subway_trains/717/kru/kru1-2_1.mp3",
        "subway_trains/717/kru/kru1-2_2.mp3",
        "subway_trains/717/kru/kru1-2_3.mp3",
        "subway_trains/717/kru/kru1-2_4.mp3",
    }
    self.SoundNames["kru_2_1"] = {
        "subway_trains/717/kru/kru2-1_1.mp3",
        "subway_trains/717/kru/kru2-1_2.mp3",
        "subway_trains/717/kru/kru2-1_3.mp3",
        "subway_trains/717/kru/kru2-1_4.mp3",
    }
    self.SoundNames["kru_1_0"] = {
        "subway_trains/717/kru/kru1-0_1.mp3",
        "subway_trains/717/kru/kru1-0_2.mp3",
        "subway_trains/717/kru/kru1-0_3.mp3",
        "subway_trains/717/kru/kru1-0_4.mp3",
    }
    self.SoundNames["kru_2_3"] = {
        "subway_trains/717/kru/kru2-3_1.mp3",
        "subway_trains/717/kru/kru2-3_2.mp3",
        "subway_trains/717/kru/kru2-3_3.mp3",
        "subway_trains/717/kru/kru2-3_4.mp3",
    }
    self.SoundNames["kru_3_2"] = {
        "subway_trains/717/kru/kru3-2_1.mp3",
        "subway_trains/717/kru/kru3-2_2.mp3",
        "subway_trains/717/kru/kru3-2_3.mp3",
        "subway_trains/717/kru/kru3-2_4.mp3",
    }
    self.SoundPositions["kru_0_1"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_1_2"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_2_1"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_1_0"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_2_3"] = {80,1e9,Vector(452.3,-24.0,4.0)}
    self.SoundPositions["kru_3_2"] = {80,1e9,Vector(452.3,-24.0,4.0)}


    --[[self.SoundNames["pvk_0_1"] = "subway_trains/717/switches/vent0-1.mp3"
    self.SoundNames["pvk_1_2"] = "subway_trains/717/switches/vent1-2.mp3"
    self.SoundNames["pvk_2_1"] = "subway_trains/717/switches/vent2-1.mp3"
    self.SoundNames["pvk_1_0"] = "subway_trains/717/switches/vent1-0.mp3"]]
    --self.SoundNames["pvk_0_1"] = "subway_trains/717/switches/vent0-1.mp3"
    self.SoundNames["pvk2"] = "subway_trains/717/switches/vent1-2.mp3"
    self.SoundNames["pvk1"] = "subway_trains/717/switches/vent2-1.mp3"
    self.SoundNames["pvk0"] = "subway_trains/717/switches/vent1-0.mp3"
    self.SoundNames["vent_cabl"] = {loop=true,"subway_trains/717/vent/vent_cab_low.wav"}
    self.SoundPositions["vent_cabl"] = {140,1e9,Vector(450.7,44.5,-11.9),0.66}
    self.SoundNames["vent_cabh"] = {loop=true,"subway_trains/717/vent/vent_cab_high.wav"}
    self.SoundPositions["vent_cabh"] = self.SoundPositions["vent_cabl"]

    for i=1,7 do
        self.SoundNames["vent"..i] = {loop=true,"subway_trains/717/vent/vent_cab_"..(i==7 and "low" or "high")..".wav"}
    end
    self.SoundPositions["vent1"] = {120,1e9,Vector(225,  -50, -37.5),0.23}
    self.SoundPositions["vent2"] = {120,1e9,Vector(-5,    50, -37.5),0.23}
    self.SoundPositions["vent3"] = {120,1e9,Vector(-230, -50, -37.5),0.23}
    self.SoundPositions["vent4"] = {120,1e9,Vector(225,   50, -37.5),0.23}
    self.SoundPositions["vent5"] = {120,1e9,Vector(-5,   -50, -37.5),0.23}
    self.SoundPositions["vent6"] = {120,1e9,Vector(-230,  50, -37.5),0.23}
    self.SoundPositions["vent7"] = {120,1e9,Vector(-432, -50, -37.5),0.23}

    self.SoundNames["kr_open"] = {
        "subway_trains/new_717c/717/cover/cover_open1.mp3",
        "subway_trains/new_717c/717/cover/cover_open2.mp3",
        "subway_trains/new_717c/717/cover/cover_open3.mp3",
    }
    self.SoundNames["kr_close"] = {
        "subway_trains/new_717c/717/cover/cover_close1.mp3",
        "subway_trains/new_717c/717/cover/cover_close2.mp3",
        "subway_trains/new_717c/717/cover/cover_close3.mp3",
    }

    self.SoundNames["switch_off"] = {
        "subway_trains/717/switches/tumbler_slim_off1.mp3",
        "subway_trains/717/switches/tumbler_slim_off2.mp3",
        "subway_trains/717/switches/tumbler_slim_off3.mp3",
        "subway_trains/717/switches/tumbler_slim_off4.mp3",
    }
    self.SoundNames["switch_on"] = {
        "subway_trains/717/switches/tumbler_slim_on1.mp3",
        "subway_trains/717/switches/tumbler_slim_on2.mp3",
        "subway_trains/717/switches/tumbler_slim_on3.mp3",
        "subway_trains/717/switches/tumbler_slim_on4.mp3",
    }

    self.SoundNames["switchbl_off"] = {
        "subway_trains/717/switches/tumbler_fatb_off1.mp3",
        "subway_trains/717/switches/tumbler_fatb_off2.mp3",
        "subway_trains/717/switches/tumbler_fatb_off3.mp3",
    }
    self.SoundNames["switchbl_on"] = {
        "subway_trains/717/switches/tumbler_fatb_on1.mp3",
        "subway_trains/717/switches/tumbler_fatb_on2.mp3",
        "subway_trains/717/switches/tumbler_fatb_on3.mp3",
    }

    self.SoundNames["triple_down-0"] = {
        "subway_trains/717/switches/tumbler_triple_down-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_down-0_2.mp3",
    }
    self.SoundNames["triple_0-up"] = {
        "subway_trains/717/switches/tumbler_triple_0-up_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-up_2.mp3",
    }
    self.SoundNames["triple_up-0"] = {
        "subway_trains/717/switches/tumbler_triple_up-0_1.mp3",
        "subway_trains/717/switches/tumbler_triple_up-0_2.mp3",
    }
    self.SoundNames["triple_0-down"] = {
        "subway_trains/717/switches/tumbler_triple_0-down_1.mp3",
        "subway_trains/717/switches/tumbler_triple_0-down_2.mp3",
    }
    self.SoundNames["button1_off"] = {
        "subway_trains/717/switches/button1_off1.mp3",
        "subway_trains/717/switches/button1_off2.mp3",
        "subway_trains/717/switches/button1_off3.mp3",
    }
    self.SoundNames["button1_on"] = {
        "subway_trains/717/switches/button1_on1.mp3",
        "subway_trains/717/switches/button1_on2.mp3",
        "subway_trains/717/switches/button1_on3.mp3",
    }
    self.SoundNames["button2_off"] = {
        "subway_trains/717/switches/button2_off1.mp3",
        "subway_trains/717/switches/button2_off2.mp3",
    }
    self.SoundNames["button2_on"] = {
        "subway_trains/717/switches/button2_on1.mp3",
        "subway_trains/717/switches/button2_on2.mp3",
    }
    self.SoundNames["button3_off"] = {
        "subway_trains/717/switches/button3_off1.mp3",
        "subway_trains/717/switches/button3_off2.mp3",
    }
    self.SoundNames["button3_on"] = {
        "subway_trains/717/switches/button3_on1.mp3",
        "subway_trains/717/switches/button3_on2.mp3",
    }
    self.SoundNames["button4_off"] = {
        "subway_trains/717/switches/button4_off1.mp3",
        "subway_trains/717/switches/button4_off2.mp3",
    }
    self.SoundNames["button4_on"] = {
        "subway_trains/717/switches/button4_on1.mp3",
        "subway_trains/717/switches/button4_on2.mp3",
    }

    self.SoundNames["uava_reset"] = {
        "subway_trains/common/uava/uava_reset1.mp3",
        "subway_trains/common/uava/uava_reset2.mp3",
        "subway_trains/common/uava/uava_reset4.mp3",
    }
    self.SoundPositions["uava_reset"] = {80,1e9,Vector(429.6,-60.8,-15.9),0.95}
    self.SoundNames["gv_f"] = {"subway_trains/717/kv70/reverser_0-b_1.mp3","subway_trains/717/kv70/reverser_0-b_2.mp3"}
    self.SoundNames["gv_b"] = {"subway_trains/717/kv70/reverser_b-0_1.mp3","subway_trains/717/kv70/reverser_b-0_2.mp3"}

    self.SoundNames["pneumo_TL_open"] = {
        "subway_trains/ezh3/pneumatic/brake_line_on.mp3",
        "subway_trains/ezh3/pneumatic/brake_line_on2.mp3",
    }
    self.SoundNames["pneumo_TL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundPositions["pneumo_TL_open"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),0.7}
    self.SoundPositions["pneumo_TL_disconnect"] = {60,1e9,Vector(431.8,-24.1+1.5,-33.7),0.7}
    self.SoundNames["pneumo_BL_disconnect"] = {
        "subway_trains/common/334/334_close.mp3",
    }
    self.SoundNames["disconnect_valve"] = "subway_trains/common/switches/pneumo_disconnect_switch.mp3"

    self.SoundNames["brake_f"] = {"subway_trains/common/pneumatic/vz_brake_on2.mp3","subway_trains/common/pneumatic/vz_brake_on3.mp3","subway_trains/common/pneumatic/vz_brake_on4.mp3"}
    self.SoundPositions["brake_f"] = {50,1e9,Vector(317-8,0,-82),0.13}
    self.SoundNames["brake_b"] = self.SoundNames["brake_f"]
    self.SoundPositions["brake_b"] = {50,1e9,Vector(-317+0,0,-82),0.13}
    self.SoundNames["release1"] = {loop=true,"subway_trains/common/pneumatic/release_0.wav"}
    self.SoundPositions["release1"] = {350,1e9,Vector(-183,0,-70),1}
    self.SoundNames["release2"] = {loop=true,"subway_trains/common/pneumatic/release_low.wav"}
    self.SoundPositions["release2"] = {350,1e9,Vector(-183,0,-70),0.4}

    self.SoundNames["parking_brake"] = {loop=true,"subway_trains/common/pneumatic/parking_brake.wav"}
    self.SoundNames["parking_brake_en"] = "subway_trains/common/pneumatic/parking_brake_stop.mp3"
    self.SoundNames["parking_brake_rel"] = "subway_trains/common/pneumatic/parking_brake_stop2.mp3"
    self.SoundPositions["parking_brake"] = {80,1e9,Vector(410.45,-40.15,-30.5),0.6}
    self.SoundPositions["parking_brake_en"] = self.SoundPositions["parking_brake"]
    self.SoundPositions["parking_brake_rel"] = self.SoundPositions["parking_brake"]
    self.SoundNames["front_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["front_isolation"] = {300,1e9,Vector(443, 0,-63),1}
    self.SoundNames["rear_isolation"] = {loop=true,"subway_trains/common/pneumatic/isolation_leak.wav"}
    self.SoundPositions["rear_isolation"] = {300,1e9,Vector(-456, 0,-63),1}

    self.SoundNames["crane013_brake"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_brake2"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake2"] = {80,1e9,Vector(431.5,-20.3,-12),0.86}
    self.SoundNames["crane013_brake_l"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_brake_l"] = {80,1e9,Vector(431.5,-20.3,-12),0.7}
    self.SoundNames["crane013_release"] = {loop=true,"subway_trains/common/pneumatic/013_brake2.wav"}
    self.SoundPositions["crane013_release"] = {80,1e9,Vector(431.5,-20.3,-12),0.4}
    self.SoundNames["crane334_brake_high"] = {loop=true,"subway_trains/common/pneumatic/334_brake.wav"}
    self.SoundPositions["crane334_brake_high"] = {80,1e9,Vector(432.27,-22.83,-8.2),0.85}
    self.SoundNames["crane334_brake_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_low"] = {80,1e9,Vector(432.27,-22.83,-8.2),0.75}
    self.SoundNames["crane334_brake_2"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow.wav"}
    self.SoundPositions["crane334_brake_2"] = {80,1e9,Vector(432.27,-22.83,-8.2),0.85}
    self.SoundNames["crane334_brake_eq_high"] = {loop=true,"subway_trains/common/pneumatic/334_release_reservuar.wav"}
    self.SoundPositions["crane334_brake_eq_high"] = {80,1e9,Vector(432.27,-22.83,-70.2),0.2}
    self.SoundNames["crane334_brake_eq_low"] = {loop=true,"subway_trains/common/pneumatic/334_brake_slow2.wav"}
    self.SoundPositions["crane334_brake_eq_low"] = {80,1e9,Vector(432.27,-22.83,-70.2),0.2}
    self.SoundNames["crane334_release"] = {loop=true,"subway_trains/common/pneumatic/334_release3.wav"}
    self.SoundPositions["crane334_release"] = {80,1e9,Vector(432.27,-22.83,-8.2),0.2}
    self.SoundNames["crane334_release_2"] = {loop=true,"subway_trains/common/pneumatic/334_release2.wav"}
    self.SoundPositions["crane334_release_2"] = {80,1e9,Vector(432.27,-22.83,-8.2),0.2}

    self.SoundNames["epk_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["epk_brake"] = {80,1e9,Vector(437.2,-53.1,-32.0),0.65}

    self.SoundNames["valve_brake"] = {loop=true,"subway_trains/common/pneumatic/epv_loop.wav"}
    self.SoundPositions["valve_brake"] = {80,1e9,Vector(408.45,62.15,11.5),1}
    --[[ self.SoundNames["valve_brake_l"] = {loop=true,"subway_trains/common/pneumatic/emer_low.wav"}
    self.SoundNames["valve_brake_m"] = {loop=true,"subway_trains/common/pneumatic/emer_medium.wav"}
    self.SoundNames["valve_brake_h"] = {loop=true,"subway_trains/common/pneumatic/emer_high.wav"}
    self.SoundPositions["valve_brake_l"] = {80,1e9,Vector(408.45,62.15,11.5),0.3}
    self.SoundPositions["valve_brake_m"] = {80,1e9,Vector(408.45,62.15,11.5),0.4}
    self.SoundPositions["valve_brake_h"] = {80,1e9,Vector(408.45,62.15,11.5),1}--]]

    self.SoundNames["emer_brake"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop.wav"}
    self.SoundNames["emer_brake2"] = {loop=true,"subway_trains/common/pneumatic/autostop_loop_2.wav"}
    self.SoundPositions["emer_brake"] = {600,1e9,Vector(345,-55,-84),0.95}
    self.SoundPositions["emer_brake2"] = {600,1e9,Vector(345,-55,-84),1}


    self.SoundNames["pak_on"] = "subway_trains/717/switches/rc_on.mp3"
    self.SoundNames["pak_off"] = "subway_trains/717/switches/rc_off.mp3"

    --[[self.SoundNames["kv70_fix_on"] = {"subway_trains/717/kv70/kv70_fix_on1.mp3","subway_trains/717/kv70/kv70_fix_on2.mp3"}
    self.SoundNames["kv70_fix_off"] = {"subway_trains/717/kv70/kv70_fix_off1.mp3","subway_trains/717/kv70/kv70_fix_off2.mp3"}
    self.SoundNames["kv70_t1_0_fix"]= {"subway_trains/717/kv70/kv70_t1-0_fix_1.mp3","subway_trains/717/kv70/kv70_t1-0_fix_2.mp3","subway_trains/717/kv70/kv70_t1-0_fix_3.mp3","subway_trains/717/kv70/kv70_t1-0_fix_4.mp3"}
    self.SoundNames["kv70_0_t1"] = {"subway_trains/ezh/kv40/kv40_0_t1.mp3"}
    self.SoundNames["kv70_t1_0"] = {"subway_trains/ezh/kv40/kv40_t1_0.mp3"}
    self.SoundNames["kv70_t1_t1a"] = {"subway_trains/ezh/kv40/kv40_t1_t1a.mp3"}
    self.SoundNames["kv70_t1a_t1"] = {"subway_trains/ezh/kv40/kv40_t1a_t1.mp3"}
    self.SoundNames["kv70_t1a_t2"] = {"subway_trains/ezh/kv40/kv40_t1a_t2.mp3"}
    self.SoundNames["kv70_t2_t1a"] = {"subway_trains/ezh/kv40/kv40_t2_t1a.mp3"}
    self.SoundNames["kv70_0_x1"] = {"subway_trains/ezh/kv40/kv40_0_x1.mp3"}
    self.SoundNames["kv70_x1_0"] = {"subway_trains/ezh/kv40/kv40_x1_0.mp3"}
    self.SoundNames["kv70_x1_x2"] = {"subway_trains/ezh/kv40/kv40_x1_x2.mp3"}
    self.SoundNames["kv70_x2_x1"] = {"subway_trains/ezh/kv40/kv40_x2_x1.mp3"}
    self.SoundNames["kv70_x2_x3"] = {"subway_trains/ezh/kv40/kv40_x2_x3.mp3"}
    self.SoundNames["kv70_x3_x2"] = {"subway_trains/ezh/kv40/kv40_x3_x2.mp3"}--]]

    self.SoundNames["kv70_0_t1_1"] = "717/kkl/t1.mp3"
    self.SoundNames["kv70_t1_0_fix_1"]= "717/kkl/0.mp3"
    self.SoundNames["kv70_t1_0_1"] = "717/kkl/0.mp3"
    self.SoundNames["kv70_t1_t1a_1"] = "717/kkl/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_1"] = "717/kkl/t1.mp3"
    self.SoundNames["kv70_t1a_t2_1"] = "717/kkl/t2.mp3"
    self.SoundNames["kv70_t2_t1a_1"] = "717/kkl/t1a.mp3"
    self.SoundNames["kv70_0_x1_1"] = "717/5k/0-x1.mp3"
    self.SoundNames["kv70_x1_0_1"] = "717/5k/x1-0.mp3"
    self.SoundNames["kv70_x1_x2_1"] = "717/kkl/x2.mp3"
    self.SoundNames["kv70_x2_x1_1"] = "717/kkl/x1.mp3"
    self.SoundNames["kv70_x2_x3_1"] = "717/5k/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2_1"] = "717/kkl/x2.mp3"
    self.SoundNames["kv70_0_t1_2"] = "subway_trains/717/kv70_4/kv70_0_t1.mp3"
    self.SoundNames["kv70_t1_0_2"] = "subway_trains/717/kv70_4/kv70_t1_0.mp3"
    self.SoundNames["kv70_t1_t1a_2"] = "subway_trains/717/kv70_4/kv70_t1_t1a.mp3"
    self.SoundNames["kv70_t1a_t1_2"] = "subway_trains/717/kv70_4/kv70_t1a_t1.mp3"
    self.SoundNames["kv70_t1a_t2_2"] = "subway_trains/717/kv70_4/kv70_t1a_t2.mp3"
    self.SoundNames["kv70_t2_t1a_2"] = "subway_trains/717/kv70_4/kv70_t2_t1a.mp3"
    self.SoundNames["kv70_0_x1_2"] = "subway_trains/717/kv70_4/kv70_0_x1.mp3"
    self.SoundNames["kv70_x1_0_2"] = "subway_trains/717/kv70_4/kv70_x1_0.mp3"
    self.SoundNames["kv70_x1_x2_2"] = "subway_trains/717/kv70_4/kv70_x1_x2.mp3"
    self.SoundNames["kv70_x2_x1_2"] = "subway_trains/717/kv70_4/kv70_x2_x1.mp3"
    self.SoundNames["kv70_x2_x3_2"] = "subway_trains/717/kv70_4/kv70_x2_x3.mp3"
    self.SoundNames["kv70_x3_x2_2"] = "subway_trains/717/kv70_4/kv70_x3_x2.mp3"
    self.SoundNames["kv70_0_t1_3"] = "717/kkl_d/t1.mp3"
    self.SoundNames["kv70_t1_0_3"] = "717/kkl_d/0.mp3"
    self.SoundNames["kv70_t1_t1a_3"] = "717/kkl_d/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_3"] = "717/kkl_d/t1.mp3"
    self.SoundNames["kv70_t1a_t2_3"] = "717/kkl_d/t2.mp3"
    self.SoundNames["kv70_t2_t1a_3"] = "717/kkl_d/t1a.mp3"
    self.SoundNames["kv70_0_x1_3"] = "717/kkl_d/x1.mp3"
    self.SoundNames["kv70_x1_0_3"] = "717/kkl_d/0.mp3"
    self.SoundNames["kv70_x1_x2_3"] = "717/kkl_d/x2.mp3"
    self.SoundNames["kv70_x2_x1_3"] = "717/kkl_d/x1.mp3"
    self.SoundNames["kv70_x2_x3_3"] = "717/kkl_d/x3.mp3"
    self.SoundNames["kv70_x3_x2_3"] = "717/kkl_d/x2.mp3" 
    self.SoundNames["kv70_0_t1_4"] = "717/sbp/kv70_0_t1.mp3"
    self.SoundNames["kv70_t1_0_4"] = "717/sbp/kv70_t1_0.mp3"
    self.SoundNames["kv70_t1_t1a_4"] = "717/sbp/kv70_t1_t1a.mp3"
    self.SoundNames["kv70_t1a_t1_4"] = "717/sbp/kv70_t1a_t1.mp3"
    self.SoundNames["kv70_t1a_t2_4"] = "717/sbp/kv70_t1a_t2.mp3"
    self.SoundNames["kv70_t2_t1a_4"] = "717/sbp/kv70_t2_t1a.mp3"
    self.SoundNames["kv70_0_x1_4"] = "717/sbp/kv70_0_x1.mp3"
    self.SoundNames["kv70_x1_0_4"] = "717/sbp/kv70_x1_0.mp3"
    self.SoundNames["kv70_x1_x2_4"] = "717/sbp/kv70_x1_x2.mp3"
    self.SoundNames["kv70_x2_x1_4"] = "717/sbp/kv70_x2_x1.mp3"
    self.SoundNames["kv70_x2_x3_4"] = "717/sbp/kv70_x2_x3.mp3"
    self.SoundNames["kv70_x3_x2_4"] = "717/sbp/kv70_x3_x2.mp3"
    self.SoundNames["kv70_0_t1_5"] = "717/spl/0-t1.mp3"
    self.SoundNames["kv70_t1_0_5"] = "717/spl/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_5"] = "717/spl/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1_5"] = "717/spl/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_5"] = "717/spl/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a_5"] = "717/spl/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_5"] = "717/spl/0-x1.mp3"
    self.SoundNames["kv70_x1_0_5"] = "717/spl/x1-0.mp3"
    self.SoundNames["kv70_x1_x2_5"] = "717/spl/x1-x2.mp3"
    self.SoundNames["kv70_x2_x1_5"] = "717/spl/x2-x1.mp3"
    self.SoundNames["kv70_x2_x3_5"] = "717/spl/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2_5"] = "717/spl/x3-x2.mp3"
    self.SoundNames["kv70_0_t1_6"] = "717/sbl_2/t1.mp3"
    self.SoundNames["kv70_t1_0_6"] = "717/sbl_2/0.mp3"
    self.SoundNames["kv70_t1_t1a_6"] = "717/sbl_2/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_6"] = "717/sbl_2/t1.mp3"
    self.SoundNames["kv70_t1a_t2_6"] = "717/sbl_2/t2.mp3"
    self.SoundNames["kv70_t2_t1a_6"] = "717/sbl_2/t1a.mp3"
    self.SoundNames["kv70_0_x1_6"] = "717/sbl_2/x1.mp3"
    self.SoundNames["kv70_x1_0_6"] = "717/sbl_2/0.mp3"
    self.SoundNames["kv70_x1_x2_6"] = "717/sbl_2/x2.mp3"
    self.SoundNames["kv70_x2_x1_6"] = "717/sbl_2/x1.mp3"
    self.SoundNames["kv70_x2_x3_6"] = "717/sbl_2/x3.mp3"
    self.SoundNames["kv70_x3_x2_6"] = "717/sbl_2/x2.mp3"
    self.SoundNames["kv70_0_t1_7"] = "717/spl_2/t1.mp3"
    self.SoundNames["kv70_t1_0_7"] = "717/spl_2/0.mp3"
    self.SoundNames["kv70_t1_t1a_7"] = "717/spl_2/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_7"] = "717/spl_2/t1.mp3"
    self.SoundNames["kv70_t1a_t2_7"] = "717/spl_2/t2.mp3"
    self.SoundNames["kv70_t2_t1a_7"] = "717/spl_2/t1a.mp3"
    self.SoundNames["kv70_0_x1_7"] = "717/spl_2/x1.mp3"
    self.SoundNames["kv70_x1_0_7"] = "717/spl_2/0.mp3"
    self.SoundNames["kv70_x1_x2_7"] = "717/spl_2/x2.mp3"
    self.SoundNames["kv70_x2_x1_7"] = "717/spl_2/x1.mp3"
    self.SoundNames["kv70_x2_x3_7"] = "717/spl_2/x3.mp3"
    self.SoundNames["kv70_x3_x2_7"] = "717/spl_2/x2.mp3"
    self.SoundNames["kv70_0_t1_8"] = "717/spl_2/t1.mp3"
    self.SoundNames["kv70_t1_0_8"] = "717/spl_2/0.mp3"
    self.SoundNames["kv70_t1_t1a_8"] = "717/spl_3/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_8"] = "717/spl_3/t1.mp3"
    self.SoundNames["kv70_t1a_t2_8"] = "717/spl_3/t2.mp3"
    self.SoundNames["kv70_t2_t1a_8"] = "717/spl_3/t1a.mp3"
    self.SoundNames["kv70_0_x1_8"] = "717/spl_3/x1.mp3"
    self.SoundNames["kv70_x1_0_8"] = "717/spl_3/0.mp3"
    self.SoundNames["kv70_x1_x2_8"] = "717/spl_3/x2.mp3"
    self.SoundNames["kv70_x2_x1_8"] = "717/spl_3/x1.mp3"
    self.SoundNames["kv70_x2_x3_8"] = "717/spl_3/x3.mp3"
    self.SoundNames["kv70_x3_x2_8"] = "717/spl_3/x2.mp3"
    self.SoundNames["kv70_0_t1_9"] = "717/sbl_5m/t1-0.mp3"
    self.SoundNames["kv70_t1_0_9"] = "717/sbl_5m/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_9"] = "717/sbl_5m/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t1_9"] = "717/sbl_5m/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_9"] = "717/sbl_5m/t2-t1a.mp3"
    self.SoundNames["kv70_t2_t1a_9"] = "717/sbl_5m/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_9"] = "subway_trains/717/kv70/kv70_x1-0_1.mp3"
    self.SoundNames["kv70_x1_0_9"] = "717/sbl_5m/t1-0.mp3"
    self.SoundNames["kv70_x1_x2_9"] = "subway_trains/717/kv70/kv70_x1-x2_1.mp3"
    self.SoundNames["kv70_x2_x1_9"] = "subway_trains/717/kv70/kv70_x2-x1_1.mp3"
    self.SoundNames["kv70_x2_x3_9"] = "subway_trains/717/kv70/kv70_x2-x3_1.mp3"
    self.SoundNames["kv70_x3_x2_9"] = "subway_trains/717/kv70/kv70_x3-x2_1.mp3"
    self.SoundNames["kv70_0_t1_10"] = "717/spl_4/t1.mp3"
    self.SoundNames["kv70_t1_0_10"] = "717/spl_4/0.mp3"
    self.SoundNames["kv70_t1_t1a_10"] = "717/spl_4/t1a.mp3"
    self.SoundNames["kv70_t1a_t1_10"] = "717/spl_4/t1.mp3"
    self.SoundNames["kv70_t1a_t2_10"] = "717/spl_4/t2.mp3"
    self.SoundNames["kv70_t2_t1a_10"] = "717/spl_4/t1a.mp3"
    self.SoundNames["kv70_0_x1_10"] = "717/spl_4/x1.mp3"
    self.SoundNames["kv70_x1_0_10"] = "717/spl_4/0.mp3"
    self.SoundNames["kv70_x1_x2_10"] = "717/spl_4/x2.mp3"
    self.SoundNames["kv70_x2_x1_10"] = "717/spl_4/x1.mp3"
    self.SoundNames["kv70_x2_x3_10"] = "717/spl_4/x3.mp3"
    self.SoundNames["kv70_x3_x2_10"] = "717/spl_4/x2.mp3"
    self.SoundNames["kv70_0_t1_11"] = "717/spl_5/kv70_0_t1.mp3"
    self.SoundNames["kv70_t1_0_11"] = "717/spl_5/kv70_t1_0.mp3"
    self.SoundNames["kv70_t1_t1a_11"] = "717/spl_5/kv70_t1_t1a.mp3"
    self.SoundNames["kv70_t1a_t1_11"] = "717/spl_5/kv70_t1a_t1.mp3"
    self.SoundNames["kv70_t1a_t2_11"] = "717/spl_5/kv70_t1a_t2.mp3"
    self.SoundNames["kv70_t2_t1a_11"] = "717/spl_5/kv70_t2_t1a.mp3"
    self.SoundNames["kv70_0_x1_11"] = "717/spl_5/kv70_0_x1.mp3"
    self.SoundNames["kv70_x1_0_11"] = "717/spl_5/kv70_x1_0.mp3"
    self.SoundNames["kv70_x1_x2_11"] = "717/spl_5/kv70_x1_x2.mp3"
    self.SoundNames["kv70_x2_x1_11"] = "717/spl_5/kv70_x2_x1.mp3"
    self.SoundNames["kv70_x2_x3_11"] = "717/spl_5/kv70_x2_x3.mp3"
    self.SoundNames["kv70_x3_x2_11"] = "717/spl_5/kv70_x3_x2.mp3"
    --
    self.SoundNames["kv70_0_t1_12"] = "717/smr/0-t1.mp3"
    self.SoundNames["kv70_t1_0_12"] = "717/smr/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_12"] = "717/smr/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1_12"] = "717/smr/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_12"] = "717/smr/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a_12"] = "717/smr/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_12"] = "717/spl_5/kv70_0_x1.mp3"
    self.SoundNames["kv70_x1_0_12"] = "717/spl_5/kv70_x1_0.mp3"
    self.SoundNames["kv70_x1_x2_12"] = "717/spl_5/kv70_x1_x2.mp3"
    self.SoundNames["kv70_x2_x1_12"] = "717/spl_5/kv70_x2_x1.mp3"
    self.SoundNames["kv70_x2_x3_12"] = "717/spl_5/kv70_x2_x3.mp3"
    self.SoundNames["kv70_x3_x2_12"] = "717/spl_5/kv70_x3_x2.mp3"
    --
    self.SoundNames["kv70_0_t1_13"] = "717/spl_6/0-t1.mp3"
    self.SoundNames["kv70_t1_0_13"] = "717/spl_6/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_13"] = "717/spl_6/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1_13"] = "717/spl_6/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_13"] = "717/spl_6/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a_13"] = "717/spl_6/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_13"] = "717/spl_6/0-x1.mp3"
    self.SoundNames["kv70_x1_0_13"] = "717/spl_6/x1-0.mp3"
    self.SoundNames["kv70_x1_x2_13"] = "717/spl_6/x1-x2.mp3"
    self.SoundNames["kv70_x2_x1_13"] = "717/spl_6/x2-x1.mp3"
    self.SoundNames["kv70_x2_x3_13"] = "717/spl_6/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2_13"] = "717/spl_6/x3-x2.mp3"
    --
    self.SoundNames["kv70_0_t1_14"] = "717/msk_1/0-t1.mp3"
    self.SoundNames["kv70_t1_0_14"] = "717/msk_1/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_14"] = "717/msk_1/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1_14"] = "717/msk_1/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_14"] = "717/msk_1/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a_14"] = "717/msk_1/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_14"] = "717/msk_1/0-x1.mp3"
    self.SoundNames["kv70_x1_0_14"] = "717/msk_1/x1-0.mp3"
    self.SoundNames["kv70_x1_x2_14"] = "717/msk_1/x1-x2.mp3"
    self.SoundNames["kv70_x2_x1_14"] = "717/msk_1/x2-x1.mp3"
    self.SoundNames["kv70_x2_x3_14"] = "717/msk_1/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2_14"] = "717/msk_1/x3-x2.mp3"
    --
    self.SoundNames["kv70_0_t1_15"] = "717/msk_2/0-t1.mp3"
    self.SoundNames["kv70_t1_0_15"] = "717/msk_2/t1-0.mp3"
    self.SoundNames["kv70_t1_t1a_15"] = "717/msk_2/t1-t1a.mp3"
    self.SoundNames["kv70_t1a_t1_15"] = "717/msk_2/t1a-t1.mp3"
    self.SoundNames["kv70_t1a_t2_15"] = "717/msk_2/t1a-t2.mp3"
    self.SoundNames["kv70_t2_t1a_15"] = "717/msk_2/t2-t1a.mp3"
    self.SoundNames["kv70_0_x1_15"] = "717/msk_2/0-x1.mp3"
    self.SoundNames["kv70_x1_0_15"] = "717/msk_2/x1-0.mp3"
    self.SoundNames["kv70_x1_x2_15"] = "717/msk_2/x1-x2.mp3"
    self.SoundNames["kv70_x2_x1_15"] = "717/msk_2/x2-x1.mp3"
    self.SoundNames["kv70_x2_x3_15"] = "717/msk_2/x2-x3.mp3"
    self.SoundNames["kv70_x3_x2_15"] = "717/msk_2/x3-x2.mp3"
     --
     self.SoundNames["kv70_0_t1_16"] = "717/spb_1/t1.mp3"
     self.SoundNames["kv70_t1_0_16"] = "717/spb_1/0.mp3"
     self.SoundNames["kv70_t1_t1a_16"] = "717/spb_1/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_16"] = "717/spb_1/t1.mp3"
     self.SoundNames["kv70_t1a_t2_16"] = "717/spb_1/t2.mp3"
     self.SoundNames["kv70_t2_t1a_16"] = "717/spb_1/t1a.mp3"
     self.SoundNames["kv70_0_x1_16"] = "717/spb_1/x1.mp3"
     self.SoundNames["kv70_x1_0_16"] = "717/spb_1/0.mp3"  
     self.SoundNames["kv70_x1_x2_16"] = "717/spb_1/x2.mp3"
     self.SoundNames["kv70_x2_x1_16"] = "717/spb_1/x1.mp3"
     self.SoundNames["kv70_x2_x3_16"] = "717/spb_1/x3.mp3"
     self.SoundNames["kv70_x3_x2_16"] = "717/spb_1/x2.mp3" 
     -- 
     self.SoundNames["kv70_0_t1_17"] = "717/spb_2/t1.mp3"
     self.SoundNames["kv70_t1_0_17"] = "717/spb_2/0.mp3"
     self.SoundNames["kv70_t1_t1a_17"] = "717/spb_2/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_17"] = "717/spb_2/t1.mp3"
     self.SoundNames["kv70_t1a_t2_17"] = "717/spb_2/t2.mp3"
     self.SoundNames["kv70_t2_t1a_17"] = "717/spb_2/t1a.mp3"
     self.SoundNames["kv70_0_x1_17"] = "717/spb_2/x1.mp3"
     self.SoundNames["kv70_x1_0_17"] = "717/spb_2/0.mp3"  
     self.SoundNames["kv70_x1_x2_17"] = "717/spb_2/x2.mp3"
     self.SoundNames["kv70_x2_x1_17"] = "717/spb_2/x1.mp3"
     self.SoundNames["kv70_x2_x3_17"] = "717/spb_2/x3.mp3"
     self.SoundNames["kv70_x3_x2_17"] = "717/spb_2/x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_18"] = "717/spb_3/t1.mp3"
     self.SoundNames["kv70_t1_0_18"] = "717/spb_3/0.mp3"
     self.SoundNames["kv70_t1_t1a_18"] = "717/spb_3/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_18"] = "717/spb_3/t1.mp3"
     self.SoundNames["kv70_t1a_t2_18"] = "717/spb_3/t2.mp3"
     self.SoundNames["kv70_t2_t1a_18"] = "717/spb_3/t1a.mp3"
     self.SoundNames["kv70_0_x1_18"] = "717/spb_3/x1.mp3"
     self.SoundNames["kv70_x1_0_18"] = "717/spb_3/0.mp3"  
     self.SoundNames["kv70_x1_x2_18"] = "717/spb_3/x2.mp3"
     self.SoundNames["kv70_x2_x1_18"] = "717/spb_3/x1.mp3"
     self.SoundNames["kv70_x2_x3_18"] = "717/spb_3/x3.mp3"
     self.SoundNames["kv70_x3_x2_18"] = "717/spb_3/x2.mp3" 
     -- 
     self.SoundNames["kv70_0_t1_19"] = "717/spb_4/t1.mp3"
     self.SoundNames["kv70_t1_0_19"] = "717/spb_4/0.mp3"
     self.SoundNames["kv70_t1_t1a_19"] = "717/spb_4/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_19"] = "717/spb_4/t1.mp3"
     self.SoundNames["kv70_t1a_t2_19"] = "717/spb_4/t2.mp3"
     self.SoundNames["kv70_t2_t1a_19"] = "717/spb_4/t1a.mp3"
     self.SoundNames["kv70_0_x1_19"] = "717/spb_4/x1.mp3"
     self.SoundNames["kv70_x1_0_19"] = "717/spb_4/0.mp3"  
     self.SoundNames["kv70_x1_x2_19"] = "717/spb_4/x2.mp3"
     self.SoundNames["kv70_x2_x1_19"] = "717/spb_4/x1.mp3"
     self.SoundNames["kv70_x2_x3_19"] = "717/spb_4/x3.mp3"
     self.SoundNames["kv70_x3_x2_19"] = "717/spb_4/x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_20"] = "717/spb_5/t1.mp3"
     self.SoundNames["kv70_t1_0_20"] = "717/spb_5/0.mp3"
     self.SoundNames["kv70_t1_t1a_20"] = "717/spb_5/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_20"] = "717/spb_5/t1.mp3"
     self.SoundNames["kv70_t1a_t2_20"] = "717/spb_5/t2.mp3"
     self.SoundNames["kv70_t2_t1a_20"] = "717/spb_5/t1a.mp3"
     self.SoundNames["kv70_0_x1_20"] = "717/spb_5/x1.mp3"
     self.SoundNames["kv70_x1_0_20"] = "717/spb_5/0.mp3"  
     self.SoundNames["kv70_x1_x2_20"] = "717/spb_5/x2.mp3"
     self.SoundNames["kv70_x2_x1_20"] = "717/spb_5/x1.mp3"
     self.SoundNames["kv70_x2_x3_20"] = "717/spb_5/x3.mp3"
     self.SoundNames["kv70_x3_x2_20"] = "717/spb_5/x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_21"] = "717/spb_6/t1.mp3"
     self.SoundNames["kv70_t1_0_21"] = "717/spb_6/0.mp3"
     self.SoundNames["kv70_t1_t1a_21"] = "717/spb_6/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_21"] = "717/spb_6/t1.mp3"
     self.SoundNames["kv70_t1a_t2_21"] = "717/spb_6/t2.mp3"
     self.SoundNames["kv70_t2_t1a_21"] = "717/spb_6/t1a.mp3"
     self.SoundNames["kv70_0_x1_21"] = "717/spb_6/x1.mp3"
     self.SoundNames["kv70_x1_0_21"] = "717/spb_6/0.mp3"  
     self.SoundNames["kv70_x1_x2_21"] = "717/spb_6/x2.mp3"
     self.SoundNames["kv70_x2_x1_21"] = "717/spb_6/x1.mp3"
     self.SoundNames["kv70_x2_x3_21"] = "717/spb_6/x3.mp3"
     self.SoundNames["kv70_x3_x2_21"] = "717/spb_6/x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_22"] = "717/spb_7/t1.mp3"
     self.SoundNames["kv70_t1_0_22"] = "717/spb_7/0.mp3"
     self.SoundNames["kv70_t1_t1a_22"] = "717/spb_7/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_22"] = "717/spb_7/t1.mp3"
     self.SoundNames["kv70_t1a_t2_22"] = "717/spb_7/t2.mp3"
     self.SoundNames["kv70_t2_t1a_22"] = "717/spb_7/t1a.mp3"
     self.SoundNames["kv70_0_x1_22"] = "717/spb_7/x1.mp3"
     self.SoundNames["kv70_x1_0_22"] = "717/spb_7/0.mp3"  
     self.SoundNames["kv70_x1_x2_22"] = "717/spb_7/x2.mp3"
     self.SoundNames["kv70_x2_x1_22"] = "717/spb_7/x1.mp3"
     self.SoundNames["kv70_x2_x3_22"] = "717/spb_7/x3.mp3"
     self.SoundNames["kv70_x3_x2_22"] = "717/spb_7/x2.mp3"  
     --
     self.SoundNames["kv70_0_t1_23"] = "717/spb_8/t1.mp3"
     self.SoundNames["kv70_t1_0_23"] = "717/spb_8/0.mp3"
     self.SoundNames["kv70_t1_t1a_23"] = "717/spb_8/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_23"] = "717/spb_8/t1.mp3"
     self.SoundNames["kv70_t1a_t2_23"] = "717/spb_8/t2.mp3"
     self.SoundNames["kv70_t2_t1a_23"] = "717/spb_8/t1a.mp3"
     self.SoundNames["kv70_0_x1_23"] = "717/spb_8/x1.mp3"
     self.SoundNames["kv70_x1_0_23"] = "717/spb_8/0.mp3"  
     self.SoundNames["kv70_x1_x2_23"] = "717/spb_8/x2.mp3"
     self.SoundNames["kv70_x2_x1_23"] = "717/spb_8/x1.mp3"
     self.SoundNames["kv70_x2_x3_23"] = "717/spb_8/x3.mp3"
     self.SoundNames["kv70_x3_x2_23"] = "717/spb_8/x2.mp3"  
     --
     self.SoundNames["kv70_0_t1_24"] = "717/spb_9/t1.mp3"
     self.SoundNames["kv70_t1_0_24"] = "717/spb_9/0.mp3"
     self.SoundNames["kv70_t1_t1a_24"] = "717/spb_9/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_24"] = "717/spb_9/t1.mp3"
     self.SoundNames["kv70_t1a_t2_24"] = "717/spb_9/t2.mp3"
     self.SoundNames["kv70_t2_t1a_24"] = "717/spb_9/t1a.mp3"
     self.SoundNames["kv70_0_x1_24"] = "717/spb_9/x1.mp3"
     self.SoundNames["kv70_x1_0_24"] = "717/spb_9/0.mp3"  
     self.SoundNames["kv70_x1_x2_24"] = "717/spb_9/x2.mp3"
     self.SoundNames["kv70_x2_x1_24"] = "717/spb_9/x1.mp3"
     self.SoundNames["kv70_x2_x3_24"] = "717/spb_9/x3.mp3"
     self.SoundNames["kv70_x3_x2_24"] = "717/spb_9/x2.mp3"  
     --
     self.SoundNames["kv70_0_t1_25"] = "717/spb_10/t1.mp3"
     self.SoundNames["kv70_t1_0_25"] = "717/spb_10/0.mp3"
     self.SoundNames["kv70_t1_t1a_25"] = "717/spb_10/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_25"] = "717/spb_10/t1.mp3"
     self.SoundNames["kv70_t1a_t2_25"] = "717/spb_10/t2.mp3"
     self.SoundNames["kv70_t2_t1a_25"] = "717/spb_10/t1a.mp3"
     self.SoundNames["kv70_0_x1_25"] = "717/spb_10/x1.mp3"
     self.SoundNames["kv70_x1_0_25"] = "717/spb_10/0.mp3"  
     self.SoundNames["kv70_x1_x2_25"] = "717/spb_10/x2.mp3"
     self.SoundNames["kv70_x2_x1_25"] = "717/spb_10/x1.mp3"
     self.SoundNames["kv70_x2_x3_25"] = "717/spb_10/x3.mp3"
     self.SoundNames["kv70_x3_x2_25"] = "717/spb_10/x2.mp3" 

     self.SoundNames["kv70_0_t1_26"] = "717/spb_12/t1.mp3"
     self.SoundNames["kv70_t1_0_26"] = "717/spb_12/0.mp3"
     self.SoundNames["kv70_t1_t1a_26"] = "717/spb_12/t1a.mp3"
     self.SoundNames["kv70_t1a_t1_26"] = "717/spb_12/t1.mp3"
     self.SoundNames["kv70_t1a_t2_26"] = "717/spb_12/t2.mp3"
     self.SoundNames["kv70_t2_t1a_26"] = "717/spb_12/t1a.mp3"
     self.SoundNames["kv70_0_x1_26"] = "717/spb_12/x1.mp3"
     self.SoundNames["kv70_x1_0_26"] = "717/spb_12/0.mp3"  
     self.SoundNames["kv70_x1_x2_26"] = "717/spb_12/x2.mp3"
     self.SoundNames["kv70_x2_x1_26"] = "717/spb_12/x1.mp3"
     self.SoundNames["kv70_x2_x3_26"] = "717/spb_12/x3.mp3"
     self.SoundNames["kv70_x3_x2_26"] = "717/spb_12/x2.mp3" 
    --
     self.SoundNames["kv70_0_t1_27"] = "717/spb_11/0-t1.mp3"
     self.SoundNames["kv70_t1_0_27"] = "717/spb_11/t1-0.mp3"
     self.SoundNames["kv70_t1_t1a_27"] = "717/spb_11/t1-t1a.mp3"
     self.SoundNames["kv70_t1a_t1_27"] = "717/spb_11/t1a-t1.mp3"
     self.SoundNames["kv70_t1a_t2_27"] = "717/spb_11/t2-t1a.mp3"
     self.SoundNames["kv70_t2_t1a_27"] = "717/spb_11/t2-t1a.mp3"
     self.SoundNames["kv70_0_x1_27"] = "717/spb_11/0-x1.mp3"
     self.SoundNames["kv70_x1_0_27"] = "717/spb_11/x1-0.mp3"  
     self.SoundNames["kv70_x1_x2_27"] = "717/spb_11/x1-x2.mp3"
     self.SoundNames["kv70_x2_x1_27"] = "717/spb_11/x2-x1.mp3"
     self.SoundNames["kv70_x2_x3_27"] = "717/spb_11/x2-x3.mp3"
     self.SoundNames["kv70_x3_x2_27"] = "717/spb_11/x3-x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_28"] = "717/spb_13/0-t1.mp3"
     self.SoundNames["kv70_t1_0_28"] = "717/spb_13/t1-0.mp3"
     self.SoundNames["kv70_t1_t1a_28"] = "717/spb_13/t1-t1a.mp3"
     self.SoundNames["kv70_t1a_t1_28"] = "717/spb_13/t1a-t1.mp3"
     self.SoundNames["kv70_t1a_t2_28"] = "717/spb_13/t2-t1a.mp3"
     self.SoundNames["kv70_t2_t1a_28"] = "717/spb_13/t2-t1a.mp3"
     self.SoundNames["kv70_0_x1_28"] = "717/spb_13/0-x1.mp3"
     self.SoundNames["kv70_x1_0_28"] = "717/spb_13/x1-0.mp3"  
     self.SoundNames["kv70_x1_x2_28"] = "717/spb_13/x1-x2.mp3"
     self.SoundNames["kv70_x2_x1_28"] = "717/spb_13/x2-x1.mp3"
     self.SoundNames["kv70_x2_x3_28"] = "717/spb_13/x2-x3.mp3"
     self.SoundNames["kv70_x3_x2_28"] = "717/spb_13/x3-x2.mp3" 
     --
     self.SoundNames["kv70_0_t1_29"] = "717/spb_14/0-t1.mp3"
     self.SoundNames["kv70_t1_0_29"] = "717/spb_14/t1-0.mp3"
     self.SoundNames["kv70_t1_t1a_29"] = "717/spb_14/t1-t1a.mp3"
     self.SoundNames["kv70_t1a_t1_29"] = "717/spb_14/t1a-t1.mp3"
     self.SoundNames["kv70_t1a_t2_29"] = "717/spb_14/t2-t1a.mp3"
     self.SoundNames["kv70_t2_t1a_29"] = "717/spb_14/t2-t1a.mp3"
     self.SoundNames["kv70_0_x1_29"] = "717/spb_14/0-x1.mp3"
     self.SoundNames["kv70_x1_0_29"] = "717/spb_14/x1-0.mp3"  
     self.SoundNames["kv70_x1_x2_29"] = "717/spb_14/x1-x2.mp3"
     self.SoundNames["kv70_x2_x1_29"] = "717/spb_14/x2-x1.mp3"
     self.SoundNames["kv70_x2_x3_29"] = "717/spb_14/x2-x3.mp3"
     self.SoundNames["kv70_x3_x2_29"] = "717/spb_14/x3-x2.mp3" 

    self.SoundNames["reverser_pulti"] = "717/spb_additions/reverser_pulti1.mp3" 
    self.SoundNames["reverser_pulto"] = "717/spb_additions/reverser_pulto.mp3" 
    self.SoundPositions["reverser_pulto"] = {110,1e9,Vector(435.848,16.1,-19.779+4.75),1.5}
    self.SoundPositions["reverser_pulti"] = {110,1e9,Vector(435.848,16.1,-19.779+4.75),1.5}
    self.SoundPositions["kv70_fix_on_1"] = {110,1e9,Vector(435.848,16.1,-19.779+4.75),0.5}
    self.SoundPositions["kv70_fix_off_1"] = self.SoundPositions["kv70_fix_on_1"] 
    for i = 1, 29 do 
        self.SoundPositions["kv70_0_t1_1"] = {110,1e9,Vector(456.5,-45,-8),i<10 and 0.5 or i==29 and 0.5 or math.Rand(2.1, 3)}
        self.SoundPositions["kv70_t1_0_fix_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_0_t1_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_x1_0_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_t1_0_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_t1_t1a_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_t1a_t1_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_t1a_t2_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_t2_t1a_"..i]  = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_0_x1_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_x1_x2_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_x2_x1_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_x2_x3_"..i] = self.SoundPositions["kv70_0_t1_1"]
        self.SoundPositions["kv70_x3_x2_"..i] =  self.SoundPositions["kv70_0_t1_1"]
    end  
    self.SoundNames["ring"] = {loop=0.0,"subway_trains/717/ring/ring_start.wav","subway_trains/717/ring/ring_loop.wav","subway_trains/717/ring/ring_end.wav"}
    self.SoundPositions["ring"] = {60,1e9,Vector(443.8,0,-3.2),0.43}
    self.SoundNames["ring2"] = {loop=0.25,"subway_trains/717/ring/ringc_start.wav","subway_trains/717/ring/ringc_loop.wav","subway_trains/717/ring/ringc_end.mp3"}
    self.SoundPositions["ring2"] = self.SoundPositions["ring"]
    self.SoundNames["ring3"] = {loop=0.1,"subway_trains/717/ring/ringch_start.wav","subway_trains/717/ring/ringch_loop.wav","subway_trains/717/ring/ringch_end.wav"}
    self.SoundPositions["ring3"] = self.SoundPositions["ring"]
    self.SoundNames["ring4"] = {loop=true,"subway_trains/717/ring/son13s.wav"}
    self.SoundPositions["ring4"] = {60,1e9,Vector(443.8,0,-3.2),0.3}
    self.SoundNames["ring5"] = {loop=true,"subway_trains/717/ring/son17.wav"}
    self.SoundPositions["ring5"] = self.SoundPositions["ring4"]
    self.SoundNames["ring6"] = {loop=0.0,"subway_trains/717/ring/ring2_loop.wav","subway_trains/717/ring/ring2_loop.wav","subway_trains/717/ring/ring2_end.wav"}
    self.SoundPositions["ring6"] = {60,1e9,Vector(443.8,0,-3.2),0.5}

    self.SoundNames["ring_old"] = {loop=0.15,"subway_trains/717/ring/ringo_start.wav","subway_trains/717/ring/ringo_loop.wav","subway_trains/717/ring/ringo_end.mp3"}
    self.SoundPositions["ring_old"] = {60,1e9,Vector(459,6,10),0.35}

    self.SoundNames["vpr"] = {loop=0.8,"subway_trains/common/other/radio/vpr_start.wav","subway_trains/common/other/radio/vpr_loop.wav","subway_trains/common/other/radio/vpr_off.wav"}
    self.SoundPositions["vpr"] = {60,1e9,Vector(420,-49 ,61),0.05}

    self.SoundNames["cab_door_open"] = {"5m_sbl/door_open1.mp3","5m_sbl/door_open2.mp3"}
    self.SoundNames["cab_door_close"] = {"5m_sbl/door_close1.mp3","5m_sbl/door_close2.mp3","5m_sbl/door_close3.mp3"}
    self.SoundNames["otsek_door_open"] = {"subway_trains/720/door/door_torec_open.mp3","subway_trains/720/door/door_torec_open2.mp3"}
    self.SoundNames["otsek_door_close"] = {"717/otsek_barsm.mp3","717/otsek_sgovnom.mp3"}

    self.SoundNames["door_locker_on"]  = "717/door_locker_open.mp3"
    self.SoundNames["door_locker_off"]  = "717/door_locker_close.mp3"
    self.SoundPositions["door_locker_on"] = 		{50,1e9,Vector(390-12.2,29+32,50.6),2.5}
    self.SoundPositions["door_locker_off"] = 		{50,1e9,Vector(390-12.2,29+32,50.6),2.5}
    self.SoundNames["motorolla_on"]  = "717/motorolla_start.mp3"
    self.SoundNames["igla_on"]  = "subway_trains/common/other/igla/igla_on1.mp3"
    self.SoundNames["igla_off"] = "subway_trains/common/other/igla/igla_off2.mp3"
    self.SoundNames["igla_start1"]  = "subway_trains/common/other/igla/igla_start.mp3"
    self.SoundNames["igla_start2"]  = "subway_trains/common/other/igla/igla_start2.mp3"
    self.SoundNames["igla_alarm1"]  = "subway_trains/common/other/igla/igla_alarm1.mp3"
    self.SoundNames["igla_alarm2"]  = "subway_trains/common/other/igla/igla_alarm2.mp3"
    self.SoundNames["igla_alarm3"]  = "subway_trains/common/other/igla/igla_alarm3.mp3"
    self.SoundPositions["igla_on"] = 		{50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["motorolla_on"] = 		{50,1e9,Vector(458.50,-33,34),1}
    self.SoundPositions["igla_off"] = 		{50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["igla_start1"] = 	{50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_start2"] = 	{50,1e9,Vector(458.50,-33,34),0.15}
    self.SoundPositions["igla_alarm1"] = 	{50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_alarm2"] = 	{50,1e9,Vector(458.50,-33,34),0.33}
    self.SoundPositions["igla_alarm3"] = 	{50,1e9,Vector(458.50,-33,34),0.33}

    self.SoundNames["upps"]         = {"subway_trains/common/other/upps/upps1.mp3","subway_trains/common/other/upps/upps2.mp3"}
    self.SoundPositions["upps"] = {60,1e9,Vector(443,-64,4),0.33}

    self.SoundNames["pnm_on"]           = {"subway_trains/common/pnm/pnm_switch_on.mp3","subway_trains/common/pnm/pnm_switch_on2.mp3"}
    self.SoundNames["pnm_off"]          = "subway_trains/common/pnm/pnm_switch_off.mp3"
    self.SoundNames["pnm_button1_on"]           = {
        "subway_trains/common/pnm/pnm_button_push.mp3",
        "subway_trains/common/pnm/pnm_button_push2.mp3",
    }

    self.SoundNames["pnm_button2_on"]           = {
        "subway_trains/common/pnm/pnm_button_push3.mp3",
        "subway_trains/common/pnm/pnm_button_push4.mp3",
    }

    self.SoundNames["pnm_button1_off"]          = {
        "subway_trains/common/pnm/pnm_button_release.mp3",
        "subway_trains/common/pnm/pnm_button_release2.mp3",
        "subway_trains/common/pnm/pnm_button_release3.mp3",
    }

    self.SoundNames["pnm_button2_off"]          = {
        "subway_trains/common/pnm/pnm_button_release4.mp3",
        "subway_trains/common/pnm/pnm_button_release5.mp3",
    }

    self.SoundNames["horn"] = {loop=0.6,"5m_sbl/horn/horn_start_10196.wav","5m_sbl/horn/horn_loop_10196.wav", "5m_sbl/horn/horn_end_10196.wav"}
    self.SoundPositions["horn"] = {1100,1e9,Vector(450,0,-55),1}




    --DOORS
    self.SoundNames["vdol_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO3_on.mp3",

    }
    self.SoundNames["vdol_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDO_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDO2_off.mp3",
    }
    self.SoundPositions["vdol_on"] = {300,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdol_off"] = {300,1e9,Vector(-420,45,-30),0.4}
    self.SoundNames["vdor_on"] = self.SoundNames["vdol_on"]
    self.SoundNames["vdor_off"] = self.SoundNames["vdol_off"]
    self.SoundPositions["vdor_on"] = self.SoundPositions["vdol_on"]
    self.SoundPositions["vdor_off"] = self.SoundPositions["vdol_off"]
    self.SoundNames["vdol_loud"] = "subway_trains/common/pneumatic/door_valve/vdo3_on.mp3"
    self.SoundNames["vdop_loud"] = self.SoundNames["vdol_loud"]
    self.SoundPositions["vdol_loud"] = {100,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdop_loud"] = self.SoundPositions["vdol_loud"]
    self.SoundNames["vdz_on"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_on.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_on.mp3",
    }
    self.SoundNames["vdz_off"] = {
        "subway_trains/common/pneumatic/door_valve/VDZ_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ2_off.mp3",
        "subway_trains/common/pneumatic/door_valve/VDZ3_off.mp3",
    }
    self.SoundPositions["vdz_on"] = {60,1e9,Vector(-420,45,-30),1}
    self.SoundPositions["vdz_off"] = {60,1e9,Vector(-420,45,-30),0.4}

    self.SoundNames["RKR"] = "subway_trains/common/pneumatic/RKR2.mp3"
    self.SoundPositions["RKR"] = {330,1e9,Vector(-27,-40,-66),0.22}

    self.SoundNames["PN2end"] = {"subway_trains/common/pneumatic/vz2_end.mp3","subway_trains/common/pneumatic/vz2_end_2.mp3","subway_trains/common/pneumatic/vz2_end_3.mp3","subway_trains/common/pneumatic/vz2_end_4.mp3"}
    self.SoundPositions["PN2end"] = {350,1e9,Vector(-183,0,-70),0.3}
    for i=0,3 do
        for k=0,1 do
            self.SoundNames["door"..i.."x"..k.."r"] = {"subway_trains/common/door/door_roll.wav",loop=true}
            self.SoundPositions["door"..i.."x"..k.."r"] = {150,1e9,GetDoorPosition(i,k),0.11}
            self.SoundNames["door"..i.."x"..k.."o"] = {"717/kkl/door_open_end5.mp3","717/kkl/door_open_end6.mp3","717/kkl/door_open_end7.mp3"}
            self.SoundPositions["door"..i.."x"..k.."o"] = {350,1e9,GetDoorPosition(i,k),2}
            self.SoundNames["door"..i.."x"..k.."c"] = {"subway_trains/common/door/door_close_end.mp3","subway_trains/common/door/door_close_end2.mp3","subway_trains/common/door/door_close_end3.mp3","subway_trains/common/door/door_close_end4.mp3","subway_trains/common/door/door_close_end5.mp3"}
            self.SoundPositions["door"..i.."x"..k.."c"] = {400,1e9,GetDoorPosition(i,k),2}
        end
    end

    for k,v in ipairs(self.AnnouncerPositions) do
        self.SoundNames["announcer_buzz"..k] = {loop=true,"subway_announcers/asnp/bpsn_ann.wav"}
        self.SoundPositions["announcer_buzz"..k] = {v[2] or 600,1e9,v[1],0}
    end

    for _,v in pairs(ARSRelays) do
        self.SoundNames[v.."_on"] = "subway_trains/common/relays/ars_relays_on1.mp3"
        self.SoundNames[v.."_off"] = "subway_trains/common/relays/ars_relays_off1.mp3"
        self.SoundPositions[v.."_on"] = {10,1e9,Vector(385,-32, 10),0.03}
        self.SoundPositions[v.."_off"] = {10,1e9,Vector(385,-32, 10),0.03}
    end
    self:SetRelays()
end
ENT.PR14XRelaysOrder = {"r1_5_on","r1_5_off","rp8_on","rp8_off","ro_on","ro_off","rpb_on","rpb_off","k6_on","k6_off","rvt_on","rvt_off","kd_on","kd_off","k25_on","k25_off",}
ENT.PR14XRelays = {
    --orig 1
    r1_5_on = {
        --{"kpd110e_on2", 1},
        --^ SPB ONLY ^
        {"kpd110e_on4", 0.8},
        {"kpd110e_on5", 0.8},
        {"kpd110e_on6", 0.8},
        --v MSK ONLY v
        {"kpd110e_on1", 1},
        {"kpd110e_on3", 0.7},
        {"kpd110e_on7", 0.8},
    },
    --orig 0.7
    r1_5_off = {
        --{"kpd110e_off1",0.9},
        --{"kpd110e_off2",1},
        --^ SPB ONLY ^
        --v MSK ONLY v
        {"kpd110e_off5", 0.9},
        {"kpd110e_off6", 0.8},
    },
    --orig 1
    rvt_on = {
        {"rev811t_on2", 1},
        {"rev811t_on3", 1},
        {"rev811t_on4", 1},
        {"rev811t_on5", 0.6},
    },
    --orig 1
    rp8_on = {
        {"rev811t_on1", 1},
        {"rev811t_on2", 1},
        {"rev811t_on3", 1},
        {"rev811t_on4", 1},
        {"rev811t_on5", 0.6},
    },
    --orig 0.3
    rp8_off = {
        {"rev811t_off1",0.3},
        {"rev811t_off2",0.2},
        {"rev811t_off4",0.3},
    },
    ro_on = {
        --^ SPB ONLY ^
        {"kpd110e_on4",0.8},
        {"kpd110e_on5",0.8},
        {"kpd110e_on6",0.8},
        {"kpd110e_on1",1},
        {"kpd110e_on3",0.7},
        {"kpd110e_on7",0.8},
        --v MSK ONLY v
    },
    ro_off = {
        --^ SPB ONLY ^
        {"kpd110e_off1",0.9},
        {"kpd110e_off2",1},
        {"kpd110e_off5",0.9},
        {"kpd110e_off6",0.8},
        --v MSK ONLY v
    },
    --1
    rpb_on = {{"rev813t_on1",1},{"rev813t_on2",1}},
    --0.7
    rpb_off = {{"rev813t_off1",0.7}},
    --1
    k6_on = {{"tkpm121_on1",1},{"tkpm121_on2",1}},
    --1
    k6_off = {{"tkpm121_off1",1},{"tkpm121_off2",1}},
}
ENT.PR14XRelays.rvt_off = ENT.PR14XRelays.rp8_off
ENT.PR14XRelays.kd_on = ENT.PR14XRelays.rp8_on
ENT.PR14XRelays.kd_off = ENT.PR14XRelays.rp8_off
ENT.PR14XRelays.k25_on = ENT.PR14XRelays.ro_on
ENT.PR14XRelays.k25_off = ENT.PR14XRelays.ro_off

function ENT:SetRelays()
    local relayConf = self:GetNW2String("RelaysConfig")
    if #relayConf<#self.PR14XRelaysOrder then return end
    for i,k in ipairs(self.PR14XRelaysOrder) do
        local id = tonumber(relayConf[i])
        local v = self.PR14XRelays[k][id]
        self.SoundNames[k] = Format("subway_trains/717/relays/%s.mp3",v[1])
        self.SoundPositions[k][4] = v[2] or 1
    end
end
function ENT:InitializeSystems()
    -- Электросистема 81-710
    self:LoadSystem("Electric","81_717KKL_Electric")
    -- Токоприёмник
    self:LoadSystem("TR","TR_3B")
    -- Электротяговые двигатели
    self:LoadSystem("Engines","DK_117DM")

    -- Резисторы для реостата/пусковых сопротивлений
    self:LoadSystem("KF_47A","KF_47A1")
    -- Резисторы для ослабления возбуждения
    self:LoadSystem("KF_50A")
    -- Ящик с предохранителями
    self:LoadSystem("YAP_57")

    -- Резисторы для цепей управления
    --self:LoadSystem("YAS_44V")
    self:LoadSystem("Reverser","PR_722D")
    -- Реостатный контроллер для управления пусковыми сопротивления
    self:LoadSystem("RheostatController","EKG_17B")
    -- Групповой переключатель положений
    self:LoadSystem("PositionSwitch","PKG_761")
    -- Кулачковый контроллер
    self:LoadSystem("KV","KV_70")
    -- Контроллер резервного управления
    self:LoadSystem("KRU")


    -- Ящики с реле и контакторами
    self:LoadSystem("BV","BV_630")
    self:LoadSystem("LK_755A")
    self:LoadSystem("YAR_13B")
    self:LoadSystem("YAR_27")
    self:LoadSystem("YAK_36")
    self:LoadSystem("YAK_37E")
    self:LoadSystem("YAS_44V")
    self:LoadSystem("YARD_2")
    self:LoadSystem("PR_14X_Panels")

    -- Пневмосистема 81-710
    self:LoadSystem("Pneumatic","81_717KKL_Pneumatic")
    -- Панель управления 81-710
    self:LoadSystem("Panel","81_717kkl_Panel")
    -- Everything else
    self:LoadSystem("Battery")
    self:LoadSystem("PowerSupply","BPSN")
    --self:LoadSystem("DURA")
    self:LoadSystem("ALS_ARS","BARS_M") 
    self:LoadSystem("Horn")

    self:LoadSystem("OTL_Mirrors")

    self:LoadSystem("IGLA_CBKI","IGLA_CBKI1")
    self:LoadSystem("IGLA_PCBK")

    self:LoadSystem("UPPS")

    self:LoadSystem("BZOS","81_718_BZOS")
    self:LoadSystem("Motorolla","81_motorollagm340")
    self:LoadSystem("Announcer","81_71_Announcer", "AnnouncementsASNP")
    self:LoadSystem("ASNP","81_717kkl_informator")
    self:LoadSystem("R_ASNPOn","Relay","Switch",{ normally_closed = true, bass = true })	  
    self:LoadSystem("ASNP_VV","81_71_ASNP_VV")
    self:LoadSystem("Screen","81_540_2k_screens")
    self:LoadSystem("DoorOff1","Relay","Switch", {bass = true})
    self:LoadSystem("DoorOff2","Relay","Switch", {bass = true})
    self:LoadSystem("RouteNumber","81_71_RouteNumber",2)
    self:LoadSystem("LastStation","81_71_LastStation","717","destination")
end

function ENT:PostInitializeSystems()
    self.Electric:TriggerInput("NoRT2",0)
    self.Electric:TriggerInput("HaveRO",1)
    self.Electric:TriggerInput("GreenRPRKR",0)
    self.Electric:TriggerInput("Type",self.Electric.MVM)
    self.Electric:TriggerInput("X2PS",0)
    self.Electric:TriggerInput("HaveVentilation",1)
    self.KRU:TriggerInput("LockX3",1)
end
---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim 
---------------------------------------------------
ENT.SubwayTrain = {
    Type = "81",
    Name = "81-717.5KKL",
    WagType = 1,
    Manufacturer = "Kyiv KKL",
    ALS = {
        HaveAutostop = true,
        TwoToSix = true,
        RSAs325Hz = true,
        Aproove0As325Hz = false,
    },
    Announcer = {
    },
    EKKType = 717,  
    NoFrontEKK=true,
}
-- LVZ,Dot5,NewSeats,NewBL,PassTexture,MVM
 
ENT.NumberRanges = {
    --717 МВМ
    {
        true,
        {9257,9256},
        {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true}
    },
    {
        true,
        {9254,9255},
        {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true}
    },
    {
        true,
        {9262,9263},
        {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true}
    },
    {
        true,
        {9265,9264},
        {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true}
    },
}
ENT.ScepRang = {
    84,
    83,
    51,
    42,
    73,
    13,
    11,
    41,    
}

ENT.Spawner = {
    model = {
        "models/metrostroi_train/81-717/81-717_mvm.mdl",
        "models/metrostroi_train/81-717/interior_spb.mdl",
        "models/metrostroi_train/81-717/717_body_additional.mdl",
        "models/metrostroi_train/81-717/brake_valves/013.mdl",
        "models/metrostroi_train/81-717/lamps_type1.mdl",
        "models/metrostroi_train/81-717/couch_old.mdl",
        "models/metrostroi_train/81-717/couch_cap_l.mdl",
        "models/metrostroi_train/81-717/handlers_old.mdl",
        "models/metrostroi_train/81-717/mask_242.mdl",
        "models/metrostroi_train/81-717/couch_cap_r.mdl",
        "models/metrostroi_train/81-717/cabine_mvm.mdl",
        "models/metrostroi_train/81-717/pult/body_classic.mdl",
        "models/metrostroi_train/81-717/pult/pult_mvm_classic.mdl",
        "models/metrostroi_train/81-717/pult/ars_old.mdl",
    },
    interim = "gmod_subway_81-714_kkl",
    Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    --Metrostroi.Skins.GetTable("PassTexture","Spawner.PassTexture",false,"pass"), 
    --Metrostroi.Skins.GetTable("CabTexture","Spawner.CabTexture",false,"cab"),
  --  Metrostroi.Skins.GetTable("Texture","Spawner.Texture",false,"train"),
    {"Announcer","Spawner.717.Announcer","List",function()
        local Announcer = {}
        for k,v in pairs(Metrostroi.AnnouncementsASNP or {}) do if not v.riu then Announcer[k] = v.name or k end end
        return Announcer
    end},

    {"PultType","Пульт","List",{"Белый","Серый", "0005 (ВРЗ)", "Серый 2"}},
    {"MaskT", "Тип маски", "List", {"1-4-1","2-4-2","2-2","Подстекольник 2-2-2","Случайно"}},
    {"KVSOUND", "Тип звука контроллера", "List", {"1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29"}},

    {"Kv","Контроллер .5","Boolean"},
    {"Interior","Салон","List",{"Wood Interior","Cиний"}},
    {"SpawnMode","Состояние","List",{"Полностью запущен","Тупик","Ночной отстой","Депо"}, nil,function(ent,val,rot,i,wagnum,rclk)
        if rclk then return end
        if ent._SpawnerStarted~=val then
            ent.VB:TriggerInput("Set",val<=2 and 1 or 0)
            ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
            if ent.AR63  then
                local first = i==1 or _LastSpawner~=CurTime()
                ent.A53:TriggerInput("Set",val<=3 and 1 or 0) 
                ent.A49:TriggerInput("Set",1)
                ent.A75:TriggerInput("Set",0)
                ent.AR63:TriggerInput("Set",1)
                ent.R_UNch:TriggerInput("Set",val==1 or val==2 and 1 or 0)
                ent.R_Radio:TriggerInput("Set",val==1 or val==2 and 1 or 0)
                ent.L_4:TriggerInput("Set",val==1 and 1 or 0)
                ent.BPSNon:TriggerInput("Set",(val==1 or val==2) and first and 1 or 0)
                ent.VMK:TriggerInput("Set",(val==1 or val==2) and first and 1 or 0)
                ent.ARS:TriggerInput("Set",(ent.Plombs.RC1 and val==1 and first) and 1 or 0)
                ent.ALSToggleSwitch:TriggerInput("Set",2) 
                ent.A76:TriggerInput("Set",0)
                ent.L_1:TriggerInput("Set",first and val==1 and 1 or 0)
                ent.L_3:TriggerInput("Set",0)
                ent.EPK1:TriggerInput("Set",1)
                ent.RO1:TriggerInput("Set",1) 
                ent.NG1:TriggerInput("Set",1)
                ent.FMM11:TriggerInput("Set",1) 
                ent.GE1:TriggerInput("Set",1)
                ent.KSR11:TriggerInput("Set",1)
                ent.ROT11:TriggerInput("Set",1)
                ent.ROT22:TriggerInput("Set",1)
                ent.KRO1:TriggerInput("Set",1)
                ent.KK1:TriggerInput("Set",1)
                ent.VDOP1:TriggerInput("Set",1)
                ent.VDOL1:TriggerInput("Set",1)
                ent.RD1:TriggerInput("Set",1)
                ent.RKR1:TriggerInput("Set",1)
                ent.RVZ11:TriggerInput("Set",1)
                ent.VZ11:TriggerInput("Set",1)
                ent.KO1:TriggerInput("Set",1)
                ent.VDZ1:TriggerInput("Set",1) 
                ent.PM1:TriggerInput("Set",1)
                ent.PS1:TriggerInput("Set",1)
                ent.PT1:TriggerInput("Set",1)
                ent.KVC1:TriggerInput("Set",1)
                ent.U22:TriggerInput("Set",1)
                ent.RPVozvrat1:TriggerInput("Set",1)
                ent.VUD11:TriggerInput("Set",1)
                ent.RV21:TriggerInput("Set",1)
                ent.R1_51:TriggerInput("Set",1)
                ent.RVT1:TriggerInput("Set",1)
                ent.MK1:TriggerInput("Set",1)
                ent.RVT11:TriggerInput("Set",1)
                ent.RPB1:TriggerInput("Set",1)
                ent.SIR55:TriggerInput("Set",1)
                ent.SR11:TriggerInput("Set",1)
                ent.BR11:TriggerInput("Set",1)
                ent.RUVD1:TriggerInput("Set",1)
                ent.BPSN1:TriggerInput("Set",1)
                ent.K251:TriggerInput("Set",1)
                ent.RV11:TriggerInput("Set",1)
                -- ent.SR11:TriggerInput("Set",1)
                ent.LK11:TriggerInput("Set",1)
                ent.LK22:TriggerInput("Set",1)
                ent.LK31:TriggerInput("Set",1) 
                ent.LK41:TriggerInput("Set",1)
                ent.LK51:TriggerInput("Set",1)
                ent.KVP1:TriggerInput("Set",1)
                ent.TR11:TriggerInput("Set",1)
                ent.RSU1:TriggerInput("Set",1)  
                ent.KSN1:TriggerInput("Set",1)
                ent.OtklBV1:TriggerInput("Set",1)
                ent.RezMK1:TriggerInput("Set",1)  
                ent.Pred1C:TriggerInput("Set",1)
                ent.Pred2C:TriggerInput("Set",1)
                ent.Pred3C:TriggerInput("Set",1)
                ent.Pred4C:TriggerInput("Set",1)
                ent.Pred5C:TriggerInput("Set",1)
                ent.Pred6C:TriggerInput("Set",1)
            
                ent.KDL1:TriggerInput("Set",1)
                ent.KDP1:TriggerInput("Set",1)
                ent.KVT1:TriggerInput("Set",1)
                ent.ARS1:TriggerInput("Set",1)
                ent.VUS1:TriggerInput("Set",1)
                ent.A481:TriggerInput("Set",1)
                ent.ALS1:TriggerInput("Set",1)
                ent.A311:TriggerInput("Set",1)
                ent.A321:TriggerInput("Set",1)  
                ent.L_4:TriggerInput("Set",(val==1 or val==2) and first and 1 or 0)   
                ent.VUS:TriggerInput("Set",(val==1 or val==2) and first and 1 or 0)
                ent.R_ZS:TriggerInput("Set",1)
                ent.SAB1:TriggerInput("Set",1)
                ent.R_G:TriggerInput("Set",val==1 and 1 or 0)
                if val ~=2 then 
                ent.EPK:TriggerInput("Set",val~=2 and 1 or 0)    
                else
                 ent.EPK:TriggerInput("Set",not first and 1 or 0)    
                end 
                ent.R_VPR:TriggerInput("Set",val==1 and 1 or 0)
                ent.VUD1:TriggerInput("Set",(val~=2 and first) and 1 or 0)
                ent.AVOSV:TriggerInput("Set",(val==1 and first) and 1 or 0) 
                -- ent.EPK:TriggerInput("Set",val==4 and 1 or 0)       
                if val ~=2 then   
                ent.ParkingBrake:TriggerInput("Set",val==3 and 1 or 0)
                else 
                    ent.ParkingBrake:TriggerInput("Set",first and 1 or 0)
                end 
              --  ent.DriverValveDisconnect:TriggerInput("Set",(val==2 and first) and 1 or 0)
                ent.DriverValveBLDisconnect:TriggerInput("Set",(val==2 and first) and 1 or 0)
                ent.DriverValveTLDisconnect:TriggerInput("Set",(val==2 and first) and 1 or 0)
                _LastSpawner=CurTime()
                ent.CabinDoor = val==4 and first
                ent.PassengerDoor = val==4
                ent.RearDoor = val==4 
            else
                ent.FrontDoor = val==4
                ent.RearDoor = val==4
            end
            if val == 1 then ent.BV:TriggerInput("Enable",1) end
            ent.Pneumatic.RightDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorRight = val==4
            ent.Pneumatic.LeftDoorState = val==4 and {1,1,1,1} or {0,0,0,0}
            ent.Pneumatic.DoorLeft = val==4
            ent.GV:TriggerInput("Set",val<4 and 1 or 0)
            ent._SpawnerStarted = val
        end
      if val~=2 then     ent.Pneumatic.TrainLinePressure = val==3 and math.random()*4 or val==2 and 4.5+math.random()*3 or 7.6+math.random()*0.6 end 
        if val==4 then ent.Pneumatic.BrakeLinePressure = 5.2 end
        if val==2 then ent.Pneumatic.TrainLinePressure = 5 end 
    end},
    --{"Lighter","Spawner.717.Lighter","Boolean"},
    --{"ARSType","Spawner.717.ARS","List",{"Spawner.717.ARS.1","Spawner.717.ARS.2","Spawner.717.ARS.3"--[[,"Spawner.717.ARS.4"]]}},
    --{"Cran","Spawner.717.CranType","List",{"334","013"}},
    --{"MaskType","Spawner.717.MaskType","List",{"2-2","2-2-2","Spawner.717.MaskType.1","Spawner.717.MaskType.2","1-1","Spawner.717.MaskType.3"}},
    --{"LED","Spawner.717.LED","Boolean"},
    --{"BPSNType","Spawner.717.BPSNType","List",{"Spawner.717.BPSNType.1","Spawner.717.BPSNType.2","Spawner.717.BPSNType.3","Spawner.717.BPSNType.4","Spawner.717.BPSNType.5","Spawner.717.BPSNType.6","Spawner.717.BPSNType.7","Spawner.717.BPSNType.8","Spawner.717.BPSNType.9","Spawner.717.BPSNType.10","Spawner.717.BPSNType.11","Spawner.717.BPSNType.12","Spawner.717.BPSNType.13"}},
    --{"NewKV","Spawner.717.NewKV","Boolean"},
    --{"HornType","Spawner.717.HornType","Boolean"},
    --{"RingType","Spawner.717.RingType","List",{"Spawner.717.RingType.1","Spawner.717.RingType.2","Spawner.717.RingType.3","Spawner.717.RingType.4","Spawner.717.RingType.5","Spawner.717.RingType.6","Spawner.717.RingType.7","Spawner.717.RingType.8"}},
    --[[ {"NM","Spawner.717.NM","Slider",1,0,9.0,8.2,function(ent,val) ent.Pneumatic.TrainLinePressure = val end},
    {"Battery","Spawner.717.Battery","Boolean",true,function(ent,val) ent.VB:TriggerInput("Set",val) end},
    {"Switches","Spawner.717.Switches","Boolean",true,function(ent,val)
        for k,v in pairs(ent.Panel.AVMap) do
            if not ent[v] then continue end
            ent[v]:TriggerInput("Set",val and 1 or 0)
        end
    end,function(CB,VGUI)
        VGUI.SwitchesR:SetDisabled(not CB:GetChecked())
        if not CB:GetChecked() then
            VGUI.SwitchesR:SetValue(false)
        end
    end},
    {"SwitchesR","Spawner.717.SwitchesR","Boolean",false,function(ent,val)
        if not val then return end
        for k,v in pairs(ent.Panel.AVMap) do
            if not ent[v] then continue end
            ent[v]:TriggerInput("Set",math.random() > 0.2 and 1 or 0)
        end
    end},
    {"DoorsL","Spawner.717.DoorsL","Boolean",false, function(ent,val,rot)
            if rot then
                ent.Pneumatic.RightDoorState = val  and {1,1,1,1} or {0,0,0,0}
            else
                ent.Pneumatic.LeftDoorState = val  and {1,1,1,1} or {0,0,0,0}
            end
    end},
    {"DoorsR","Spawner.717.DoorsR","Boolean",false, function(ent,val,rot)
            if rot then
                ent.Pneumatic.LeftDoorState = val  and {1,1,1,1} or {0,0,0,0}
            else
                ent.Pneumatic.RightDoorState = val  and {1,1,1,1} or {0,0,0,0}
            end
    end},
    {"GV","Spawner.717.GV","Boolean",true,function(ent,val) ent.GV:TriggerInput("Set",val) end},
    {"PB","Spawner.717.PB","Boolean",false,function(ent,val) ent.ParkingBrake:TriggerInput("Set",val) end},
    {"BortLampType","Spawner.717.BortLampType","List",{"Spawner.717.BortLampType.1","Spawner.717.BortLampType.2"}},
    {"MVM","Spawner.717.MVM","Boolean",true},
    {"HandRail","Spawner.717.HandRail","List",{"Spawner.717.Common.Old","Spawner.717.Common.New"}},
    {"SeatType","Spawner.717.SeatType","List",{"Spawner.717.Common.Old","Spawner.717.Common.New"}},
    {"LampType","Spawner.717.LampType","List",{"Spawner.717.Common.Type1","Spawner.717.Common.Type2","Spawner.717.Common.Type3"}},
    {"Breakers","Spawner.717.Breakers","Boolean"},
    {"Adverts","Spawner.717.Adverts","List",{"Spawner.717.Common.Type1","Spawner.717.Common.Type2","Spawner.717.Common.Type3","Spawner.717.Adverts.4"}},--]]
}
