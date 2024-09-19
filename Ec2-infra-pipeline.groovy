maxDaysToKeeoLogs = 5
maxNumberOfLogs = 5
gitOrg = "palashpdevops"

environment = [
       ["app_name": "cloudapp"]
  ]

for (env in environments) {
  pipelineJob("${env.app_name}-ec2-Stack") {
    properties {
      githubProjectUrl("got@github.com:/${gitOrg}/tformaws.git")
    }
  logRotator(numToKeep = 10)
  parameters {
       choiceParam("ENV", ['devl','test','pprod','prod'], "Environment")
  }
  definition {
      cpsScm {
         scriptPath("Jenkinsfile")
         scm {
            git {
                remote {
                   branch("master")
                   url("git@github.com:${gitOrg}/tformaws.git")
                }
            }
         }
      }
  }
  }
}  
