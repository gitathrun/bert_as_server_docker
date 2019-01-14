# for a docker image with:
# tensorflow-gpu-1.12-py3

# ---- bert-as-service-base ---
# -- (installation for this Dockerfile) ---
# bert-serving-server

FROM tensorflow/tensorflow:1.12.0-gpu-py3

# the maintainer information
LABEL maintainer "TeleWare Data Scientist <teng.fu@teleware.com>"

# download and unzip the pre-trained BERT model
RUN apt-get update --fix-missing && apt-get install -y wget

# directory for unzipped bert model files
RUN mkdir ~/bert_model

RUN wget --quiet https://storage.googleapis.com/bert_models/2018_10_18/cased_L-24_H-1024_A-16.zip -O ~/bert_model.zip && \
	unzip ~/bert_model.zip -d ~/bert_model_unzip && \
	mv ~/bert_model_unzip/*/* ~/bert_model && \
	ls ~/bert_model -lha && \
	chmod -R 777 ~/bert_model && \
	rm ~/bert_model.zip

# bert-serving-server
RUN pip install --no-cache-dir bert-serving-server

# copy into /app
# including the pre-trained model file in ./bert_model
RUN mkdir /ENTRYPOINT
COPY ./entrypoint.sh /ENTRYPOINT

# setup the work dir
WORKDIR /app

# setup the entrypoint
ENTRYPOINT ["/ENTRYPOINT/entrypoint.sh"]
CMD []