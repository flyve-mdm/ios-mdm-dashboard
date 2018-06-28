#!/bin/sh

echo ----------- Configure bundler ------------
echo :update_sources: true >> ~/.gemrc
echo :benchmark: false >> ~/.gemrc
echo :backtrace: true >> ~/.gemrc
echo :verbose: true >> ~/.gemrc
echo gem: --no-ri --no-rdoc >> ~/.gemrc
echo install: --no-rdoc --no-ri >> ~/.gemrc
echo update: --no-rdoc --no-ri >> ~/.gemrc