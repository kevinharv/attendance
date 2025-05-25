from typing import Any, Dict, TypedDict
import json

# Define type for API GW event
class APIGatewayEvent(TypedDict):
    httpMethod: str
    path: str
    body: str
    headers: Dict[str, str]
    queryStringParameters: Dict[str, str]

def handler(event: APIGatewayEvent, context: Any) -> Dict[str, Any]:
    method: str = event.get("httpMethod", "")
    path: str = event.get("path", "")

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
    
    return {
        "statusCode": 400,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "error": "Invalid request path and/or method."
        })
    }