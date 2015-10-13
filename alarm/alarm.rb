require 'packetfu'

NULL_SCAN = 0
FIN_SCAN = 1
XMAS_SCAN = 41

def print_incident(num, inc, src, prot, pay)
	inc_string = "#" + num.to_s()
	inc_string += ". ALERT: " + inc.to_s()
	inc_string += " is detected from " + src.to_s()
	inc_string += " (" + prot.to_s() + ")"
	inc_string += " (" + pay.to_s() + ")"
	puts inc_string
end

pkts = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
incidents = 0

pkts.stream.each do |p|
	pkt = PacketFu::Packet.parse(p)
	
	if pkt.is_ip? then
		if pkt.is_tcp? then
			if pkt.tcp_flags.to_i() == NULL_SCAN then
				print_incident(incidents, "NULL Scan", pkt.ip_saddr, "TCP", pkt.payload())
				incidents += 1
			elsif pkt.tcp_flags.to_i() == FIN_SCAN then
				print_incident(incidents, "FIN Scan", pkt.ip_saddr, "TCP", pkt.payload())
				incidents += 1
			elsif pkt.tcp_flags.to_i() == XMAS_SCAN then
				print_incident(incidents, "XMAS Scan", pkt.ip_saddr, "TCP", pkt.payload())
				incidents += 1
			end		
		end
	end
end


