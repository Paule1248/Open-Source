local VariablesManager = {}
VariablesManager.__index = VariablesManager

local getType = (typeof or type)
local t_insert = table.insert
local t_remove = table.remove
local next = next

function VariablesManager.new()
    return setmetatable({
        _v = {},
        _t = {},
        _c = {},
        _ro = {}
    }, VariablesManager)
end

function VariablesManager:Add(name, value, expectedType, isReadOnly)
    if self._v[name] ~= nil then return false, "Variable already exists" end
    self._v[name] = value
    self._t[name] = expectedType or getType(value)
    if isReadOnly then self._ro[name] = true end
    return true
end

function VariablesManager:Set(name, value)
    local varType = self._t[name]
    if not varType then return false, "Variable not found" end
    if self._ro[name] then return false, "Variable is read-only" end

    if getType(value) ~= varType then
        return false, "Type mismatch: Expected " .. varType .. ", got " .. getType(value)
    end

    local oldVal = self._v[name]
    if oldVal ~= value then
        self._v[name] = value
        local cb = self._c[name]
        if cb then cb(value, oldVal) end
    end
    return true
end

function VariablesManager:Get(name)
    return self._v[name]
end

function VariablesManager:OnChange(name, callback)
    if self._v[name] ~= nil then
        self._c[name] = callback
        return true
    end
    return false
end

function VariablesManager:Increment(name, amount)
    if self._t[name] == "number" and not self._ro[name] then
        local current = self._v[name] or 0
        return self:Set(name, current + (amount or 1))
    end
    return false, "Variable is not a number or is read-only"
end

function VariablesManager:TableInsert(name, value)
    local tbl = self._v[name]
    if self._t[name] ~= "table" or self._ro[name] then return false end
    t_insert(tbl, value)
    local cb = self._c[name]
    if cb then cb(tbl, tbl) end
    return true
end

function VariablesManager:TableRemove(name, indexOrValue)
    local tbl = self._v[name]
    if self._t[name] ~= "table" or self._ro[name] then return false end
    if type(indexOrValue) == "number" then
        t_remove(tbl, indexOrValue)
    else
        for i, v in ipairs(tbl) do
            if v == indexOrValue then
                t_remove(tbl, i)
                break
            end
        end
    end
    local cb = self._c[name]
    if cb then cb(tbl, tbl) end
    return true
end

function VariablesManager:TableSet(name, key, value)
    local tbl = self._v[name]
    if self._t[name] ~= "table" or self._ro[name] then return false end
    tbl[key] = value
    local cb = self._c[name]
    if cb then cb(tbl, tbl) end
    return true
end

function VariablesManager:TableClear(name)
    local tbl = self._v[name]
    if self._t[name] ~= "table" or self._ro[name] then return false end
    for k in next, tbl do tbl[k] = nil end
    local cb = self._c[name]
    if cb then cb(tbl, tbl) end
    return true
end

function VariablesManager:BatchSet(data)
    for name, value in next, data do
        self:Set(name, value)
    end
end

function VariablesManager:Remove(name)
    self._v[name] = nil
    self._t[name] = nil
    self._c[name] = nil
    self._ro[name] = nil
end

function VariablesManager:Export()
    local dump = {}
    for k, v in next, self._v do dump[k] = v end
    return dump
end
return VariablesManager
