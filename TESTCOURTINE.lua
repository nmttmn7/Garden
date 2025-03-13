local function routine2()
    for i = 11, 20 do
        print('routine2: ' .. i)
    end
    coroutine.resume(routine1)
end
local routine2 = coroutine.create(routine2)

 routine1 = coroutine.create(function ()
    for i=1,10 do
      print("co", i)

      if i == 5 then
        
        coroutine.yield()
      end
      
    end
  end)

  local function routine3(w)
    print('WWWW: ' .. w)
    for i=1,10 do
        print("co", i)
  
        if i == 5 then
          coroutine.yield()
        end
        
      end
end



local routine3 = coroutine.create(routine3)

coroutine.resume(routine1)
coroutine.resume(routine2)