# fivem_bridge

Uma bridge poderosa e leve para recursos de FiveM, projetada para simplificar a compatibilidade entre frameworks, inventários, notificações, targets e telefones.

Nosso objetivo é criar uma bridge sem excessos (bloatware), fácil de entender e que permita compatibilidade imediata em seus scripts com apenas algumas linhas de código.

## 🚀 Recursos Suportados

| ✔️ Frameworks | 🎒 Inventories  | 🔔 Notifications      | 🎯 Targets    | 📱 Phones     | ⏳ Progressbars | ⛅ Weather             | ⛽ Fuel       | 🔑 Vehicle Keys   |
| ------------- | --------------- | --------------------- | ------------- | ------------- | ---------------- | ----------------------- | ------------- | ------------------ |
| NDCore        | ox_inventory    | ox_lib                | ox_target     | qs-smartphone | ox_lib           | Renewed-Weathersync     | cdn-fuel      | mm_carkeys         |
| ox_core       | qs-inventory    | qbx-core (lib)        | qbx-core (ox) | lb-phone      | qbx-core         | cd_easytime             | lc_fuel       | mri_Qcarkeys       |
| es_extended   | codem-inventory | es_extended           | qb-target     | okokPhone     | qb-core          | qb-weathersync          | LegacyFuel    | qb-vehiclekeys     |
| qbx-core      | origen_inventory| qb-core               |               | yseries       | es_extended      | default (GTA Native)    |               | qbx_vehiclekeys    |
| qb-core       | qb-inventory    | GTA Default           |               |               |                  |                         |               | wasabi_carlock     |

---

## 📦 Como Usar em seu Custom Script

Para que o seu script (ex: `Custom_script`) consiga utilizar as funções da bridge nativamente, você deve importá-la no seu `fxmanifest.lua`. 

**Importante:** A ordem de carregamento nos `shared_scripts` deve ser rigorosamente esta:

**No seu `fxmanifest.lua`:**
```lua
fx_version 'cerulean'
game 'gta5'
lua54 'yes' -- Recomendado

-- 1. Defina a dependência para garantir que a bridge ligue antes do script
dependency 'fivem_bridge'

-- 2. Importe a bridge para o escopo do seu script local
shared_scripts {
    '@ox_lib/init.lua',
    '@fivem_bridge/bridge/config.lua',
    '@fivem_bridge/bridge/init.lua'
}

-- Seus arquivos começam depois:
client_script 'client.lua'
server_script 'server.lua'
```

Feito isso, a tabela global `Bridge` estará automaticamente disponível em **todos** os arquivos Lua do seu script (Client e Server), sem precisar dar `require` ou `exports`!

---

## 📚 Catálogo Completo de Funções (API)

Abaixo catalogamos as funções disponíveis nos módulos da bridge. A usabilidade varia de acordo com o Client (`client.lua`) ou Server (`server.lua`).

### 1. Framework (`Bridge.framework`)

#### 💻 Client-side
* **`Bridge.framework.GetPlayer()`**: Retorna uma tabela com os dados do personagem do jogador local.
  * `.fullName` (string) = Nome completo (Ex: John Doe)
  * `.firstName` (string) = Primeiro nome
  * `.lastName` (string) = Sobrenome
  * `.dob` (string) = Aniversário
  * `.gender` (number/string) = Gênero do personagem
* **`Bridge.framework.GetMoney(type)`**: Retorna o saldo da conta na tipagem de dinheiro solicitada.
  * *Tipos aceitos:* `"cash"` (carteira), `"bank"` (banco), `"black"` ou `"black_money"` (dinheiro sujo).
* **`Bridge.framework.GetJobInfo()`**: Retorna os dados sobre a profissão do jogador local.
  * `.jobName` (string) = ID interno da profissão (ex: police)
  * `.jobLabel` (string) = Nome legível (ex: Los Santos Police Department)
  * `.grade` (number) = ID numérico do cargo
  * `.gradeName` (string) = Nome legível do cargo (ex: Officer)
* **`Bridge.framework.IsPlayerLoaded()`**: Retorna `true` se o jogador já estiver sido validado e logado no framework.
* **`Bridge.framework.getPlayerMetadata(meta)`**: Retorna o valor de um "metadata" salvo no char do player.
* **`Bridge.framework.toggleOutfit(wear, outfits)`**: Altera as roupas/skin do jogador para a contida em outfits (aplicado pelo framework de salvamento).

**Exemplo Prático (Client):**
```lua
if Bridge.framework.IsPlayerLoaded() then
    local player = Bridge.framework.GetPlayer()
    local job = Bridge.framework.GetJobInfo()
    local dinheiro = Bridge.framework.GetMoney("cash")
    
    print(("Jogador %s (%s) logado. Profissão: %s. Saldo: $%s"):format(
        player.fullName, player.dob, job.jobLabel, dinheiro
    ))
end
```

