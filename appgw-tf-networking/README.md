# Introduction 
TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project. 

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1.	Installation process
2.	Software dependencies
3.	Latest releases
4.	API references

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)

ToDo - Remove appgw user assigned identity creation code from the common-terraform-infra pipeline

####Resources deployed using the pipeline "appgw-terraform-networking"###
Sr.No	NAME	                                                TYPE	                LOCATION
1	crbatmo-esp-d-em28-agw01	                        Application gateway	        France Central
2	crbatmo-esp-d-em28-kv	                                Key vault	            France Central
3	crbatmo-esp-appgateway-d-nsg	                    Network security group	    France Central
4	privatelink.azurewebsites.net	                    Private DNS zone	        Global
5	privatelink.vaultcore.azure.net	                    Private DNS zone	        Global
6	crbatmo-esp-d-em28-agw01-pubip01	                Public IP address	        France Central
7	crbatmo-esp-d-em28-agw-vnet	                        Virtual network	            France Central
8	kv-dnslink (privatelink.vaultcore.azure.net/kv-dnslink)	Virtual network link	Global
9	wa-dnslink (privatelink.azurewebsites.net/wa-dnslink)	Virtual network link	Global
			
####Additional Configuration changes done using the pipeline "appgw-terraform-networking"####		
			
1	Peering Appgw Vnet and AppService Vnet		
2	Link appgw to the Log analytics workspace		
3	Granting permissions to managed identity "crbatmo-esp-d-em28-agw01-uai" to read and write keyvault "crbatmo-esp-d-em28-kv"		
4	Adding appgw subnet "crbatmo-esp-d-em28-agw-subn1" in "crbatmo-esp-d-em28-agw-vnet"		
5	Attaching NSG "crbatmo-esp-appgateway-d-nsg" to appgw subnet "crbatmo-esp-d-em28-agw-subn1"		
6	Adding backend pools to app gateway		
7	Configuring SSL certificate to be retrieved from the keyvault and passing the value to the backend pool of app gateway.		
8	Adding a "A" record of webapp in the record sets of DNS "privatelink.azurewebsites.net"		
9	Adding Vnet link "wa-dnslink (privatelink.azurewebsites.net/wa-dnslink)" in the private dns zone "privatelink.azurewebsites.net"		
10	Adding a "A" record of keyvault in the record sets of DNS "privatelink.vaultcore.azure.net"		
11	Adding Vnet link "kv-dnslink (privatelink.vaultcore.azure.net/kv-dnslink)" in the private dns zone "privatelink.vaultcore.azure.net"		
