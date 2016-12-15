all: apidoc doc test
	@echo hello

pip:
	@python setup.py sdist upload
	@workon env; python setup.py bdist_wheel upload
	@workon env3; python setup.py bdist_wheel upload

doc:
	@pandoc -o README.rst -i README.md
	@make -C docs html

apidoc:
	@rm docs_api/*.rst
	@sphinx-apidoc -F -o docs_api router_tools
	@make -C docs_api html; open docs_api/build/html/index.html

test:
	@. .env/bin/activate
	@python setup.py develop
	@py.test

feature_end:
	@pip freeze > requirements_dev.txt
	@git commit -a -m "messages for update"
	@bumpversion patch
	@git status
	@git flow feature finish `git flow feature | cut -f 2 -d " "`
	@git push
	@git push --tags

release_start:
	@git flow release start v`grep current_version .bumpversion.cfg | cut -d " " -f 3`

release_finish:
	@git flow release finish v`grep current_version .bumpversion.cfg | cut -d " " -f 3`
