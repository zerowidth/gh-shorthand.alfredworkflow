#!/usr/bin/env ruby
url = ARGV[0]
if %r(github\.com/(?<user>[^/]+)/(?<repo>[^/]+)/(issues|pull)/(?<id>\d+)) =~ url
  print "%s/%s#%s" % [user, repo, id]
else
  print url
end
