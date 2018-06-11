# Wireshark Docker Container

## Docker

This Docker image deploys Wireshark's terminal-based network analyzer tshark within a CentOS 7 based container. Packets are outputted in JSON format to the ```packets.json``` file for parsing by JSON based tools such as the ELK stack. 

For deploying Wireshark within a Docker container, please first confirm your network interface and wireshark version number in the ```Dockerfile``` environment variables. After building/pulling Wireshark, please use the command below to run it locally:

```
sudo docker run --name wireshark -itd --cap-add NET_RAW --cap-add NET_ADMIN --network host wireshark
```

## Kubernetes

For deploying Wireshark  on a Kubernetes cluster, you will need to add the following capabilities:

* NET_ADMIN
* NET_RAW

If you're looking for more opensource containerized tools, take a look at https://github.com/sealingtech/EDCOP for a fully automated network security platform that utilizes Docker and Kubernetes for deployments and scaling!

