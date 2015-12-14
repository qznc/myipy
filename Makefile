default:
	@echo "make something yourself!"

SETUP_FLAG=.env/setup_done

$(SETUP_FLAG):
	mkdir .env || true
	virtualenv --python=python3 --no-site-packages --distribute .env
	bash -c "source .env/bin/activate && pip install numpy"
	bash -c "source .env/bin/activate && pip install -r requirements.txt"
	touch $(SETUP_FLAG)

.PHONY: run update shell

shell: $(SETUP_FLAG)
	bash -c "source .env/bin/activate && bash"

update: $(SETUP_FLAG)
	bash -c "source .env/bin/activate && pip install -r requirements.txt --upgrade"

run: $(SETUP_FLAG)
	bash -c "source .env/bin/activate && ipython notebook --script --matplotlib=inline"
