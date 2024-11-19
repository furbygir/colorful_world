local function comp(a)
    local b
    if (a > 15) or (a < 0) then error("ERROR: 'a' can't be greater than 15 or lower than 0")
    elseif a == 15 then b = "f" 
    elseif a == 14 then b = "e"
    elseif a == 13 then b = "d"
    elseif a == 12 then b = "c"
    elseif a == 11 then b = "b"
    elseif a == 10 then b = "a"
    else b = tostring(a) end
    return b
end

function dec_to_hex(dec)
    local a = tonumber(dec)
    local b
    local d
    while a >= 16 do
        local c = a % 16
        a = math.floor(a / 16)
        if b == nil then
            b = comp(c)
        else
            b = comp(c) .. b
        end
    end
    local hex 
    if b == nil then
        hex = comp(a)
    else
        hex = comp(a) .. b
    end
    return hex
end

minetest.register_chatcommand("dth", {
	params = "<dec>",
    func = function(_, dec)
        minetest.chat_send_all(dec_to_hex(dec))
	end
})

local function hex_to_color(hex, col_len)
    local a
    local col
    if col_len == nil then a = 3 else a = col_len end
    if hex:len() >= a then col = hex 
    elseif hex:len() < a then
        for i = hex:len(), a - 1 do
            if col == nil then
                col = "0" .. hex
            else
                col = "0" .. col
            end
        end
    end
    return col
end

minetest.register_chatcommand("htc", {
	params = "<dec>",
    func = function(_, dec)
        minetest.chat_send_all(hex_to_color(dec_to_hex(dec)))
	end
})

for i = 0, 4095 do
    minetest.register_node(":color_"..hex_to_color(dec_to_hex(i)), {
        description = minetest.colorize("#"..hex_to_color(dec_to_hex(i)), hex_to_color(dec_to_hex(i))),
    	tiles = {"default_cobble.png^[colorize:#"..hex_to_color(dec_to_hex(i))..":255"},
    	is_ground_content = false,
    	groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 3, cracky = 3},
    })
end
