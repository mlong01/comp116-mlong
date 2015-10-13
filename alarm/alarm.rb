require 'packetfu'

NULL_FLAGS = 0
FIN_FLAGS = 1
XMAS_FLAGS = 41

def print_incident(num, inc, src, prot, pay)
	inc_string = "#" + num.to_s()
	inc_string += ". ALERT: " + inc.to_s()
	inc_string += " is detected from " + src.to_s()
	inc_string += " (" + prot.to_s() + ")"
	inc_string += " (" + pay.to_s() + ")"
	puts inc_string
end

if ARGV.length == 2 then
	if ARGV[0] != "-r" then
		puts "USAGE: ruby alarm.rb [-r] [log_file]"
	else
		puts "ur doin it!"
	end

else

	pkts = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
	incidents = 0

	pkts.stream.each do |p|
		pkt = PacketFu::Packet.parse(p)
		
		if pkt.is_ip? then
			if pkt.is_tcp? then
				puts "Payload: " + pkt.payload
				if pkt.tcp_flags.to_i() == NULL_FLAGS then
					print_incident(incidents, "NULL Scan", pkt.ip_saddr, "TCP", pkt.payload())
					incidents += 1
				elsif pkt.tcp_flags.to_i() == FIN_FLAGS then
					print_incident(incidents, "FIN Scan", pkt.ip_saddr, "TCP", pkt.payload())
					incidents += 1
				elsif pkt.tcp_flags.to_i() == XMAS_FLAGS then
					print_incident(incidents, "XMAS Scan", pkt.ip_saddr, "TCP", pkt.payload())
					incidents += 1
				end		
			end
		end
	end
end

