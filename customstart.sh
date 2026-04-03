#!/bin/bash
# Hook do ampbase: executado automaticamente antes do AMP iniciar
# Cria os configs padrão se não existirem no volume

CFG_DIR="/AMP/GenericApplication/cfg"
mkdir -p "$CFG_DIR"

[ ! -f "$CFG_DIR/server_cfg.ini" ] && cp /opt/assettoserver/cfg/server_cfg.ini "$CFG_DIR/server_cfg.ini"
[ ! -f "$CFG_DIR/entry_list.ini" ] && cp /opt/assettoserver/cfg/entry_list.ini "$CFG_DIR/entry_list.ini"
[ ! -f "$CFG_DIR/extra_cfg.yml"  ] && cp /opt/assettoserver/cfg/extra_cfg.yml  "$CFG_DIR/extra_cfg.yml"
