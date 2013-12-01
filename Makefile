.PHONY: development production test

FOREMAN  = foreman
MOCHA    = ./node_modules/.bin/mocha
LOGFILE  = ./tmp/$@.log

export NODE_ENV    = $@
export PORT        = 3000
export MONGODB     = mongodb://localhost/example_$@
export SESS_TOKEN  = keyboardcat
export SESS_PREFIX = sess_server:

development:
	$(FOREMAN) start web -p $(PORT) | tee -a $(LOGFILE)

production:
	$(FOREMAN) start web -p $(PORT) | tee -a $(LOGFILE)

test:
	$(MOCHA) --compilers coffee:coffee-script --check-leaks --slow 20 tests

