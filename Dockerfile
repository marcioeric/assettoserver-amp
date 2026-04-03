FROM cubecoders/ampbase

# Instala dependências necessárias para o AssettoServer (.NET runtime + libs)
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y \
        wget \
        ca-certificates \
        libicu-dev \
        libssl-dev \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Instala o .NET 8 Runtime (necessário para AssettoServer v0.0.54+)
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel 8.0 --runtime aspnetcore --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet && \
    rm /tmp/dotnet-install.sh

# Obrigatório pelo AMP: mantém o entrypoint do ampbase
ENTRYPOINT ["/ampstart.sh"]
CMD []
