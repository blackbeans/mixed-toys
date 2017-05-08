#!/usr/bin/ruby

MAX_LATITUDE  = 90.000000
MIN_LATITUDE  = -90.000000
MAX_LONGITUDE = 180.000000
MIN_LONGITUDE = -180.000000
bits = [16, 8, 4, 2, 1]
BASE32 = "0123456789bcdefghjkmnpqrstuvwxyz"


lat=40.01976013
lng=116.45988464
minLat, maxLat  = MIN_LATITUDE, MAX_LATITUDE
minLng, maxLng  = MIN_LONGITUDE, MAX_LONGITUDE
mid = 0

geohash=""
bit, ch, length, isEven = 0, 0, 0, true
while length < 6 do
	if isEven then
		 mid = (minLng + maxLng) / 2
		if mid < lng then
			ch = ch |bits[bit]
			minLng = mid
		else 
			maxLng = mid
		end
	else 
		mid = (minLat + maxLat) / 2
		if mid < lat then
			ch |= bits[bit]
			minLat = mid
		else 
			maxLat = mid
		end
	end

	isEven = !isEven
	if bit < 4 then
		bit=bit+1
	else 
		geohash= geohash+BASE32[ch]
		length, bit, ch = length+1, 0, 0
	end
end

puts geohash
