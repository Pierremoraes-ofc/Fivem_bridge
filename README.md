# fivem_bridge

[🇺🇸 English Version](#-english) | [🇧🇷 Versão em Português](#-português-br)

---

<br>

## 🇺🇸 English

A powerful and lightweight bridge for FiveM resources, designed to simplify compatibility across frameworks, inventories, notifications, targets, and phones.

Our goal is to create an intuitive bridge with no bloatware, allowing immediate compatibility in your scripts with just a few lines of code.

### 🚀 Supported Resources

| ✔️ Frameworks | 🎒 Inventories  | 🔔 Notifications      | 🎯 Targets    | 📱 Phones     | ⏳ Progressbars | ⛅ Weather             | ⛽ Fuel       | 🔑 Vehicle Keys   |
| ------------- | --------------- | --------------------- | ------------- | ------------- | ---------------- | ----------------------- | ------------- | ------------------ |
| NDCore        | ox_inventory    | ox_lib                | ox_target     | qs-smartphone | ox_lib           | Renewed-Weathersync     | cdn-fuel      | mm_carkeys         |
| ox_core       | qs-inventory    | qbx-core (lib)        | qbx-core (ox) | lb-phone      | qbx-core         | cd_easytime             | lc_fuel       | mri_Qcarkeys       |
| es_extended   | codem-inventory | es_extended           | qb-target     | okokPhone     | qb-core          | qb-weathersync          | LegacyFuel    | qb-vehiclekeys     |
| qbx-core      | origen_inventory| qb-core               |               | yseries       | es_extended      | default (GTA Native)    |               | qbx_vehiclekeys    |
| qb-core       | qb-inventory    | GTA Default           |               |               |                  |                         |               | wasabi_carlock     |

---

### 📦 How to Use in your Custom Script

For your custom script (e.g., `Custom_script`) to natively use the bridge functions, you must import it into your `fxmanifest.lua`.

**Important:** The loading order inside `shared_scripts` must be strictly set as follows:

**In your `fxmanifest.lua`:**
```lua
fx_version 'cerulean'
game 'gta5'
lua54 'yes' -- Recommended

-- 1. Set the dependency to ensure the bridge starts before your script
dependency 'fivem_bridge'

-- 2. Import the bridge into your script's local scope
shared_scripts {
    '@ox_lib/init.lua',
    '@fivem_bridge/bridge/config.lua',
    '@fivem_bridge/bridge/init.lua'
}

-- Your files start below:
client_script 'client.lua'
server_script 'server.lua'
```

Once done, the global `Bridge` table will be automatically available in **all** matching Lua files (Client and Server), with no need for `require` or `exports`!

---

### 📚 Full Function Catalog (API)

Below we list the available functions across the bridge modules (Client/Server).

#### 1. Framework (`Bridge.framework`)
**💻 Client-side**
* **`Bridge.framework.GetPlayer()`**: Returns a table with the local player's character data (`.fullName`, `.firstName`, `.lastName`, `.dob`, `.gender`).
* **`Bridge.framework.GetMoney(type)`**: Returns the account balance based on the requested string type (`"cash"`, `"bank"`, `"black"`).
* **`Bridge.framework.GetJobInfo()`**: Returns job data (`.jobName`, `.jobLabel`, `.grade`, `.gradeName`).
* **`Bridge.framework.IsPlayerLoaded()`**: Returns `true` if the player has been validated and logged in.
* **`Bridge.framework.getPlayerMetadata(meta)`**: Returns the value of a metadata string saved to the character.
* **`Bridge.framework.toggleOutfit(wear, outfits)`**: Changes the player's clothing/skin based on saved outfits.

**Ex (Client):**
```lua
if Bridge.framework.IsPlayerLoaded() then
    local player = Bridge.framework.GetPlayer()
    print(("Logged in: %s"):format(player.fullName))
end
```

**🖥️ Server-side**
* **`Bridge.framework.RegisterCallback(name, cb)`**: Registers a server-to-client callback.
* **`Bridge.framework.GetPlayer(source)`**: Fetches the raw player object directly from the framework.
* **`Bridge.framework.GetIdentifier(source)`**: Gets the master ID (CitizenID/RockstarID).
* **`Bridge.framework.getPlayerName(source)`**: Returns "First Last" name from the database.
* **`Bridge.framework.GetCoords(source, withHeading)`**: Returns `vec3` (or `vec4` if `withHeading == true`).
* **`Bridge.framework.getPlayerMoney(source, type)`**: Gets player balance.
* **`Bridge.framework.addPlayerMoney(source, type, amount)`**: Adds money and emits native logging.
* **`Bridge.framework.removePlayerMoney(source, type, amount)`**: Removes money from the character account.

**Ex (Server):**
```lua
RegisterNetEvent('myscript:payBail', function(amount)
    local src = source
    if Bridge.framework.getPlayerMoney(src, 'cash') >= amount then
        Bridge.framework.removePlayerMoney(src, 'cash', amount)
        Bridge.framework.addSocietyBalance('police', amount)
    end
end)
```

#### 2. Inventory (`Bridge.inventory`)
**💻 Client-side**
* **`Bridge.inventory.GetItemCount(itemName, metadata, strict)`**: Returns held stock.
* **`Bridge.inventory.openInventory(invType, data)`** / **`closeInventory()`**

**🖥️ Server-side**
* **`Bridge.inventory.AddItem(source, item, count, metadata, slot, cb)`**: Appends item.
* **`Bridge.inventory.RegisterStash(id, label, slots, maxWeight, owner, groups, coords)`**: Allocates inventory memory.

#### 3. Target (`Bridge.target`)
**💻 Client-side only**
* **`Bridge.target.addBoxZone({coords, size, rotation, options})`**: Adds polygon interaction.
* **`Bridge.target.addEntity(netIds, options)`**: Target specifically directed to a vehicle/ped.

#### 4. Notifications (`Bridge.notify`)
**💻 Client-side**
```lua
Bridge.notify.NotifyPlayer(source, {
    title       = "Sistema",
    description = "Seus itens foram salvos.",
    type        = "success"
})
```

**🖥️ Server-side**
Acione remotamente:
```lua
Bridge.notify.NotifyAll({
    title       = "Aviso",
    description = "O servidor reinicia em 5 minutos.",
    type        = "error"
})
```

#### 5. Phones (`Bridge.phone`)
**💻 Client-side**
* **`Bridge.phone.InPhone()`**: Returns true if phone is visible.
* **`Bridge.phone.CreateCall(name, number, photo, isVideoCall)`**

**🖥️ Server-side**
* **`Bridge.phone.SendNewMessageFromApp(source, appNumber, message, appName)`**: Directly pushes native UI text.

<br>
<hr>
<br>

## 🇧🇷 Português (BR)

Uma bridge poderosa e leve para recursos de FiveM, projetada para simplificar a compatibilidade entre frameworks, inventários, notificações, targets e telefones.

Nosso objetivo é criar uma bridge sem excessos (bloatware), fácil de entender e que permita compatibilidade imediata em seus scripts com apenas algumas linhas de código.

### 🚀 Recursos Suportados

| ✔️ Frameworks | 🎒 Inventories  | 🔔 Notifications      | 🎯 Targets    | 📱 Phones     | ⏳ Progressbars | ⛅ Weather             | ⛽ Fuel       | 🔑 Vehicle Keys   |
| ------------- | --------------- | --------------------- | ------------- | ------------- | ---------------- | ----------------------- | ------------- | ------------------ |
| NDCore        | ox_inventory    | ox_lib                | ox_target     | qs-smartphone | ox_lib           | Renewed-Weathersync     | cdn-fuel      | mm_carkeys         |
| ox_core       | qs-inventory    | qbx-core (lib)        | qbx-core (ox) | lb-phone      | qbx-core         | cd_easytime             | lc_fuel       | mri_Qcarkeys       |
| es_extended   | codem-inventory | es_extended           | qb-target     | okokPhone     | qb-core          | qb-weathersync          | LegacyFuel    | qb-vehiclekeys     |
| qbx-core      | origen_inventory| qb-core               |               | yseries       | es_extended      | default (GTA Native)    |               | qbx_vehiclekeys    |
| qb-core       | qb-inventory    | GTA Default           |               |               |                  |                         |               | wasabi_carlock     |

---

### 📦 Como Usar em seu Custom Script

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

### 📚 Catálogo Completo de Funções (API)

Abaixo catalogamos as funções disponíveis nos módulos da bridge. A usabilidade varia de acordo com o Client (`client.lua`) ou Server (`server.lua`).

#### 1. Framework (`Bridge.framework`)

**💻 Client-side**
* **`Bridge.framework.GetPlayer()`**: Retorna uma tabela com os dados do personagem do jogador local (`.fullName`, `.firstName`, `.lastName`, `.dob`, `.gender`).
* **`Bridge.framework.GetMoney(type)`**: Retorna o saldo da conta na tipagem de dinheiro solicitada (`"cash"`, `"bank"`, `"black"`).
* **`Bridge.framework.GetJobInfo()`**: Retorna os dados sobre a profissão do jogador local (`.jobName`, `.jobLabel`, `.grade`, `.gradeName`).
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

**🖥️ Server-side**
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

#### 2. Inventário (`Bridge.inventory`)

**💻 Client-side**
* **`Bridge.inventory.openInventory(invType, data)`** / **`closeInventory()`**: Abre/fecha UI do inventário especificado.
* **`Bridge.inventory.GetItemCount(itemName, metadata, strict)`**: Quantidade de `"itemName"` em mão.
* **`Bridge.inventory.GetPlayerItems()`**: Matriz com tudo que tem na mala do Jogador.

**Exemplo Prático (Client):**
```lua
local qtdAgua = Bridge.inventory.GetItemCount("water")
if qtdAgua > 0 then
    print("Você tem " .. qtdAgua .. " garrafas de água. Pode beber!")
end
```

**🖥️ Server-side**
* **`Bridge.inventory.AddItem(inv, item, count, metadata, slot, cb)`**: (Soma item na conta) O parâmetro inv é o ID/Source.
* **`Bridge.inventory.GetItem(inv, item, metadata, returnsCount)`**: Fetch bruto de item.
* **`Bridge.inventory.RegisterStash(id, label, slots, maxWeight, owner, groups, coords)`**: Inicia baú e aloca memória.

**Exemplo Prático (Server):**
```lua
RegisterNetEvent('meuscript:darRecompensa', function()
    local sucesso = Bridge.inventory.AddItem(source, "bread", 5)
end)
```

---

#### 3. Target (`Bridge.target`)

**💻 Client-side (Exclusivo)**
* **`Bridge.target.addBoxZone(parameters)`**: Adiciona Poligono no ar onde o olho mágico pega interações.
* **`Bridge.target.addEntity(netIds, options)`**: Interação direcionada para um carro ou player específico da rede.
* **`Bridge.target.removeZone(id)`**: Remove o registro interativo ativo da zona.

**Exemplo Prático (Client):**
```lua
Bridge.target.addBoxZone({
    coords = vec3(425.1, -979.5, 30.7),
    size = vec3(1.5, 1.5, 2.0),
    rotation = 0,
    options = { { label = 'Interagir com Caixa', icon = 'fas fa-box', onSelect = function() print("Acessou caixa") end } }
})
```

---

#### 4. Notificações (`Bridge.notify`)

**💻 Client-side**
* **`Bridge.notify.Notify(NotificationData)`**: Notifica localmente o player. O `NotificationData` pode conter `.title`, `.description`, `.type` (`"inform"`, `"success"`, `"error"`) e `.duration`.
```lua
Bridge.notify.NotifyPlayer(source, {
    title       = "Sistema",
    description = "Seus itens foram salvos.",
    type        = "success"
})
```

**🖥️ Server-side**
Acione remotamente:
```lua
Bridge.notify.NotifyAll({
    title       = "Aviso",
    description = "O servidor reinicia em 5 minutos.",
    type        = "error"
})
```

---

#### 5. Telefones (`Bridge.phone`)

**💻 Client-side**
* **`Bridge.phone.InPhone()`**: Retorna booleano, indicando se a pessoa tem o celular "sacado" na mão e na cara.
* **`Bridge.phone.CreateCall(name, number, photo, isVideoCall)`**: Inicializa app de call instantaneamente via bridge request.

**🖥️ Server-side**
* **`Bridge.phone.SendNewMessageFromApp(source, appNumber, message, appName)`**: Adiciona um torpedo "nativo" à UI do celular.
* **`Bridge.phone.HasEmailAccount(source)`**: Verifica se está com o app integrado logado no character!

---

## 👨‍💻 Credits / Créditos

* **Original Developer:** [Andyyy7666](https://github.com/Andyyy7666/fivem_bridge)
* This project is heavily based on their original concept of a unified bridge for FiveM.
* Este projeto é fortemente baseado no conceito original deles de uma bridge unificada para FiveM.

---

## 📄 License | Licença
This project is under the MIT License. See the **LICENSE** file for more details. / Este projeto está sob a licença MIT. Veja o arquivo **LICENSE** para mais detalhes.
