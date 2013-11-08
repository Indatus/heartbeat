name             'heartbeat'
maintainer       'Indatus'
maintainer_email 'bwebb@indatus.com'
license          'All rights reserved'
description      'Installs/Configures heartbeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "heartbeat", "Installs, but does not configure, heartbeat"

%w{ debian ubuntu }.each do |os|
  supports os
end
