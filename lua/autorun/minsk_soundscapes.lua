if not game.GetMap():find("minsk") then return end 
local soundscape = [[
    "depot_bird_ambient"
{
	"dsp"	"0"
	"playlooping"
	{
		"volume"	"1.2"
		"pitch"		"100"
		"soundlevel" "SNDLVL_50dB"
		"wave"		"depot/depot_street1.wav"
	}
}

"depot_road_ambient"
{
	"dsp"	"0"
	"playlooping"
	{
		"volume"	"1.2"
		"pitch"		"100"
		"soundlevel" "SNDLVL_100dB"
		"wave"		"depot/depot_street2.wav"
	}

	"playlooping"
	{
		"volume"	"0.6"
		"pitch"		"100"
		"soundlevel" "SNDLVL_30dB"
		"wave"		"depot/depot_street1.wav"
	}
}


"tunnel_ambient"
{
	"dsp"	"1"
	"playlooping"
	{
		"volume"	"0.5"
		"pitch"		"100"
		"soundlevel" "SNDLVL_130dB"
		"wave"		"ambient/tunnel_ambient1.wav"
	}
}

"depot_inside_ambient"
{
	"dsp"	"1"

	"playlooping"
	{
		"volume"	"0.1"
		"pitch"		"60"
		"soundlevel" "SNDLVL_50dB"
		"wave"		"ambient/tunnel_ambient1.wav"
	}
	"playlooping"
	{
		"volume"	"0.3"
		"pitch"		"100"
		"soundlevel" "SNDLVL_30dB"
		"wave"		"depot/depot_street1.wav"
	}
}
"depot_ssv_ambient"
{
	"dsp"	"1"

	"playlooping"
	{
		"volume"	"0.2"
		"pitch"		"100"
		"wave"		"ambient/tunnel_ambient1.wav"
	}
	"playlooping"
	{
		"volume"	"0.4"
		"pitch"		"70"
		"soundlevel" "SNDLVL_70dB"
		"wave"		"depot/depot_street1.wav"
	}
	"playlooping"
	{
		"volume"	"0.6"
		"pitch"		"100"
		"soundlevel" "SNDLVL_70dB"
		"wave"		"depot/depot_street2.wav"
	}
}
]]
local soundscape_2 = [[
	soundscapes_manifest
{
	// Minsk
	"file"		"scripts/soundscapes/soundscapes_metro_minsk_1984.txt"
}
]]
if not file.Exists("scripts/soundscapes/soundscapes_metro_minsk_1984.txt","DATA") then
file.CreateDir("scripts/soundscapes/")
file.Write( "scripts/soundscapes/soundscapes_metro_minsk_1984.txt", soundscape) 
file.Write( "scripts/soundscapes_manifest.txt", soundscape_2) 

end    