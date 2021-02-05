# governance-script-template-spec-version

This is an updated version of **governance-script** repo (https://github.com/onemtc/governance-script), which uses Template Specs instead of Blueprints. 

## Using Both Repos

The **governance-script** repo details how to deploy code to Azure into test, preprod, and production environments, using IaC with GitHub actions for Test Deployment.  For Preprod/Prod deployment, the code is deployed through actions, but the infrastructure is placed in Azure through Azure Blueprints.  Azure Blueprints should be demo'd along with the **governance-script demo**, so you can show all the goodness of GitHub actions, as well as the advanced features of Azure Blueprints/

This repo substitutes Azure Template Specs for Azure Blueprints.  However, as of this writing Template Specs is in preview and the functionality provided is much, much smaller than that of Azure Blueprints, and there is no direct link available between the two.  This repo should be used to demo the future of ARM Template handline within Azure, but it is not currently a replacement for Azure Blueprints.

General documentation is here:

[Azure Blueprints](https://docs.microsoft.com/en-us/azure/governance/blueprints/overview)

[Azure Template Specs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell)

A full overview of the **governance-script demo** can be found here 

[CET Catalog Entry](https://microsoft.sharepoint.com/teams/cecontent/SitePages/Azure%20Environment%20Governance%20with%20GitHub%20and%20Azure%20Blueprints.aspx)

With the exception of the video walkthrough, all of the other artifacts from the CET Catalog are also stored in the repo

## This Repo
