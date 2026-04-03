#!/bin/bash
# Script de inicialização do AssettoServer para AMP
# Cria os arquivos de config padrão se não existirem

CFG_DIR="/AMP/GenericApplication/cfg"
mkdir -p "$CFG_DIR"

if [ ! -f "$CFG_DIR/server_cfg.ini" ]; then
    echo "Criando server_cfg.ini padrão..."
    cp /opt/assettoserver/cfg/server_cfg.ini "$CFG_DIR/server_cfg.ini"
fi

if [ ! -f "$CFG_DIR/entry_list.ini" ]; then
    echo "Criando entry_list.ini padrão..."
    cp /opt/assettoserver/cfg/entry_list.ini "$CFG_DIR/entry_list.ini"
fi

if [ ! -f "$CFG_DIR/extra_cfg.yml" ]; then
    echo "Criando extra_cfg.yml padrão..."
    cp /opt/assettoserver/cfg/extra_cfg.yml "$CFG_DIR/extra_cfg.yml"
fi

# Inicia o AssettoServer
exec /opt/assettoserver/AssettoServer "$@"
