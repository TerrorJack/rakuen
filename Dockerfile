FROM ubuntu:artful

RUN apt update
RUN apt install -y apt-transport-https curl software-properties-common
RUN curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ artful-pgdg main"
RUN add-apt-repository -y ppa:git-core/candidate
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt update
RUN apt dist-upgrade -y
RUN apt install -y autoconf automake ca-certificates gcc-8 git gzip libedit-dev libffi-dev libgmp-dev liblmdb-dev libpq-dev libzmq3-dev make netbase openssh-client pkg-config tar zlib1g-dev
RUN apt autoremove -y
RUN apt clean -y

WORKDIR /usr/lib/gcc/x86_64-linux-gnu/8
RUN cp crtbeginS.o crtbeginT.o
WORKDIR /root

RUN update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-8 80
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80
RUN update-alternatives --install /usr/bin/gcc-ar gcc-ar /usr/bin/gcc-ar-8 80
RUN update-alternatives --install /usr/bin/gcc-nm gcc-nm /usr/bin/gcc-nm-8 80
RUN update-alternatives --install /usr/bin/gcc-ranlib gcc-ranlib /usr/bin/gcc-ranlib-8 80
RUN update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-8 80
RUN update-alternatives --install /usr/bin/gcov-dump gcov-dump /usr/bin/gcov-dump-8 80
RUN update-alternatives --install /usr/bin/gcov-tool gcov-tool /usr/bin/gcov-tool-8 80
RUN update-alternatives --install /usr/bin/ld ld /usr/bin/ld.gold 80

ADD config.yaml /root/.stack/config.yaml
RUN mkdir -p /root/.local/bin
RUN curl -L https://github.com/commercialhaskell/stack/releases/download/v1.6.0.20171022/stack-1.6.0.20171022-linux-x86_64-static.tar.gz | tar xz --wildcards --strip-components=1 -C /root/.local/bin '*/stack'
RUN /root/.local/bin/stack --no-terminal --resolver nightly-2017-11-03 setup
ENV PATH /root/.local/bin:`/root/.local/bin/stack --no-terminal path --compiler-bin`:$PATH
RUN rm `stack --no-terminal path --programs`/*.tar.*
RUN stack --no-terminal install --haddock alex c2hs cpphs happy hscolour hspec-discover
RUN stack --no-terminal install --haddock apply-refact atom-conduit cabal-install compact ekg feed ghcid hedgehog-quickcheck hlint hoogle hpack hworker intero irc-client katip-elasticsearch lmdb SafeSemaphore selda-postgresql selda-sqlite servant-client servant-swagger-ui servant-websockets stm-containers stylish-haskell tasty-quickcheck tasty-smallcheck TCache unagi-chan zeromq4-haskell
