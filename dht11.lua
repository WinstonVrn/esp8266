PIN = 7

local status,temp,humi,temp_decimal,humi_decimal = dht.read(PIN)

if (status == dht.OK) then
    print("Temperature: "..temp.."."..temp_decimal.." C");
    print("Humidity: "..humi.."."..humi_decimal.." %");
elseif (status == dht.ERROR_CHECKSUM) then
    print("DHT Checksum error");
elseif (status == dht.ERROR_TIMEOUT) then
    print("DHT Time out");
end
