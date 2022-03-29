# Solution

## Designing

1. A simple web page that displays lorem ipsum text when loaded.
2. Terraform is used to create infra to deploy the web app.
3. The webapp is containrised using docker container and deployed in ec2 instance.
4. The ec2 instances can be added to an autoscaling group  for it to be automatically scale in and out according to load.
5. To create infra and run the app,

    ```bash
    $ cd infra
    $ terraform init
    $ terraform apply --auto-approve
    ```
 6. To test
    ```bash
    $ curl $(echo $(terraform output alb_dns_name) | tr -d '"')
    ```
    
## Troubleshooting

1. The docker-stack.yaml file has incorrect spelling for challenge in image name haproxy-challenge.
2. Corrected build.sh to tag correct image haproxy-challenge:1.8 instead of haproxy:1.8
