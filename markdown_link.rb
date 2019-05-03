#!/usr/bin/env ruby
url = ARGV[0]
if %r(https://github\.com/(?<user>[^/]+)/(?<repo>[^/]+)/(issues|pull)/(?<id>\d+)(#(?<anchor>.*))?) =~ url
  without_anchor = $&.split("#",2).first
  print "[%s/%s#%s](%s)" % [user, repo, id, without_anchor]
elsif %r(https://github\.com/orgs/(?<org>[^/]+)/teams/(?<team>[^/]+)/discussions/(?<id>\d+)(#(?<anchor>.*))?) =~ url
  without_anchor = $&.split("#",2).first
  print "[@%s/%s#%s](%s)" % [org, team, id, without_anchor]
else
  print url
end
