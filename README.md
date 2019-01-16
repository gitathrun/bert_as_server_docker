# BERT-AS-SERVICE docker image #

## Contact ##

Contact: [Teng Fu](teng.fu@teleware.com)

## Base Image ##
This is the docker image for web scrapy, its baseImage is:

__FROM tensorflow/tensorflow:1.12.0-gpu-py3__

The original Dockerfile is from [hanxiao's GitHub repo](https://github.com/hanxiao/bert-as-service/blob/master/docker/Dockerfile)

## Additional installed packages ##

Core package:

-  bert-serving-server __1.7.0__
-  use pip for installation
-  pretrained bert model: BERT-Large, Cased	24-layer, 1024-hidden, 16-heads, 340M parameters
-  [BERT-Large download link](https://storage.googleapis.com/bert_models/2018_10_18/cased_L-24_H-1024_A-16.zip)
-  pre-trained model directory path within docker image: __~/bert_model/__

Tensorflow installed:

-  Tensorflow: 1.12


## Docker Registry Repo ##

-  tfwdockerhub/bert_as_service_server:latest

## Usage ##
on dsvm-gpu virtual machines

```
sudo docker pull tftwdockerhub/bert_as_service_server:latest
```

remember the target __VM__ port is __8888__ and __8889__
docker image exposed port is __5555__ and __5556__

the "2" at the end of the "docker run" means the number of workers in the server initialisation stage.

```
sudo docker run --runtime nvidia -it -p 8888:5555 -p 8889:5556 -t tftwdockerhub/bert_as_server_docker:latest 2
```

In the original instruction
```
docker build -t bert-as-service -f ./docker/Dockerfile .
NUM_WORKER=1
PATH_MODEL=/PATH_TO/_YOUR_MODEL/
docker run --runtime nvidia -dit -p 5555:5555 -p 5556:5556 -v $PATH_MODEL:/model -t bert-as-service $NUM_WORKER
```

For BERT-Client usage:

-  install bert-client
-  initial bert-client class (two-ports, remember to set the version check flag to False)
-  ready the sentence list
-  request the sentences encode vectors.