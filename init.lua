-- Bruno de Holanda
-- Complete project details at http://nerdking.net.br

wifi.setmode(wifi.STATION)
wifi.sta.config("Holanda Home","q6td99fmq3frvf4vpf7y38jv3")
print(wifi.sta.getip())
led1 = 3
gpio.mode(led1, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        buf = buf.."HTTP/1.1 200 OK\n\n"
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        
        if(_GET.pin == "ON1")then
              gpio.write(led1, gpio.LOW);
              elseif(_GET.pin == "OFF1")then
              gpio.write(led1, gpio.HIGH);
            end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)