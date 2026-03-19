## Full CI Pipeline Setup in Azure DevOps – One Pipeline per Microservice
Microservices: vote, worker, results
Each microservice will have its own CI pipeline, Docker build, and push to Azure Container Registry (ACR).

1️⃣ Create an Organization
1.	Go to Azure DevOps.
2.	Click New Organization.
3.	Enter an organization name, e.g., MyCompanyOrg.
4.	Choose the Azure region closest to your location.

2️⃣ Create a Project
1.	Inside the organization, click New Project.
2.	Enter the project name, e.g., VotingAppProject.
3.	Select visibility (Private or Public).
4.	Choose Git as the version control system.

3️⃣ Import the Git Repository
1.	Navigate to Repos → Import.
2.	Paste the GitHub repository URL:
https://github.com/dockersamples/example-voting-app.git
3.	Click Import.
Set Default Branch:
•	Go to Repos → Branches → main, right-click → Set as default branch

4️⃣ Add a Self-Hosted Agent (Optional but Recommended)
1.	Navigate to Project Settings → Agent Pools → Default (or create a new pool).
2.	Click New Agent → select OS → download the agent.
3.	Extract the agent and configure it:
./config.sh  # Linux/macOS
.\config.cmd # Windows
4.	Enter Azure DevOps URL, Agent Pool, and Personal Access Token (PAT).
5.	Start the agent → it will appear online in Azure DevOps.
Using a self-hosted agent avoids hosted parallelism limits and gives more control over builds.
https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-agent?view=azure-devops&tabs=IP-V4#remove-and-reconfigure-an-agent
