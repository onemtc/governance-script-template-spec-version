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

Assuming that you are familiar with the **governance-script demo**, this demo is very similar.  The differences are:

1. Instead of demoing Azure Blueprints, you demo Azure Template Specs.  The instructions contain PowerShell scripts for demoing Template Specs.  You could alternatively use the Azure Portal.  We'll leave Portal instructions as an exercise for the student.
2. The workflow also demonstrates GitHub Manual Approvals

### Instructions

1. You need to configure this with an Azure account.  It is not supplied.  However, the costs are truely minimal, so you can use yor AIA or Center subscription.
2. Copy/clone the repo.  If you are not putting it in GH Enterprise, you need to make it public if you want to run manual approvals. 

Note that there are three actions that you may want to modify when you are setting up this demo.  These are:

* gu_deploytotest.yml
* gu_deploytopreprod.yml
* gu_deploytoprod.yml

Or if you follow the example configuration, you could use them as is.

3. In this repo, you will find a script \Code To Push To Environments\App Service Web App\Template Spec Creation Script.ps1

It take the following parameters, and is set up with the following defaults:

    param($rgroupname="ghgovenv", $location="eastus2", $appServicePlanSpecName="GHGovDemoAppServicePlan", $appServiceSpecName="GHGovDemoAppService", $version="1.0", $appServicePlanTemplate="./AppServicePlanDeployment/azuredeploy.json", $appServiceTemplate="./AppServiceDeployment/azuredeploy.json")

The Template Spec names ance version swill be stored in Azure Table storage in step #5.  You can use whatever values you desire.  You can also use any resource group for them, but the resource group must exist.

4. Once the Template Specs are created, you can deploy them using the script \Code To Push To Environments\App Service Web App\Template Spec Deployment Script.ps1

You can change the parameters, if you desire, but the spec names, versions, and spec resource group need to match the creation script.

    param($specrgroupname="ghgovenv", $preprodrgroupname="ghgovenvpreprod", $prodrgroupname="ghgovenvprod", $appServicePlanSpecName="GHGovDemoAppServicePlan", $appServiceSpecName="GHGovDemoAppService", $version="1.0", $location="eastus2", $subscriptionid="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")
    


5. You will need to set up table storage in Azure to hold variables used by the actions.  This is detailed in the **governance-script-demo**.  For this repo, we merely added 4 new variables to the table storage:

* appserviceplantemplatespec
* appserviceplantemplatespecversion
* appservicetemplatespec
* appservicetemplatespecversion

Which sshould match up with what you used in steps #3 and #4, above.



	 Create a secret with your Azure Service Principal.  If you do not want to change the actions, you'd need to call it: PF_AZURE_CREDENTIALS
	Create a PAT.  If you don't want to change the actions, you'd need to call it: REPO_DISPATCH.  It needs full permissions on the repo, but that's it.  Remeber to enable SSO for OneMtc
	If you want to demo manual approvals, create an environment called govdemo.  There is one there already, but I do not think environments come over on a clone.  Add a reviewer
	You need to create table storage with variables.  The instructions for this are in the original instructions.  You use the same table storage for both, but with 4 more variables added under teh "totestvariables" partition: appserviceplantemplatespec, appserviceplantemplatespecversion, appservicetemplatespec, and appservicetemplatespecversion.  These are the names and version of the template specs that you are going to create
	There are two scripts.  The first creates the template specs.  Run this from your local machine.  You may have to change the parameters, to match your azure resource groups and the above names and versions.  It's powershell calling CLI, real simple.  The second creates the app service plan and app service for preprod and prod.  Test is created a IaC from the action.
	Then just run the test action.  It should run all three, creating the environment from scratch for test, and just pushing the code for preprod and prod.  You should get a manual approval request before both preprod and prod are run.


