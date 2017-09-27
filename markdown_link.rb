#!/usr/bin/env ruby
url = ARGV[0]
if %r(github\.com/(?<user>[^/]+)/(?<repo>[^/]+)/(issues|pull)/(?<id>\d+)(#(?<anchor>.*))?) =~ url
  without_anchor = url.split("#",2).first
  print "[%s/%s#%s](%s)" % [user, repo, id, without_anchor]
else
  print url
end
