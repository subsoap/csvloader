-- This does not handle escaped commas with quotes!

local M = {}

function split(s,delimiter)
	delimiter = delimiter or '%s'
	local t={}
	local i=1
	for str in string.gmatch(s .. delimiter, '([^' .. delimiter .. ']*)' .. delimiter) do
		t[i] = str
		i = i + 1
	end
	return t
end

local function read_file(file)
	local f = assert(io.open(file, "rb"))
	local content = f:read("*all")
	f:close()
	return content
end

local function normalize_line_endings(file)
	return string.gsub(file, '\r\n?', '\n')
end

function M.parse_csv(csv_file)
	local csv_table = {}
	csv_file = normalize_line_endings(csv_file)
	for line in csv_file:gmatch("(.-)\n") do
		table.insert(csv_table, split(line, ","))
	end
	return csv_table
end


function M.load_file(file_path)
	local data = read_file(file_path)
	if data then
		local data_table = M.parse_csv(data)
		return data_table
	else
		print(error)
		return nil
	end
end

function M.load_resource(resource_path)
	local data, error = sys.load_resource(resource_path)
	if data then
		local data_table = M.parse_csv(data)
		return data_table
	else
		print(error)
		return nil
	end	
end

return M