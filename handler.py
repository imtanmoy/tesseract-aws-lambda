import base64
import io
import json
import os

import pytesseract
from PIL import Image

if os.getenv('AWS_EXECUTION_ENV') is not None:
    os.environ['LD_LIBRARY_PATH'] = '/opt/lib'
    os.environ['TESSDATA_PREFIX'] = '/opt/tessdata'
    pytesseract.pytesseract.tesseract_cmd = '/opt/tesseract'


def ocr(event, context):
    request_body = json.loads(event['body'])
    image = io.BytesIO(base64.b64decode(request_body['image64']))

    text = pytesseract.image_to_string(Image.open(image), config='--psm 6 --oem 3')

    body = {
        "text": text
    }

    response = {
        "statusCode": 200,
        'headers': {'Content-Type': 'application/json'},
        "body": json.dumps(body)
    }

    return response
