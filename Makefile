tmp:
	
	rm -rf .tmp
	mkdir -p .tmp 
	mkdir -p pkgs

clean:
	rm -rf pkgs
	rm -rf .tmp

xr-conf: tmp

	if [ -d ".tmp/xr-conf/.git" ]; then \
		cd .tmp/xr-conf && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.springboot-cnf .tmp/xr-conf; \
	fi
	mkdir -p pkgs/xr-conf
	cp .tmp/xr-conf/Makefile pkgs/xr-conf/
	cp .tmp/xr-conf/pom.xml pkgs/xr-conf/
	cp .tmp/xr-conf/.gitignore pkgs/xr-conf/
	cp .tmp/xr-conf/README.md pkgs/xr-conf/
	cp .tmp/xr-conf/CHANGELOG.md pkgs/xr-conf/


xr-bom: tmp

	if [ -d ".tmp/xr-bom/.git" ]; then \
		cd .tmp/xr-bom && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.springboot-bom .tmp/xr-bom; \
	fi
	mkdir -p pkgs/xr-bom
	cp .tmp/xr-bom/Makefile pkgs/xr-bom/
	cp .tmp/xr-bom/pom.xml pkgs/xr-bom/
	cp .tmp/xr-bom/.gitignore pkgs/xr-bom/
	cp .tmp/xr-bom/README.md pkgs/xr-bom/
	cp .tmp/xr-bom/CHANGELOG.md pkgs/xr-bom/
	cp -r .tmp/xr-bom/xr-springboot-fp-deps pkgs/xr-bom/xr-bom-fp 
	cp -r .tmp/xr-bom/xr-springboot-tp-deps pkgs/xr-bom/xr-bom-tp


xr-shared: tmp

	if [ -d ".tmp/xr-shared/.git" ]; then \
		cd .tmp/xr-shared && git pull; \
	else \
		git clone  https://github.com/retex-iconic/iconic.xr.shared-lib .tmp/xr-shared; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			 .tmp/xr-shared/ pkgs/xr-shared/

	if [ -d ".tmp/xr-shared-main/.git" ]; then \
		cd .tmp/xr-shared-main && git pull; \
	else \
		git clone  https://github.com/retex-iconic/iconic.xr.shared-main-lib .tmp/xr-shared-main; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			 .tmp/xr-shared-main/ pkgs/xr-shared-main/			 

xr-iam: tmp

	if [ -d ".tmp/xr-iam-main/.git" ]; then \
		cd .tmp/xr-iam-main && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.iam-main-lib .tmp/xr-iam-main; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			 .tmp/xr-iam-main/ pkgs/xr-iam-main/

	if [ -d ".tmp/xr-iam-backend/.git" ]; then \
		cd .tmp/xr-iam-backend && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.xrmsiam .tmp/xr-iam-backend; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-iam-backend/ pkgs/xr-iam-backend/

	if [ -d ".tmp/xr-iam-graphql/.git" ]; then \
		cd .tmp/xr-iam-grapqhl && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.iam-graphql .tmp/xr-iam-graphql; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-iam-graphql/ pkgs/xr-iam-graphql/

	if [ -d ".tmp/xr-iam-frontend/.git" ]; then \
		cd .tmp/xr-iam-frontend && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.frontend.iam .tmp/xr-iam-frontend; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-iam-frontend/ pkgs/xr-iam-frontend/

xr-ledger: tmp

	if [ -d ".tmp/xr-ledger-main/.git" ]; then \
		cd .tmp/xr-ledger-main && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.ledger-main-lib .tmp/xr-ledger-main; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			 .tmp/xr-ledger-main/ pkgs/xr-ledger-main/

	if [ -d ".tmp/xr-ledger-backend/.git" ]; then \
		cd .tmp/xr-ledger-backend && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.xrmsledger .tmp/xr-ledger-backend; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-ledger-backend/ pkgs/xr-ledger-backend/

	if [ -d ".tmp/xr-ledger-graphql/.git" ]; then \
		cd .tmp/xr-ledger-grapqhl && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.ledger-graphql .tmp/xr-ledger-graphql; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-ledger-graphql/ pkgs/xr-ledger-graphql/

	if [ -d ".tmp/xr-ledger-frontend/.git" ]; then \
		cd .tmp/xr-ledger-frontend && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.frontend.ledger .tmp/xr-ledger-frontend; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-ledger-frontend/ pkgs/xr-ledger-frontend/

xr-masterdata:

	if [ -d ".tmp/xr-masterdata-main/.git" ]; then \
		cd .tmp/xr-masterdata-main && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.masterdata-main-lib.git .tmp/xr-masterdata-main; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-masterdata-main/ pkgs/xr-masterdata-main/

	if [ -d ".tmp/xr-masterdata-backend/.git" ]; then \
		cd .tmp/xr-masterdata-backend && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.xrmsmasterdata.git .tmp/xr-masterdata-backend; \
	fi
	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-masterdata-backend/ pkgs/xr-masterdata-backend/

	if [ -d ".tmp/xr-masterdata-graphql/.git" ]; then \
		cd .tmp/xr-masterdata-graphql && git pull; \
	else \
		git clone https://github.com/retex-iconic/iconic.xr.masterdata-graphql.git .tmp/xr-masterdata-graphql; \
	fi

	rsync -av --exclude='.git' \
			  --exclude='release-please-config.json' \
			  --exclude='renovate.json' \
			  .tmp/xr-masterdata-graphql/ pkgs/xr-masterdata-graphql/


