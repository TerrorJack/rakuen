#!/bin/sh

apt update
apt install -y apt-transport-https apt-utils curl locales software-properties-common
locale-gen en_US.UTF-8
curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
curl -s https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository -y "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"
add-apt-repository -y "deb http://apt.llvm.org/artful/ llvm-toolchain-artful-5.0 main"
add-apt-repository -y "deb https://deb.nodesource.com/node_9.x artful main"
add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ artful-pgdg main"
add-apt-repository -y ppa:git-core/candidate
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt update
apt dist-upgrade -y
apt install -y autoconf automake cmake depqbf g++-8 gawk git gnuplot google-chrome-unstable graphviz libbz2-dev libcurl4-openssl-dev libedit-dev libffi-dev libgmp-dev libicu-dev liblmdb-dev libpq-dev libsdl2-dev libsndfile1-dev libzip-dev libzmq3-dev llvm-5.0-dev make minisat netbase nettle-dev ninja-build nodejs openssh-client pkg-config z3 zlib1g-dev
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
stack --no-terminal --resolver nightly-2017-11-08 setup
rm `stack --no-terminal path --programs`/*.tar.*
stack --no-terminal install --haddock alex c2hs cpphs happy hscolour hspec-discover
stack --no-terminal install --haddock accelerate-llvm-native Agda alarmclock apecs apply-refact arithmoi atom-conduit backprop bench bitcoin-api-extra bound brittany cabal-install cabal-toolkit cassava classy-prelude-yesod compact curl dhall dhall-bash dhall-json dhall-nix dhall-text diagrams-svg dimensional distributed-closure distributed-process-simplelocalnet distributed-process-tests distribution-nixpkgs djinn-ghc docker-build-cacher doctest effect-handlers ekg ersatz esqueleto ether eventstore extensible-effects extrapolate feed fixed-vector-hetero free-vl ghc-events ghcid git gloss gnuplot GPipe hasmin haxl hedgehog-quickcheck hindent hint hit hjsmin hjsonschema hlint hoogle hopenpgp-tools hpack hpp hprotoc hsndfile-vector hspec-checkers hworker influxdb inline-c-cpp integration intero irc-client katip-elasticsearch katydid language-java LibZip lmdb machines-binary machines-directory machines-io megaparsec messagepack-rpc milena morte netwire-input network-anonymous-i2p network-anonymous-tor network-msgpack-rpc network-transport-composed network-transport-inmemory network-transport-tests open-browser operational pandoc pcre-heavy pdf-toolbox-document persistent-mongoDB persistent-mysql-haskell persistent-postgresql persistent-refs persistent-sqlite persistent-template picosat pretty-show protobuf-simple protocol-buffers-descriptor proto-lens-arbitrary proto-lens-combinators proto-lens-optparse proto-lens-protobuf-types quickbench raaz rainbox reactive-banana repa-algorithms repa-io SafeSemaphore sbv sdl2 selda-postgresql selda-sqlite servant-client servant-swagger-ui servant-websockets shake-language-c ShellCheck stm-containers stylish-haskell swish tardis tasty-quickcheck tasty-smallcheck TCache text-icu threepenny-editors threepenny-gui-flexbox transient-universe twitter-conduit type-combinators-singletons unagi-chan unbound-generics unboxed-ref unification-fd union users-persistent users-postgresql-simple users-test vcswrapper wai-app-static webdriver websockets-rpc weigh wreq yaml Yampa zeromq4-haskell zippers
