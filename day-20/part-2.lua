#!/usr/bin/env lua

function set_default(t, d)
    local mt = {__index = function() return d end}
    setmetatable(t, mt)
end

mapping = {}
image = {}
set_default(image, '0')

y = 1
for line in io.lines(arg[1]) do
    if y == 1 then
        mapping_line = line:gsub('%.', '0'):gsub('#', '1')
        for i = 1, #mapping_line do
            mapping[i - 1] = mapping_line:sub(i, i)
        end
    elseif #line > 0 then
        for x = 1, #line do
            image[(x - 1) .. ',' .. y - 3] =
                line:sub(x, x) == '#' and '1' or '0'
        end
    end

    y = y + 1
end

default = '0'
for _ = 1, 50 do
    local enhanced_image = {}
    set_default(enhanced_image, new_default)
    set_default(image, default)
    local new_default = mapping[tonumber(string.rep(default, 9), 2)]

    x_min, x_max, y_min, y_max = 0, 0, 0, 0
    for index in pairs(image) do
        x, y = index:match('(-?%d+),(-?%d+)')
        x_min = math.min(x_min, x)
        x_max = math.max(x_max, x)
        y_min = math.min(y_min, y)
        y_max = math.max(y_max, y)
    end

    for x = x_min - 5, x_max + 5 do
        for y = y_min - 5, y_max + 5 do
            local num = ''
            for dy = -1, 1 do
                for dx = -1, 1 do
                    i, j = x + dx, y + dy
                    num = num .. image[i .. ',' .. j]
                end
            end

            local new_value = mapping[tonumber(num, 2)]
            if new_value ~= new_default then
                enhanced_image[x .. ',' .. y] = new_value
            end
        end
    end

    default = new_default
    image = enhanced_image
end

sum = 0
for _, v in pairs(image) do if v == '1' then sum = sum + 1 end end
print(sum)
