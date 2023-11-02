auto:
	cd automations && go run automate.go

reload:
	go build -o main
	sudo ./main

build:
	go mod tidy 
	go build -o main main.go 
	go build -o automate automations/automate.go

test:
	go clean -testcache -cache
	go test ./... -coverprofile=./coverage.out

update_version:
	./deploy/update_version.sh $(REPO_HOST) $(REPO_TYPE) $(REPO_SSH_USER) $(REPO_SSH_PASS) $(PACKAGE_NAME)

build_deb:
	./deploy/build_deb.sh

deploy_deb:
	./deploy/deploy_deb.sh $(REPO_HOST) $(REPO_TYPE) $(REPO_SSH_USER) $(REPO_SSH_PASS) $(REPO_PUBLISH_PASSPHRASE) $(DEB_PACKAGE_NAME)

# hot reload for temporary usage: scp main root@103.195.71.117:/root/
buildAndDeployDebianStaging:
	go build -o main
	cp main deb-build/opt/sugarbox/httpsproxy
	cp config.toml deb-build/etc/httpsproxy
	dpkg-deb --build deb-build/ httpsproxy.deb
	scp httpsproxy.deb root@103.195.71.140:/root/
	# scp httpsproxy.deb root@103.195.71.141:/root/
