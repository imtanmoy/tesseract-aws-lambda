# Tesseract OCR on AWS Lambda

AWS Lambda function to run tesseract OCR

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

The idea is to use a docker container to simulate an AWS lambda environment this allows to build binaries against AWS lambda linux env.
In this example I have build [leptonica](http://www.leptonica.com/) and [Tesseract Open Source OCR Engine](https://github.com/tesseract-ocr/tesseract).

The whole idea is leveraged from [here](https://typless.com/tesseract-on-aws-lambda-ocr-as-a-service/)

### Prerequisites

In order to get started you need docker.
This is a very basic lamdba example and was tested on AWS Lambda Python3.8 environment.
AWS deployment will be automated using [serverless framework](https://serverless.com/)


#### Install the serverless framework

```bash
# Install serverless globally
npm install serverless -g
```

##### Generate AWS access keys

Follow the AWS [tutorial](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/) to create access keys
for your user.

##### Setup AWS access keys with serverless framework

Follow the Serverless [tutorial](https://www.serverless.com/framework/docs/providers/aws/cli-reference/config-credentials/)

##### Building tesseract in Docker
```bash
docker build -t tesseract .
mkdir build
docker run -v $PWD/build:/tmp/build tesseract sh /tmp/build_tesseract.sh
```

##### Create a Lambda layer
```bash
mkdir layer
unzip build/tesseract.zip -d layer
mkdir -p layer/python/lib/python3.8/site-packages/
pip install pytesseract -t layer/python/lib/python3.8/site-packages/
```

##### Verify the folder layer has been created and contains the following folders
```bash
ls layer
tesseract #compiled tesseract binary
tessdata #tesseract language package eng
lib #compiled lib dependencies
python #python dependencies
```

##### Package the lambda layer
```bash
serverless package
```

##### Deploy Tesseract on AWS Lambda
```bash
serverless deploy
```

##### Test OCR Lambda function
The lambda function is accepting json post request
The URl will be which was printed from serverless deploy command
```json
{
  "image64": "base64 encoded image"
}
```


## Built With

* [Tesseract Open Source OCR Engine](https://github.com/tesseract-ocr/tesseract)
* [leptonica](http://www.leptonica.com/)
* [Docker](https://www.docker.com/)
* [Serverless](https://serverless.com/)