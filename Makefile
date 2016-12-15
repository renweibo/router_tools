all: apidoc doc test
	@echo hello

pip:
	@python setup.py sdist upload
	@source `which virtualenvwrapper.sh`; workon env; python setup.py bdist_wheel upload
	@source `which virtualenvwrapper.sh`; workon env3; python setup.py bdist_wheel upload

doc:
	@pandoc -o README.rst -i README.md
	@make -C docs html

apidoc:
	@rm docs_api/*.rst
	@sphinx-apidoc -F -o docs_api router_tools
	@make -C docs_api html; open docs_api/build/html/index.html

test:
	@source `which virtualenvwrapper.sh`; workon env; python setup.py develop;py.test

feature_end: doc apidoc
	#@pip freeze > requirements_dev.txt
	@git commit -a -m "messages for update"
	@bumpversion patch
	@git status
	@git flow feature finish `git flow feature | cut -f 2 -d " "`
	@git push
	@git push --tags
	@git checkout master
	@git push
	@git checkout develop

hotfix_end: doc apidoc
	@git commit -a -m "messages for hotfix"
	@bumpversion patch
	@git status
	@git flow feature finish `git flow hotfix | cut -f 2 -d " "`
	@git push
	@git push --tags
	@git checkout master
	@git push
	@git checkout develop

release_start:
	@git flow release start `grep current_version .bumpversion.cfg | cut -d " " -f 3`

release_finish:
	@git flow release finish `grep current_version .bumpversion.cfg | cut -d " " -f 3`
