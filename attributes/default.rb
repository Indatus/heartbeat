default['heartbeat']['conf_dir'] = '/etc/ha.d'

#ha.cf related settings
default['heartbeat']['config']['watchdog']      = "/dev/watchdog"
default['heartbeat']['config']['logfile']       = "/var/log/ha-log"
default['heartbeat']['config']['debugfile']     = "/var/log/ha-debug"
default['heartbeat']['config']['logfacility']   = "none"
default['heartbeat']['config']['deadtime']      = 5
default['heartbeat']['config']['warntime']      = 10
default['heartbeat']['config']['initdead']      = 15
default['heartbeat']['config']['bcast']         = 'eth0'
default['heartbeat']['config']['auto_failback'] = true # 'on'
default['heartbeat']['config']['keepalive']     = 2
default['heartbeat']['config']['udpport']       = 694
default['heartbeat']['config']['nodes']         = []
default['heartbeat']['config']['shared_ip']     = nil

#authkeys related settings
default['heartbeat']['config']['active_key']    = 1
default['heartbeat']['config']['authkeys']      = ["yourpasswordhere"]