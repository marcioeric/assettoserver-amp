# AssettoServer — Template AMP (Generic Module)

Template para rodar o [AssettoServer](https://github.com/compujuckel/AssettoServer) (fork comunitário do AC server) dentro do **CubeCoders AMP** via Docker customizado.

---

## Arquivos gerados

| Arquivo | Função |
|---|---|
| `Dockerfile` | Imagem Docker baseada no `cubecoders/ampbase` com .NET 8 |
| `GenericModule.kvp` | Configuração principal do AMP (download, start, stop, console) |
| `configmanifest.json` | UI de configuração no painel do AMP |

---
## Passo a passo

### 1. Build e push da imagem Docker

```bash
# Substitua pelo seu usuário no Docker Hub
docker build -t seuuser/assettoserver-amp:latest .
docker push seuuser/assettoserver-amp:latest
```


> Se não quiser usar Docker Hub, pode usar qualquer registry acessível pela sua máquina AMP (ex: registry local, GHCR, etc).

### 2. Atualizar o GenericModule.kvp

Edite a linha:
```
Meta.SpecificDockerImage=seuuser/assettoserver-amp:latest
```
Coloque o nome real da sua imagem publicada.

### 3. Colocar os arquivos no AMP

Os 3 arquivos devem ficar na pasta de templates do AMP, dentro da estrutura:

```
~/.ampdata/datastore/Templates/AssettoServer/
├── GenericModule.kvp
├── configmanifest.json
```

Ou, melhor ainda, crie um repositório no GitHub e adicione-o ao AMP em:
`Configuration → Instance Deployment → Add Configuration Repository`
usando o formato `usuario/repo:branch`.

### 4. Criar a instância

No AMP, ao criar uma nova instância com o **Generic Module**, o AssettoServer deve aparecer na lista. Crie a instância e clique em **Update** para baixar os binários via GitHub Release.

### 5. Adicionar o conteúdo do jogo

O AssettoServer **não inclui** as pistas e carros — você precisa copiá-los manualmente da sua instalação do Assetto Corsa via SFTP para a instância. A estrutura esperada dentro do `RootDir` (`AssettoServer/`) é:

```
AssettoServer/
├── AssettoServer          ← binário principal
├── cfg/
│   ├── server_cfg.ini
│   ├── entry_list.ini
│   └── extra_cfg.yml      ← gerado automaticamente no primeiro start
├── content/
│   ├── cars/
│   └── tracks/
```

### 6. Portas a liberar no firewall

| Porta | Protocolo | Uso |
|---|---|---|
| 9600 | TCP + UDP | Conexão dos jogadores |
| 8081 | TCP | HTTP Admin API |

---

## Observações importantes

- **Pistas e carros** precisam ser copiados via SFTP. O AMP não baixa conteúdo do Assetto Corsa automaticamente (seria necessário o Steam com login).
- O `extra_cfg.yml` é criado automaticamente no **primeiro start** do servidor — não é necessário criá-lo manualmente.
- Para **tráfego AI**, coloque o `fast_lane.ai` em `content/tracks/<nome_pista>/ai/` e ative `EnableAi: true` no `extra_cfg.yml`.
- O `AppConfigId` no `GenericModule.kvp` é um UUID aleatório — se for subir mais de uma instância do mesmo tipo, mantenha o mesmo UUID.

---

## Atualizar para uma versão mais nova

Basta mudar `UpdateSourceVersion` no `GenericModule.kvp`:
```
"UpdateSourceVersion": "v0.0.55"
```
E clicar em **Update** no painel do AMP.

Para **pre-releases**, use o tag exato, ex: `"v0.0.55-pre35"`.