#### 🖥️ Server-side
* **`Bridge.framework.RegisterCallback(name, cb)`**: Registra um callback servidor-cliente.
* **`Bridge.framework.GetPlayer(source)`**: (Alias: `getPlayerFromId`) Pega o objeto cru do player diretamente do framework.
* **`Bridge.framework.GetIdentifier(source)`**: Pega o ID mestre (CitizenID/RockstarID) de um player conectado.
* **`Bridge.framework.getPlayerName(source)`**: Retorna "Nome Sobrenome" do database.
* **`Bridge.framework.GetCoords(source, withHeading)`**: Retorna as coordenadas `vec3` do ped (ou `vec4` caso `withHeading` seja `true`).
* **`Bridge.framework.getPlayerDOB(source)`**: Data de nascimento lida na string.
* **`Bridge.framework.getPlayerSex(source)`**: Retorna `"m"` (Masculino) ou `"f"` (Feminino).
* **`Bridge.framework.getPlayerMoney(source, moneyWallet)`**: O mesmo de pegar dinheiro no client, sendo focado para um único ID (ex: "cash").
* **`Bridge.framework.addPlayerMoney(source, moneyWallet, amount)`**: Adiciona dinheiro e emite logging nativo do respectivo framework.
* **`Bridge.framework.removePlayerMoney(source, moneyWallet, amount)`**: Remove dinheiro da conta do jogador.
* **`Bridge.framework.getPlayerJob(source, dataType)`**: Busca dados precisos do emprego de alguém (`dataType` aceitos: `"label"`, `"name"`, `"grade"`, `"gradeLabel"`).
* **`Bridge.framework.setPlayerMetadata(source, meta, value)`**: Salva um "metadata" no jogador.
* **`Bridge.framework.getPlayerMetadata(source, meta)`**: Lê aquele Metadata.
* **`Bridge.framework.addSocietyBalance(job, amount)`**: Injeta fundos no sistema de banco de facções.
* **`Bridge.framework.removeSocietyBalance(job, amount)`**: Remove fundos de uma facção/empresa.
* **`Bridge.framework.RegisterUsableItem(item, cb)`**: Permite vincular uma função quando você usa ("Use") um item no slot do framework (quando QBCore/ESX tratam usable items).

**Exemplo Prático (Server):**
```lua
RegisterNetEvent('meuscript:pagarFianca', function(valor)
    local src = source
    local grana = Bridge.framework.getPlayerMoney(src, 'cash')
    
    if grana >= valor then
        Bridge.framework.removePlayerMoney(src, 'cash', valor)
        Bridge.framework.addSocietyBalance('police', valor)
        print(("O jogador %s pagou a fiança."):format(Bridge.framework.getPlayerName(src)))
    end
end)
```

**[Veículos Salvos ("Garagem")]** *(Somente Server)*
* **`Bridge.framework.GetOwnedVehicleOwner(plate)`**
* **`Bridge.framework.GetOwnedVehicleData(plate)`**
* **`Bridge.framework.DeleteOwnedVehicle(plate)`**
* **`Bridge.framework.InsertOwnedVehicle(plate, owner, vehicle)`**

---

### 2. Inventário (`Bridge.inventory`)

Utilitário voltado a interações de baús e manipulação de propriedades dos itens. (Depende se o inventário como ox_inventory possuir o export).

#### 💻 Client-side
* **`Bridge.inventory.openInventory(invType, data)`**: Abre inventário específico.
* **`Bridge.inventory.openNearbyInventory()`**: Atalho para dropar e vasculhar o chão.
* **`Bridge.inventory.closeInventory()`**: Fecha UI à força.
* **`Bridge.inventory.GetItemCount(itemName, metadata, strict)`**: Quantidade de `"itemName"` em mão.
* **`Bridge.inventory.Items(itemName)`**: Retorna tabela de configurações fixas do item (nome exibido, limite, peso) no banco do server.
* **`Bridge.inventory.Search(search, item, metadata)`**: Busca customizada com metadata.
* **`Bridge.inventory.GetPlayerItems()`**: Matriz com tudo que tem na mala do Jogador.

**Exemplo Prático (Client):**
```lua
local qtdAgua = Bridge.inventory.GetItemCount("water")
if qtdAgua > 0 then
    print("Você tem " .. qtdAgua .. " garrafas de água. Pode beber!")
else
    print("Você está com sede e sem água.")
end
```

