ruby_time_sync
==============

An experiment at clock synchronization with Ruby.

Description
--------------

This project includes a client and server for clock synchronization.
It works somewhat like NTP, though in a *very* simplified way.

Requirements
--------------

Ruby and the timers gem.

How it works
--------------

### Server

Running `ruby server.rb` will start the server. It opens a socket on port 3000 and accepts a few clients (this is still quite ugly).
The server echoes whatever messages it receives along with a few timestamps: its current time, a tick count and the timestamp for the last tick.

### Client

Running `ruby client.rb` will start the client. It periodically sends its current time to the server.
Using the server's response, it calculates the clock offset (sigma) and round trip delay (delta), and sets a timer
to fire on the server clock's next tick.

To-Do
---------

It's all oh-so-very hardcoded. Next steps could include adding configurable amount of clients, configurable host and port,
making something fancier with the sync, or leaving it to gather dust.
Ideally, the client could be turned into a gem, allowing to perform arbitrary tasks in a synchronized manner.


