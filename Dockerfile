FROM cubecoders/ampbase

# Instala socat (obrigatório pelo AMP para console) + dependências do .NET
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y wget ca-certificates libicu-dev curl tar socat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala o .NET 8 ASP.NET Core Runtime (necessário para o AssettoServer)
RUN wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod +x /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --channel 8.0 --runtime aspnetcore --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet && \
    rm /tmp/dotnet-install.sh

# Obrigatório pelo AMP
ENTRYPOINT ["/ampstart.sh"]
CMD []