#### 🖥️ Server-side
* **`Bridge.inventory.AddItem(inv, item, count, metadata, slot, cb)`**: (Soma item na conta) O parâmetro inv é o ID/Source.
* **`Bridge.inventory.GetItem(inv, item, metadata, returnsCount)`**: Fetch bruto de item.
* **`Bridge.inventory.GetItemCount(inv, itemName, metadata, strict)`**: Confirma estoque interno de items.
* **`Bridge.inventory.ClearInventory(inv, keep)`**: Wipe de itens do Source (exceto o indexado param keep).
* **`Bridge.inventory.RegisterStash(id, label, slots, maxWeight, owner, groups, coords)`**: Inicia baú e aloca memória.
* **`Bridge.inventory.CustomDrop(prefix, items, coords, slots, maxWeight, instance, model)`**: Spawna na rua uma mochila com itens pré-alocados.

**Exemplo Prático (Server):**
```lua
RegisterNetEvent('meuscript:darRecompensa', function()
    local src = source
    local sucesso = Bridge.inventory.AddItem(src, "bread", 5)
    
    if sucesso then
        print("Pão dado ao jogador!")
    end
end)
```

---

### 3. Target (`Bridge.target`)

Para o sistema principal de UI (Visão Radial ou Ícone de Terceira Pessoa "Olho mágico").

#### 💻 Client-side (Exclusivo)
* **`Bridge.target.addBoxZone(parameters)`**: Adiciona Poligono no ar onde o olho mágico pega interações via caixa com tamanho fixo e distância configurada.
* **`Bridge.target.addSphereZone(parameters)`**: Uma zona redonda ativável.
* **`Bridge.target.addModel(models, options)`**: Aplica o menu de interação a um prop/hash de modelo (Ex: Todos os lixos da cidade!).
* **`Bridge.target.addEntity(netIds, options)`**: Interação direcionada para um carro ou player específico da rede.
* **`Bridge.target.addGlobalPlayer(options)`**: Interações em jogador que funcionam pelo target system inteiro (Ex: Algemar outro jogador).
* **`Bridge.target.addGlobalVehicle(options)`**: Funções globais para todos os veículos (Ex: Abastecimento de combustível).
* **`Bridge.target.removeZone(id)`**: Remove o registro interativo ativo da zona.

**Exemplo Prático (Client):**
```lua
Bridge.target.addBoxZone({
    coords = vec3(425.1, -979.5, 30.7),
    size = vec3(1.5, 1.5, 2.0),
    rotation = 0,
    options = {
        {
            label = 'Interagir com Caixa',
            icon = 'fas fa-box',
            onSelect = function()
                print("Você acessou a caixa.")
            end
        }
    }
})
```

---

### 4. Notificações (`Bridge.notify`)

#### 💻 Client-side
* **`Bridge.notify.Notify(NotificationData)`**: Notifica localmente o player. O `NotificationData` pode receber:
  * `.title` = Cabeçalho;
  * `.description` = Corpo de Texto;
  * `.type` = `"inform"` | `"error"` | `"success"`;
  * `.duration` = (Tempo MS);

**Exemplo Prático (Client):**
```lua
Bridge.notify.Notify({
    title = 'Aviso de Multa',
    description = 'Você ultrapassou o limite de velocidade!',
    type = 'error',
    duration = 5000
})
```

#### 🖥️ Server-side
Não usa bridge local, acione remotamente:

**Exemplo Prático (Server):**
```lua
TriggerClientEvent('bridge:notify', source, { 
    title = 'Sistema', 
    description = 'Seus itens foram salvos.', 
    type = 'success' 
})
```

---

### 5. Telefones (`Bridge.phone`)

#### 💻 Client-side
* **`Bridge.phone.InPhone()`**: Retorna booleano, indicando se a pessoa tem o celular "sacado" na mão e na cara.
* **`Bridge.phone.ClosePhone()`**: Força a interrupção visual do telemóvel.
* **`Bridge.phone.CreateCall(name, number, photo, isVideoCall)`**: Inicializa app de call instantaneamente via bridge request.

**Exemplo Prático (Client):**
```lua
RegisterCommand('ligarpolicia', function()
    if not Bridge.phone.InPhone() then
        Bridge.phone.CreateCall("Emergência Policial", "911", nil, false)
    end
end)
```

#### 🖥️ Server-side
* **`Bridge.phone.SendNewMessageFromApp(source, appNumber, message, appName)`**: Adiciona um torpedo "nativo" à UI do celular, enviando uma notificação sem ser da interface core do jogo.
* **`Bridge.phone.HasEmailAccount(source)`**: Verifica se está com o app integrado logado no character!

**Exemplo Prático (Server):**
```lua
RegisterNetEvent('mecanico:carroPronto', function()
    local src = source
    Bridge.phone.SendNewMessageFromApp(src, "Benny's", "Seu Skyline está pronto para retirada!", "Messages")
end)
```

---

## 📄 Licença
Este projeto está sob a licença MIT. Veja o arquivo **LICENSE** para mais detalhes.
