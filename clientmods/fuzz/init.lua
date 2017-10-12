
local function hexenc(hex)
	local o = ""
	for byte in hex:gmatch("%x%x") do
		o = o .. string.char(tonumber(byte, 16))
	end
	return o
end

core.register_chatcommand("fuzz", {
	description = core.gettext("fuzz server packets"),
	func = function(param)
		local rounds = 1
		if tonumber(param) or 0 > 0 then
			rounds = tonumber(param)
		end

		local t_begin = os.time()
		local cmd = hexenc("0031") --INV
		for length = 16, 64, 16 do
			for n = 1, rounds do

				local pkt = cmd
				for i = 1, length do
					pkt = pkt .. string.char(math.random(0, 255))

				end
				core.send_packet(pkt)
			end
		end
		local t_end = os.time()
		return true, "fuzzing ended (" .. t_end - t_begin .. "s)"
	end
})

