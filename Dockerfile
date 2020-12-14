# for a docker image with:
# tensorflow-gpu-1.12-py3

# ---- bert-as-service-base ---
# -- (installation for this Dockerfile) ---
# bert-serving-server

FROM tensorflow/tensorflow:1.12.3-py3

# the maintainer information
LABEL maintainer "TeleWare Data Scientist <teng.fu@teleware.com>"

# download and unzip the pre-trained BERT model
RUN apt-get update --fix-missing && apt-get install -y wget

RUN pip install bert-serving-server[http]

# directory for unzipped bert model files
RUN mkdir ~/bert_model
RUN mkdir /model

RUN wget --quiet https://storage.googleapis.com/bert_models/2018_10_18/uncased_L-12_H-768_A-12.zip -O ~/bert_model.zip && \
	unzip ~/bert_model.zip -d ~/bert_model_unzip && \
	mv ~/bert_model_unzip/*/* /model && \
	ls /model -lha && \
	chmod -R 777 /model && \
	rm ~/bert_model.zip


# copy into /app
# including the pre-trained model file in ./bert_model
RUN mkdir -p /app
COPY ./entrypoint.sh /app
RUN chmod +x /app/entrypoint.sh

# setup the work dir
WORKDIR /app

# setup the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
CMD []
HEALTHCHECK --timeout=5s CMD curl -f http://localhost:8125/status/server || exit 1