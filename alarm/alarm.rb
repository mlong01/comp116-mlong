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
		incidents = 0

		in_quotes_regex = /(["'])(?:(?=(\\?))\2.)*?\1/
		ip_regex = /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/
		
		nmap_regex = /(?i)nmap(?-i)/		# case-insensitive 'nmap'
		nikto_regex = /(?i)nikto(?-i)/		# case-insensitive 'nikto'
		masscan_regex = /(?i)masscan(?-i)/	# case-insensitive 'masscan'
		shellshock_regex = /\(\) *{ *:; *} *;/	# space-ignorant '() { :; } ;'
		php_regex = /(?i)phpMyAdmin(?-i)/	# case-insensitive 'phpmyadmin'
		shell_code_regex = /\\x.{2,}/		# \x followed by 2 or more chars


		logfile = File.new(ARGV[1], "r")
		
		while line = logfile.gets
			src_ip = line.match(ip_regex)
			prot = "HTTP"
			payload = line.match(in_quotes_regex).to_a() #Only matches first set of quotes

			if line.match(nmap_regex) then
				print_incident(incidents, "Nmap scan", src_ip, prot, payload)
				incidents += 1
			elsif line.match(nikto_regex) then
				print_incident(incidents, "Nikto scan", src_ip, prot, payload)
				incidents += 1
			elsif line.match(masscan_regex) then
				print_incident(incidents, "masscan attack", src_ip, prot, payload)
				incidents += 1
			elsif line.match(shellshock_regex) then
				print_incident(incidents, "Shellshock attack", src_ip, prot, payload)
				incidents += 1
			elsif line.match(php_regex) then
				print_incident(incidents, "phpMyAdmin stuff", src_ip, prot, payload)
				incidents += 1
			elsif line.match(php_regex) then
				print_incident(incidents, "Possible shell code", src_ip, prot, payload)
				incidents += 1
			end


		end
		logfile.close
	end

elsif ARGV.length == 0 then

	nmap_regex = /\x4E\x6D\x61\x70/
	nikto_regex = /\x4E\x69\x6B\x74\x6F/
	cc_regex = /[3,4,5,6]\d{3}[\ ,-]{0,1}\d{4}[\ ,-]{0,1}\d{4}[\ ,-]{0,1}\d{4}[\ ,-]{0,1}/

	pkts = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
	incidents = 0

	pkts.stream.each do |p|
		pkt = PacketFu::Packet.parse(p)
	
		if pkt.is_ip? then
			if pkt.is_tcp? then
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
		elsif pkt.payload.match(nmap_regex) then
			print_incident(incidents, "General NMAP Scan", pkt.ip_saddr, "TCP", pkt.payload())
			incidents += 1
		elsif pkt.payload.match(nikto_regex) then		
			print_incident(incidents, "Nikto Scan", pkt.ip_saddr, "TCP", pkt.payload())
			incidents += 1
		elsif pkt.payload.match(cc_regex) then
			print_incident(incidents, "Credit Cart # in the clear", pkt.ip_saddr, "TCP", pkt.payload())
			incidents += 1
		end
		
	end
else
	puts "USAGE: ruby alarm.rb [-r] [log_file]"
end

