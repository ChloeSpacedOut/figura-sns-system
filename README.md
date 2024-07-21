
# SNS (Storage & Sync) System

SNS is a system that will automatically store your variables, ping them, and automatically sync them to prevent desync issues. This is achived by using the SNS System's functions and database, all of which are highly customisable. SNS also comes with a built in function to easily update model parts with your variables in the databases.

I want this system to work for as many use cases as possible, so if I overlooked something and you can't use it for your use case, please let me know!

## Initial Setup
You'll need to make sure you've chosen a name for your config file to make things easier. In your main script at the top, add the line `config:name('CONFIG_NAME')`, where `CONFIG_NAME` is a name you've chosen for your config file.

IMPORTANT: if later down the line you're erroring every time data auto-syncs, or your avatar system isn't behaving as expected, you may have corrupt or broken data stored in your config. Delete your config at `.minecraft/figura/congif/CONFIG_NAME`

## Creating your variables
First, you'll need to create your variables in the database. Add a new table to `snsData`, inside of `dataTables.lua`. It needs to include its ID as a child, and the value should match the table key. You can add your variables bellow the ID with what ever keys and values you like. For example:
```lua
snsData = {
    exampleData = {
        ID = "exampleData",
        exampleVar = true,
        exampleVar2 = vec(0,0,0),
        exampleVar3 = "example"
    }
}
```
Once you've created your variables, you'll need to write the metadata for this table. This is just data about the variables that the SNS system or you can use that doesn't get synced or pinged. In the `snsMetadata` table (also in `dataTables.lua`), create a new table with the exact same name. Also create a child which has the ID. You will also need to create the `snsFunctions` child, which will tell the SNS System what functions to run when it syncs data. The `snsFunctions` child is a table, where the key is your variable keys from the main data table, and the value is the name of the function from `dataSync.lua` that you'll run on syncing, as a string. For example:
```lua
snsMetaData = {
    exampleData = {
        ID = "exampleData",
        snsFunctions = {
            exampleVar = "exampleFunctionName",
            exampleVar2 = "exampleFunctionName2",
            exampleVar3 = "exampleFunctionName3"
        }
    }
}
```
With these two tables, your data is set up!
## Data Sync functions
### Default Functions
The SNS System comes with `dataSync.updatePart()` as a default function. To function correctly, it required variables be named like the model part api functions, though without `set` at the beginning. For example, to save a variable that will update a parts position, you'd simply name it `pos`.
It also requires the model part path/s be included in the metadata. Model paths are stored as strings, formatted as bellow:
 ```lua
 paths = {'example.model.path.11','example.model.path.2'}
 ```
You can find examples of usage of this function in the SNS System Example file.
### Custom Functions
You can easily create your own dataSync functions, and will need to in many cases. To create a new function, go to `dataSync.lua`, and create a new function with this formatting:
```lua
function dataSync.NAME_HERE(newEntryData,entryDataKey)
-- code here
end
```
The name used is in the `NAME_HERE` section is what will used in the `snsFunction` to call it. `newEntryData` is the data retrived from the ping, containing your variables. `entryDataKey` is the key of the variable that called this function.
## Updating and Syncing your variables
To initiate storing and syncing of your variables, you will need to call the `dataStore.generic()` function. This function will require the data ID as its first input, which is the ID used in the data table. For the second input it will need a table containig data for evey variable key, and the values inside which will be updated. For example:
```lua
    dataStore.generic("exampleData", {ID = {"exampleVar","exampleVar2"}, val = {false,vec(1,1,1)}})
```
Only variables called will be updated, the rest will stay the same. The ID table's first ID should match the val table's first value, and so on. You can update as few or many variables as you like.
## Technical Notes
### Sync Speed
You can update the speed at which the SNS system automatically syncs in `dataStore&Retrive.lua`, by updating the `syncInterval` variable. This is how many ticks are in between each sync. Keep in mind, the SNS system sincs variable groups one at a time, so you may want smaller intervals if you have many variable groups.
### Action Wheel Toggle Syncing
If you want action wheel toggles to sync correctly on reload, you can set the toggle with `toggle:setToggled(config:load("exampleData").exampleVar` where `exampleVar` has your boolean. Ensure this code will only run on the host with `if not host:isHost() then return end` (you shouild be doing this for the action wheel anyway) and include a check for if your config file hasn't been created yet, like the following:
```lua
if not config:load("exampleData") then
    -- your dataStore.generic() function here for this var group
end
```
Set your dataStore function to just set the variables for the default state you'd expect the first time you load your avatar. Since these functions will be running on avatar initialisation, make sure you include `require("SNS_system.dataStore&Retrive")` at the top of your script, otherwise it will not be able to run the function. You can find examples of action wheel toggle syncing in the SNS System Example file.
### Custom dataStore Functions
If you need, you can also create your own datastore functions in `dataStore&Retrive`. The default function should work in most cases though. Just make sure any custom functions still save and ping the required data.

