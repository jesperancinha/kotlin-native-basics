b:
	cd add; \
	make
	cd puts; \
	make
	cd return42; \
	make
build-pipeline:
	cd add; \
	make pipeline
	cd puts; \
	make pipeline
	cd return42; \
	make pipeline
install:
	yes | sudo snap install --classic kotlin; \
	sudo apt install -y llvm-19 clang-19; \
	bash install-konanc.sh
llvm_version:
	llvm-config-19 --version
deps-plugins-update:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/pluginUpdatesOne.sh | bash -s -- $(PARAMS)
deps-java-update:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/javaUpdatesOne.sh | bash
deps-quick-update: deps-plugins-update deps-java-update
update-repo-prs:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/update-all-repo-prs.sh | bash
accept-prs:
	curl -sL https://raw.githubusercontent.com/jesperancinha/project-signer/master/acceptPR.sh | bash
