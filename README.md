# router_tools

[![Latest PyPI version](https://img.shields.io/pypi/v/router_tools.svg)](https://pypi.python.org/pypi/router_tools) [![Latest Travis CI build status](https://travis-ci.org/renweibo/router_tools.png)](https://travis-ci.org/renweibo/router_tools)

A simple tools for router maintain.

# Usage

# Installation

## Requirements

# Development Guide

## Development env setup - bootstrap

```
virtualenv .env
. .env/bin/activate
pip install -U pip
cat <<EOF > .env/pip.conf
[list]
format=columns
EOF
pip install -U virtualenvwrapper
pip install -U pytest-cov
pip install -U tox
pip install -U Sphinx
sphinx-quickstart
pip freeze > requirements.txt
```

## Development env setup - new machine

```
. .env/bin/activate
pip install -r requirements.txt --use-mirrors
```

## Relase

```
pandoc -o README.rst -i README.md
pip freeze > requirements.txt

. .env/bin/activate
python setup.py develop
py.test
git commit -a -m "messages for update"

bumpversion patch
python setup.py register
python setup.py sdist upload

make -C docs html
```

# Licence
