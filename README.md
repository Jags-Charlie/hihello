## java-docker-ansible

I'm going to describe how to build up this statck end end flow in this example. Here, I've chosen **Ubuntu** as the operating system.

Requirements

|SERVER| IP ADDRES|
|---|---|
| ubuntu | 192.168.0.10 |

_dependencies_

all the appliction are should running as a container. so you need to install the docker daemon and docker-compose  binary in your local machine. If your not installed in your execution machine please installit first. please follow below the instaructions.

If you are utilising a cloud virtual computer, take note. You must permit all port traffic. If you'd like to restrict access, we can do that later.

_docker installation commands_

```bash
echo -e "\e[1;31mdocker installation"
sudo apt update
sudo apt install curl git -y
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo systemctl start docker
sudo systemctl status docker
```

_docker compose installtion_

```bash
echo -e "\e[1;31mdocker-compose installation"
sudo curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose  version
```

Avoid permission issue you can switch the **root** user.

```bash
sudo -i
```

_copy the source repository to your virtual machine_

```bash
git clone https://github.com/FourTimes/java-docker-ansible.git
cd java-docker-ansible
```
sonar installation

```bash
sudo sysctl vm.max_map_count=262144
cd sonar
bash sonar-installation.sh
```

once execute the command you can validate the docker container status. It should be up and running.

```bash
sudo docker ps 
```

**Note** It should return, up and running status

_sonar login console_

open your browser with http://192.168.0.10:9000

_default credentials_

1. username is **admin**
2. password is **admin** 

it will request to change the default password.

`1`

![image](https://user-images.githubusercontent.com/91359308/181612050-6b8113fa-b00c-4181-9d0f-e4bf49370801.png)

`2`  Create the sonar project click **Manually**

![image](https://user-images.githubusercontent.com/91359308/181612251-1d7f9448-882b-4210-afce-a245d15c146d.png)

`3` Give the project name and other details. finally you should CLICK the **generate** the button

![image](https://user-images.githubusercontent.com/91359308/181612437-b1ea02b7-0d61-4b12-88a5-9bedb10dca81.png)

`4` SELECT **continue**

![image](https://user-images.githubusercontent.com/91359308/181612532-cbc57eb6-21ce-4299-a956-ddd3fe5285ae.png)

`5` SELECT **others** next **Linux**

![image](https://user-images.githubusercontent.com/91359308/181612656-a719c6b7-31ab-475d-ae27-f55633d5b460.png)

copy the sonar project credenatials and **Save** it some we can you use the application integration

`6` SELECT **project** icon 

![image](https://user-images.githubusercontent.com/91359308/181612873-46a2e4eb-252a-414f-a14f-8c573c698ad2.png)

_jenkins installtion_

```bash
cd ..
cd jenkins
sudo bash jenkins-installation.sh
```

once execute the command you can validate the docker container status. It should be up and running.

_jenkins console access_

open your browser with http://192.168.0.10:8080 Once load the jenkins web pages It should ask default password.

_how to find the jenkins default password_

```bash
sudo docker exec -ti jenkins-sonarqube-1 bash
cat /var/jenkins_home/secrets/initialAdminPassword
exit
```

copy the password and login to jenkins

`1` SELECT first option

![image](https://user-images.githubusercontent.com/91359308/181616969-89bca2c7-2269-4794-8d0d-94960f2a5866.png)

`2` It will install the plugin nased on the inital setup

![image](https://user-images.githubusercontent.com/91359308/181617606-47b906dc-7e50-4d0b-bbf7-8513e9a615ef.png)

`3`  Create the initial admin user setup

![image](https://user-images.githubusercontent.com/91359308/181617909-a5c5c212-8bce-4223-bf02-8942106819b9.png)

`4` Configure the instance configuration

![image](https://user-images.githubusercontent.com/91359308/181618030-2918a4b7-23ec-4745-ae7e-6edd7ca18444.png)

`5` Jenkins login page console

![image](https://user-images.githubusercontent.com/57703276/181783138-f2451da6-5d98-4f04-b3c7-c360368f3962.png)

`6` after login you can see the page look like this

![image](https://user-images.githubusercontent.com/57703276/181784834-b9a69eb3-2b40-456e-9227-36975bee5e9f.png)


**create the virtual machine deployment process**

_Create the ssh-keys for key less authetication_

```bash
sudo docker exec -ti jenkins-sonarqube-1 bash
ssh-keygen
cat /root/.ssh/id_rsa.pub
exit

```

login into terget machine 

```bash
ssh username@192.168.0.10
vim ~/.ssh/authorized_keys # paste the id_rsa.pub key from top of the command
exit
```
Note: If this is not executable you cannot connect from ansible server or jenkins to target machine. Here jenkins server act as ansible server.

