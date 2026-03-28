# Contribuindo com o fivem_bridge

Obrigado por querer contribuir! Abaixo estão as diretrizes para manter o projeto organizado.

---

## Como contribuir

### 1. Reportar um bug
- Abra uma [Issue](https://github.com/Pierremoraes-ofc/Fivem_bridge/issues) descrevendo o problema.
- Informe: qual framework/inventário você usa, o erro exato do console e o que você esperava que acontecesse.

### 2. Sugerir um recurso ou novo suporte
- Abra uma Issue com o título: `[Sugestão] Nome do recurso`.
- Explique por que seria útil para a comunidade.

### 3. Enviar um Pull Request (PR)

1. Faça um **fork** do repositório.
2. Crie uma branch com um nome descritivo:
   ```
   git checkout -b feat/suporte-ox-fuel
   git checkout -b fix/esx-getmoney-nil
   ```
3. Siga as convenções de código abaixo.
4. Abra o PR descrevendo **o que mudou** e **por que**.

---

## Convenções de código

- **Lua 5.4** — use `local` sempre que possível.
- Nomes de funções em `camelCase`, nomes de variáveis locais em `camelCase`.
- Arquivos de client começam com `cl_` (ex: `cl_events.lua`).
- Arquivos de server começam com `sv_` (ex: `sv_notify.lua`).
- Sempre adicione anotações LuaLS (`---@param`, `---@return`) nas funções públicas da bridge.
- Sem prints de debug em produção — use `if Config.debug then ... end`.

## Estrutura de pastas

```
bridge/
├── config.lua          ← configuração global
├── init.lua            ← detecção de frameworks e carregamento de módulos
├── framework/
│   ├── cl_framework.lua
│   └── sv_framework.lua
├── inventory/
│   ├── cl_inventory.lua
│   └── sv_inventory.lua
├── notify/
│   ├── cl_notify.lua
│   └── sv_notify.lua
└── ...
```

## O que NÃO aceito em PRs

- Código que quebre compatibilidade com frameworks já suportados sem motivo claro.
- PRs sem descrição do que foi alterado.
- Adicionar dependências externas além das já declaradas no `fxmanifest.lua`.

---

## Créditos

Todo contribuidor terá seu nome/perfil adicionado na seção de créditos do README.