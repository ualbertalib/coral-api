FROM astrilet/coralbase
COPY . /src
WORKDIR /src
ENTRYPOINT /src/tests/acceptance/setDockerImg.sh
