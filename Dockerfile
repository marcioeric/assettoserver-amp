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

# Baixa e extrai o AssettoServer em /opt/assettoserver/ (fora do volume montado pelo AMP)
RUN mkdir -p /opt/assettoserver && \
    wget -q "https://github.com/compujuckel/AssettoServer/releases/download/v${ASSETTOSERVER_VERSION}/assetto-server-linux-x64.tar.gz" \
         -O /tmp/assettoserver.tar.gz && \
    tar -xzf /tmp/assettoserver.tar.gz -C /opt/assettoserver/ && \
    chmod +x /opt/assettoserver/AssettoServer && \
    rm /tmp/assettoserver.tar.gz

# Copia os configs template para /opt/assettoserver/cfg/
RUN mkdir -p /opt/assettoserver/cfg
COPY default_server_cfg.ini /opt/assettoserver/cfg/server_cfg.ini
COPY default_entry_list.ini /opt/assettoserver/cfg/entry_list.ini
COPY default_extra_cfg.yml /opt/assettoserver/cfg/extra_cfg.yml



# Obrigatório pelo AMP
ENTRYPOINT ["/ampstart.sh"]
CMD []
