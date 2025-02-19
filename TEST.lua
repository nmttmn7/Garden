local Class = {
    a = 0,
    b= 0,
    c = 0
}

function Class.new(a,b,c)
    local self = setmetatable({}, Class)
    
    self.a = a
    self.b = b
    self.c = c

    return self
end

function Class:add()
    return self.a + self.b + self.c
end

local instance = Class.new (1,3,5)
print(instance:add())