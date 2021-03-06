require 'socket'
require 'timers'
require 'time'

server = TCPServer.new 3000
timers = Timers.new

t = 0
t_time = Time.now

step = 2.0

thr = Thread.new do
	timers.every(step) do
		t += step
		t_time = Time.now
		p t
	end

	loop do
		timers.wait
	end
end

threads = []
2.times do |n|
	threads << Thread.new do
		p "Waiting for client #{n}."
		client = server.accept

		p "Connected #{n}."
		loop do
			c_t = client.gets.strip
			client.puts(c_t + '/' + Time.now.strftime("%H%M%S.%L") + '/' + t.to_s + '/' + t_time.strftime("%H%M%S.%L"))

		end
	end
end

threads.each{|tt|tt.join}

