#!/bin/bash

vagrant destroy -f
vagrant box remove packer-test

set -e

packer build -force packer.json
vagrant up
