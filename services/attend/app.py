from typing import Any, Dict
from http import HTTPStatus
import json

def handler(event: Any, context: Any) -> Dict[str, Any]:
    print(event)
    print(context)

    method: str = event["requestContext"]["http"]["method"]
    path: str = event["requestContext"]["http"]["path"]

    if method == "GET" and path.startswith("/attend/"):
        code: str = path.strip("/attend/")

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "code": code
            })
        }
    


    # Generate code

    # Redeem code


    
    return {
        "statusCode": 400,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "error": "Invalid request path and/or method."
        })
    }

