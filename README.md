# governance-script-template-spec-version

This is an updated version of **governance-script** repo (https://github.com/onemtc/governance-script), which uses Template Specs instead of Blueprints. 

## Using Both Repos

The **governance-script** repo details how to deploy code to Azure into test, preprod, and production environments, using IaC with GitHub actions for Test Deployment.  For Preprod/Prod deployment, the code is deployed through actions, but the infrastructure is placed in Azure through Azure Blueprints.  Azure Blueprints should be demo'd along with the **governance-script demo**, so you can show all the goodness of GitHub actions, as well as the advanced features of Azure Blueprints/

This repo substitutes Azure Template Specs for Azure Blueprints.  However, as of this writing Template Specs functionality provided is not the same as that of Azure Blueprints, and there is no direct link available between the two.  This repo should be used to demo the future of ARM Template handling within Azure, but it is not currently a replacement for Azure Blueprints.

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

The Template Spec names ance version swill be stored in Azure Table storage in step #5.  You can use whatever values you desire.  You can also use any resource group for them, but the resource group must exist.  Log in to the CLI from a local PowerShell window to run the script.

4. Once the Template Specs are created, you can deploy them using the script \Code To Push To Environments\App Service Web App\Template Spec Deployment Script.ps1

You can change the parameters, if you desire, but the spec names, versions, and spec resource group need to match the creation script.  You **must** put the subscriptionId in, as this is the subscription to which you are deploying.  For this demo, you are probably deploying to the same subscription under which you are logged in, but the Template Spec API requires it to be specificed

    param($specrgroupname="ghgovenv", $preprodrgroupname="ghgovenvpreprod", $prodrgroupname="ghgovenvprod", $appServicePlanSpecName="GHGovDemoAppServicePlan", $appServiceSpecName="GHGovDemoAppService", $version="1.0", $location="eastus2", $subscriptionid="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")
    
For the demo, it may be advantageous to have preprod already set up, but then show the customers how you deploy to prod.    

5. You will need to set up table storage in Azure to hold variables used by the actions.  This is detailed in the **governance-script-demo**.  For this repo, we merely added 4 new variables to the table storage:

* appserviceplantemplatespec
* appserviceplantemplatespecversion
* appservicetemplatespec
* appservicetemplatespecversion

Which must match up with what you used in steps #3 and #4, above.

A working configuration looks like:

![Table Storave Variable Example](/images/GH-Table-Storage-Variables.png)

Note that at the top if each if the actions, the parameters that define the location of table storage are specified.  You will need to make sure the actions match the actual location and storage parameters:

* baselineResourceGroup: ghgovenv
* baselineVariableStorageAccountName: ghgovenvnotsecrets
* baselineVariableTableName: pipelinevariables
* baselineTablePartitionKey: totestvariables

6.  Create an Azure Service Principal in the CLI.

Use az ad sp create-for-rbac for this.  An example is:

    az ad sp create-for-rbac --name "myApp" --role contributor --scopes /subscriptions/<subscription-id>/resourceGroups/<group-name> --sdk-auth
    
Then take the entire output and store it as a GitHub Secret in your repo called **AZURE_CREDENTIALS**.  If you store it with a different name, you must modify the three actions to match

7.  Create a PAT in the GitHub developer interface.  Call it **REPO_DISPATCH** or else you will need to modify the actions to match.  It needs full permissions on the repo, but that's it.  If you are doing this in OneMtc, you must Enable SSO.
8.  If you want to demo manual approvals, create an environment called govdemo.  Add up to 6 reviewers.  Note that the approval options are limited, all that is available is 1) 1 of (up to) 6 users approving allow the action to be approved, and 2) if not approved in 30 days, the action is cancelled.  No other durations are supported.

And you are done.  If you run the test action from the GitHub Actions web page, it will run, deploy the environment, and then deploy the code.  There will be a manual approval wait, and once approved, preprod will run and deploy the code to the environment deployed by the Template Spec.  Prod then mimics preprod.  Note that if you run preprod or prod directly from the actions page, the first thing it will do is wait for approval, even if you are an approver.



