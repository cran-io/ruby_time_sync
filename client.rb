require 'socket'
require 'timers'
require 'time'

timers = Timers.new

s = TCPSocket.new '0.0.0.0', 3000

delta_f = 0
sigma_f = 0

step = 2.0

loop do
	s.puts Time.now.strftime("%H%M%S.%L")

	resp = s.gets.split('/')
	#p resp

	r_time = Time.now

	t0 = Time.parse(resp[0])
	t1 = Time.parse(resp[1])
	t2 = t1
	t3 = r_time

	t_tick = Time.parse(resp[3])

	delta = t3 - t0

	delta_f = (delta_f + delta) / 2.0


	sigma = ((t1 - t0) + (t2 - t3)) / 2.0

	sigma_f = (sigma_f + sigma) / 2.0

	timers.after( (t_tick + step) - (Time.now + sigma_f) - (delta_f/2.0)  ) { p (resp[2].to_f + step).to_s + ' s = ' + sigma_f.to_s + ' d = '+ delta_f.to_s}
	timers.wait

	sleep step/10.0

end