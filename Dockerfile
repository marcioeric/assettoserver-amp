FROM cubecoders/ampbase

# Versão do AssettoServer — altere aqui para atualizar
ARG ASSETTOSERVER_VERSION=0.0.54

# Instala dependências e o .NET 8 ASP.NET Core Runtime
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y wget ca-certificates libicu-dev curl tar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel 8.0 --runtime aspnetcore --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet && \
    rm /tmp/dotnet-install.sh

# Baixa e extrai o AssettoServer em /opt/assettoserver/ (fora do volume /AMP/ montado pelo AMP)
RUN mkdir -p /opt/assettoserver && \
    wget -q "https://github.com/compujuckel/AssettoServer/releases/download/v${ASSETTOSERVER_VERSION}/assetto-server-linux-x64.tar.gz" \
         -O /tmp/assettoserver.tar.gz && \
    tar -xzf /tmp/assettoserver.tar.gz -C /opt/assettoserver/ && \
    chmod +x /opt/assettoserver/AssettoServer && \
    rm /tmp/assettoserver.tar.gz

# Obrigatório pelo AMP
ENTRYPOINT ["/ampstart.sh"]
CMD []