sed:
	
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/com.retexspa/com.retex/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-springboot-shared-config/xr-conf/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-springboot-bom/xr-bom/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-shared-main-lib/xr-shared-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-shared-lib/xr-shared/g' {} +

	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/>xrmsiam/>xr-iam-backend/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xriam-main-lib/xr-iam-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-iam-main-lib/xr-iam-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xriam-graphql/xr-iam-graphql/g' {} +

	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/>xrmsledger/>xr-ledger-backend/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xrledger-main-lib/xr-ledger-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-ledger-main-lib/xr-ledger-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xrledger-graphql/xr-ledger-graphql/g' {} +

	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/>xrmsmasterdata/>xr-masterdata-backend/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-masterdata-main-lib/xr-masterdata-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xr-masterdata-main-lib/xr-masterdata-main/g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/xrmasterdata-graphql/xr-masterdata-graphql/g' {} +
	
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/SpringBoot XR/XR/g' {} +

	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's@xr-springboot-tp-deps@xr-bom-tp@g' {} +	
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's@xr-springboot-fp-deps@xr-bom-fp@g' {} +		
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's@retex-iconic/iconic.xr.springboot-cnf@weareretx/iconic.xr.suite@g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's@retex-iconic/iconic.xr.springboot-bom@weareretx/iconic.xr.suite@g' {} +	
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's@retex-iconic/iconic.xr.xrmsiam@weareretx/iconic.xr.suite@g' {} +
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/retex-iconic/weareretex/g' {} +

rename:

	for dir in pkgs/*/src/*/java/com/retexspa/xr/ms; do \
		if [ -d "$$dir" ]; then \
			mkdir -p "$${dir%/retexspa/xr/ms}/retex"; \
			mv "$$dir" "$${dir%/retexspa/xr/ms}/retex/xr"; \
			echo rm -r "$$dir"; \
		fi \
	done

	rm -rf pkgs/*/src/*/java/com/retexspa
	LC_CTYPE=C find pkgs -type f -exec sed -i '' 's/com.retex.xr.ms/com.retex.xr/g' {} +	

#LC_CTYPE=C find pkgs -type d -name "retexspa" -execdir sh -c 'if [ -d "{}" ]; then mv "{}" retex; fi' 2>/dev/null \;
	
all: clean xr-shared xr-conf xr-bom xr-iam xr-ledger xr-masterdata  sed rename


package:

	cd pkgs/xr-bom && mvn clean package install -DskipTests
	cd pkgs/xr-conf && mvn clean package install -DskipTests 
	cd pkgs/xr-shared-main && mvn clean package install -DskipTests 	
	cd pkgs/xr-shared && mvn clean package install -DskipTests 
	cd pkgs/xr-masterdata-main && mvn clean package install -DskipTests 	
	cd pkgs/xr-masterdata-backend && mvn clean package install -DskipTests 
	cd pkgs/xr-masterdata-graphql && mvn clean package install -DskipTests 	
	cd pkgs/xr-iam-main && mvn clean package install -DskipTests 
	cd pkgs/xr-iam-backend && mvn clean package install -DskipTests 
	cd pkgs/xr-iam-graphql && mvn clean package install -DskipTests 
	cd pkgs/xr-ledger-main && mvn clean package install -DskipTests 
	cd pkgs/xr-ledger-backend && mvn clean package install -DskipTests 
	cd pkgs/xr-ledger-graphql && mvn clean package install -DskipTests 

clean-pkgs:

	cd pkgs/xr-bom && mvn clean  -DskipTests
	cd pkgs/xr-conf && mvn clean  -DskipTests 
	cd pkgs/xr-shared-main && mvn clean -DskipTests 	
	cd pkgs/xr-shared && mvn clean  -DskipTests 
	cd pkgs/xr-masterdata-main && mvn clean -DskipTests 	
	cd pkgs/xr-masterdata-backend && mvn clean  -DskipTests 
	cd pkgs/xr-masterdata-graphql && mvn clean -DskipTests 	
	cd pkgs/xr-iam-main && mvn clean  -DskipTests 
	cd pkgs/xr-iam-backend && mvn clean  -DskipTests 
	cd pkgs/xr-iam-graphql && mvn clean  -DskipTests 
	cd pkgs/xr-ledger-main && mvn clean  -DskipTests 
	cd pkgs/xr-ledger-backend && mvn clean -DskipTests 
	cd pkgs/xr-ledger-graphql && mvn clean -DskipTests 	





	
	
