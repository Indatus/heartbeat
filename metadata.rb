name             'heartbeat'
maintainer       'Indatus'
maintainer_email 'bwebb@indatus.com'
license          'All rights reserved'
description      'Installs/Configures heartbeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe "heartbeat", "Installs and configures heartbeat"

%w{ debian ubuntu }.each do |os|
  supports os
end
