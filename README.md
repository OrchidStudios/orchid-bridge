# Orchid Bridge

A minimal, no-BS bridge for FiveM servers. It gives you a single place to configure your setup and exposes a couple of clean exports to tie things together. Lightweight. Convenient. Nothing extra.

## Structure
```
orchid-bridge/
├── data/          # Data modules
├── exports/       # Exports definitions for functions
├── ui-exports/    # Exports definitions for UI Components
├── framework/     # Core bridge layer connecting different frameworks (ESX, QBCore, etc.)
├── modules/       # Plug-and-play bridge modules (replaceable or extendable)
│   ├── context/   # Context menus (or quick setup for custom ones)
│   ├── notify/    # Notifications
│   ├── target/    # Target or other interaction systems(player/object/world interactions)
│   └── textui/    # Text UI bridge for different use cases
└── init.lua       # Entry point initializing the bridge for the resources
```

## Supported
**Frameworks**
- ESX
- OX
- QB
- QBOX

**Targets**
- ox_target
- qb-target

**Inventories**
- ox_inventory
- qb-inventory (Basic supports). For advanced features, performance and both better security and quality switch to ox_inventory

## Installation
Check out our documentation following the hyperlink below

## [Documentation](https://orchid-docs.gitbook.io/docs/)
For detailed setup, guides and examples

## Scalability
Modules can be extended per **context** (server/client) or shared.

- **Separate context files**
  ```
  modules/<moduleName>/server/<type>.lua
  modules/<moduleName>/client/<type>.lua
  ```
  - Server file loads only on the server.  
  - Client file loads only on the client.  

- **Shared module file**
  ```
  modules/<moduleName>/<type>.lua
  ```
  - Loaded automatically on the **client** if no server/client split exists.  

### Config Requirements
- The **folder name** must match the module key in `data.config`.  
- The **config value** must match the file name (`<type>.lua`).  
  - Example:  
    ```lua
    -- data/config.lua
    return {
        target = 'ox', -- loads modules/target/client/ox.lua and/or modules/target/server/ox.lua
        textUI = 'custom', -- loads modules/textUI/client/custom.lua
    }
    ```  

This allows any module type (not just `ox.lua`) and ensures clean scaling without modifying the core bridge.
