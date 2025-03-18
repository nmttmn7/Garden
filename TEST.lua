-- Create a table (dictionary)
local myFunctions = {}



function OO(nome)
    print("Hello, " .. nome .. "!")
end

myFunctions['OO'] = OO
myFunctions['tulipa'] = Tulipa

myFunctions['OO']('Nome')
local t = myFunctions['tulipa']
if t == nil then
    print('NIL')

else
    print('NOT NIL')
end


-- Table to hold all class definitions
local Classes = {}

-- Base Animal Class
Classes.Animal = {}
Classes.Animal.__index = Classes.Animal

function Classes.Animal:new(name)
    local self = setmetatable({}, self)
    self.name = name
    return self
end

function Classes.Animal:speak()
    print(self.name .. " makes a noise.")
end

-- Dog Class (inherits from Animal)
Classes.Dog = setmetatable({}, { __index = Classes.Animal })
Classes.Dog.__index = Classes.Dog

function Classes.Dog:new(name, breed)
    local self = setmetatable(Classes.Animal:new(name), self)
    self.breed = breed
    return self
end

function Classes.Dog:speak()
    print(self.name .. " barks! (Breed: " .. self.breed .. ")")
end

-- Cat Class (inherits from Animal)
Classes.Cat = setmetatable({}, { __index = Classes.Animal })
Classes.Cat.__index = Classes.Cat

function Classes.Cat:new(name)
    local self = setmetatable(Classes.Animal:new(name),Classes.Animal:new(name))
    return self
end

function Classes.Cat:speak()
    print(self.name .. " meows!")
end

-- Function to dynamically instantiate a class
function instantiate(className, ...)
    local class = Classes[className]
    if class and class.new then
        return class:new(...)
    else
        error("Class '" .. tostring(className) .. "' not found!")
    end
end

-- Dynamically create instances
local myDog = instantiate("Dog", "Buddy", "Golden Retriever")
local myCat = instantiate("Cat", "Whiskers")

-- Call methods
myDog:speak()  -- Output: Buddy barks! (Breed: Golden Retriever)
myCat:speak()  -- Output: Whiskers meows!
