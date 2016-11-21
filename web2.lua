pinDHT = 7

wifi.setmode(wifi.STATION)
wifi.sta.config("wifi","********")
print(wifi.sta.getip())

srv=net.createServer(net.TCP)
srv:listen(80, function(conn)
    conn:on("receive", function(client, request)
        print(request)

        local buf = "HTTP/1.1 200 OK\r\n";
        buf = buf.."Content-type: text/html\r\n";
        buf = buf.."Connection: close\r\n\r\n";
        buf = buf.."<html><body>";
        buf = buf.."<h1>ESP8266 Web Server</h1>";

        local status,temp,humi,temp_decimal,humi_decimal = dht.read(pinDHT)
        if (status == dht.OK) then
            buf = buf.."<p>Temperature: "..temp.."."..temp_decimal.." C</p>";
            buf = buf.."<p>Humidity: "..humi.."."..humi_decimal.." %</p>";
        elseif (status == dht.ERROR_CHECKSUM) then
            buf = buf.."<p>DHT Checksum error</p>";
        elseif (status == dht.ERROR_TIMEOUT) then
            buf = buf.."<p>DHT Time out</p>";
        end

        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
