# application details
version=1.0.2
app_name=

# values
# timestamp=$(date +%s)

# Log off current machine
echo "Log off current machine"

eval $(docker-machine env -u)

# set context to aws machine, every subsequent docker action
# is run agains this daemon
echo "Log in aws ec2 with docker-machine"
eval $(docker-machine env $app_name)
echo "Logged at $app_name"

# Get the IP address of new EC2 instance
# Copy this IP and add an A record to the hosted zone
EC2IP=$(docker-machine ip $app_name)

echo "EC2 instance public address: $EC2IP"

# Removing old container and images image on EC2
echo "Removing previous containers at $EC2IP, if any"
docker-compose stop; docker-compose rm -f

# Recreating acme.json because in every deploy we will recertificate app
echo "Remove previous, if any, and create acme.json for new Let's Encrypt DNS Certification"

rm -rf acme.json
touch acme.json
chmod 600 acme.json

# Sending Local folder and files to container
Echo "Transfering files from ${PWD} to $app_name"

docker-machine scp -r -d ${PWD}/ $app_name:~/reverse-proxy-traefik/

# Create image on EC2
echo "Create containers at EC2 server $app_name"
docker-compose up -d

