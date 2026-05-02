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

# Repo information: Common-terraform-infrastructure
This repo contains the terraform code to deploy 
1. App service Plan
2. Azure Database for MySQL flexible server
3. Key vault
4. Managed identity for common-uai (for infrastructure)
5. Storage account and blob
6. 3-Private endpoints and 3-nic for DB, Key vault and storage account
7. Keyvault.tf configurs access policy and allow managed identity common-uai to get the keys and secrets. Also, Private endpoint is enabled.