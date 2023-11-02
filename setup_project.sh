#!/bin/bash  
  
# Get the name of the current directory  
dir_name=${PWD##*/}  
  
# Create a new Conda environment with the most recent and stable version of Python  
conda create --name "$dir_name" python=3.10  --yes

# initialize on bash
conda init bash

# Activate the new environment  
conda activate "$dir_name"  
  
# Install pre-commit module  
pip install pre-commit  
  
# Create necessary files for linters with recommended settings  
cat <<EOT > .pre-commit-config.yaml  
repos:  
- repo: https://github.com/pre-commit/pre-commit-hooks  
	rev: v3.4.0  
	hooks:  
	  - id: trailing-whitespace  
	  - id: end-of-file-fixer  
	  - id: check-yaml  
	  - id: check-added-large-files
  - repo: https://github.com/psf/black
	rev: 22.12.0
	hooks:
	  - id: black
  - repo: https://github.com/PyCQA/flake8
	rev: 6.0.0
	hooks:
	  - id: flake8
  - repo: https://github.com/PyCQA/pydocstyle
	rev: 6.1.1
	hooks:
	  - id: pydocstyle
  - repo: https://github.com/pre-commit/mirrors-mypy
	rev: v0.991
	hooks:
	  - id: mypy
		additional_dependencies: ['types-requests']
  - repo: https://github.com/asottile/reorder-python-imports
    rev: v3.12.0
    hooks:
    -   id: reorder-python-imports
        args: [--py310-plus, --add-import, 'from __future__ import annotations']
EOT

cat <<EOT > .flake8  
[flake8]  
  ignore = E203, E266, E501, W503, F403, F401
	max-line-length = 89
	max-complexity = 18
	select = B,C,E,F,W,T4,B9 
EOT

cat <<EOT > .pylintrc  
[FORMAT]  
max-line-length=89  
EOT
