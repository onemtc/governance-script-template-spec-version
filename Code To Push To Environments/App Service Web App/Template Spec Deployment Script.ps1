param($specrgroupname="ghgovenv", $preprodrgroupname="ghgovenvpreprod", $prodrgroupname="ghgovenvprod", $appServicePlanSpecName="GHGovDemoAppServicePlan", $appServiceSpecName="GHGovDemoAppService", $version="1.0", $location="eastus2", $subscriptionid="4d34293e-e544-4865-887d-b49c169bf080")

$planid = $(az ts show --name $appServicePlanSpecName --resource-group $specrgroupname --version $version --query "id")
az deployment group create --resource-group $preprodrgroupname --template-spec $planid --parameters name="asplan-topreprodghgovenv" location=$location

$serviceid = $(az ts show --name $appServiceSpecName --resource-group $specrgroupname --version $version --query "id")
az deployment group create --resource-group $preprodrgroupname --template-spec $serviceid --parameters name="as-topreprodghgovenv" location=$location subscriptionId=$subscriptionid hostingPlanName="asplan-topreprodghgovenv" serverFarmResourceGroup=$preprodrgroupname

az deployment group create --resource-group $prodrgroupname --template-spec $planid --parameters name="asplan-toprodghgovenv" location=$location

az deployment group create --resource-group $prodrgroupname --template-spec $serviceid --parameters name="as-toprodghgovenv" location=$location subscriptionId=$subscriptionid hostingPlanName="asplan-toprodghgovenv" serverFarmResourceGroup=$prodrgroupname
