param($rgroupname="ghgovenv", $location="eastus2", $appServicePlanSpecName="GHGovDemoAppServicePlan", $appServiceSpecName="GHGovDemoAppService", $version="1.0", $appServicePlanTemplate="./AppServicePlanDeployment/azuredeploy.json", $appServiceTemplate="./AppServiceDeployment/azuredeploy.json")

az group create --name $rgroupname --location $location

az ts create --name $appServicePlanSpecName --version $version --resource-group $rgroupname --location $location --template-file $appServicePlanTemplate
az ts create --name $appServiceSpecName --version $version --resource-group $rgroupname --location $location --template-file $appServiceTemplate
