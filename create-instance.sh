# application details
version=0.1
# server_name=YOUR_SERVER
server_name=

# aws credentials
# access_key=YOUR_KEY
access_key=
# access_secret=YOUR_SECRET
access_secret=

# Use Machine to create the instance
docker-machine create --driver amazonec2 --amazonec2-access-key $access_key  --amazonec2-secret-key $access_secret  $server_name

#is i possible to configure route53 as code?
#always create a new machine?
#how to handover this process? and how to automate?