echo "---------------------------------"
echo " building Rotors CBF docker image"
echo "---------------------------------"

DOCKER_BUILDKIT=1 docker build -t ghcr.io/achilleas2942/rotors-cbf .