#!/bin/sh

apt update
apt install -y apt-transport-https curl software-properties-common
curl -s https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository -y "deb http://apt.llvm.org/artful/ llvm-toolchain-artful-5.0 main"
add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ artful-pgdg main"
add-apt-repository -y ppa:git-core/candidate
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt update
apt dist-upgrade -y
apt install -y autoconf automake depqbf g++-8 git libedit-dev libffi-dev libgit2-dev libgmp-dev libicu-dev liblmdb-dev libpq-dev libsdl2-dev libzmq3-dev llvm-5.0-dev make minisat netbase openssh-client pkg-config z3 zlib1g-dev
apt autoremove -y
apt clean -y

cd /usr/lib/gcc/x86_64-linux-gnu/8
cp crtbeginS.o crtbeginT.o
cd /root

update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-8 80
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 80
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80
update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-8 80
update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-8 80
update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-8 80
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-8 80
update-alternatives --install /usr/bin/gcov-dump gcov-dump /usr/bin/gcov-dump-8 80
update-alternatives --install /usr/bin/gcov-tool gcov-tool /usr/bin/gcov-tool-8 80
update-alternatives --install /usr/bin/ld ld /usr/bin/ld.gold 80

mkdir -p /root/.local/bin
export PATH=/root/.local/bin:$PATH
curl -L https://github.com/commercialhaskell/stack/releases/download/v1.6.0.20171022/stack-1.6.0.20171022-linux-x86_64-static.tar.gz | tar xz --wildcards --strip-components=1 -C /root/.local/bin '*/stack'
stack --no-terminal --resolver nightly-2017-11-03 setup
rm `stack --no-terminal path --programs`/*.tar.*
stack --no-terminal install --haddock alex c2hs cpphs happy hscolour hspec-discover
stack --no-terminal install --haddock accelerate-llvm-native ad alarmclock apply-refact arithmoi atom-conduit bound brittany cabal-install cabal-toolkit cassava compact criterion curl dhall diagrams-svg distributed-closure distributed-process-simplelocalnet distributed-process-tests doctest ekg ersatz feed ghc-events ghcid gloss GPipe haxl hedgehog-quickcheck hlibgit2 hlint hoogle hpack hworker integration intero irc-client katip-elasticsearch lmdb machines megaparsec morte netwire-input open-browser pandoc pcre-heavy picosat pretty-show raaz rainbox reactive-banana repa-algorithms repa-io SafeSemaphore sbv sdl2 selda-postgresql selda-sqlite servant-client servant-swagger-ui servant-websockets singletons stm-containers stylish-haskell tasty-quickcheck tasty-smallcheck TCache text-icu threepenny-gui transient-universe twitter-conduit unagi-chan unbound-generics unification-fd vcswrapper webdriver weigh wreq Yampa zeromq4-haskell zippers